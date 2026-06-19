param(
    [string]$SourceRoot = (Join-Path $PSScriptRoot '..\Sources'),
    [string]$OutputRoot = (Join-Path $PSScriptRoot '..\Résume\ChatGPT\V1')
)

$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.IO.Compression.FileSystem

$SourceRoot = [IO.Path]::GetFullPath($SourceRoot)
$OutputRoot = [IO.Path]::GetFullPath($OutputRoot)
$ProjectRoot = [IO.Path]::GetFullPath((Join-Path $SourceRoot '..'))
$utf8 = New-Object Text.UTF8Encoding($false)
$wNs = 'http://schemas.openxmlformats.org/wordprocessingml/2006/main'
$rNs = 'http://schemas.openxmlformats.org/officeDocument/2006/relationships'
$aNs = 'http://schemas.openxmlformats.org/drawingml/2006/main'

function Write-Utf8([string]$Path, [string]$Text) {
    $parent = Split-Path -Parent $Path
    if ($parent) { [IO.Directory]::CreateDirectory($parent) | Out-Null }
    [IO.File]::WriteAllText($Path, $Text, $utf8)
}

function Relative-Path([string]$FromDirectory, [string]$ToPath) {
    $from = New-Object Uri(([IO.Path]::GetFullPath($FromDirectory).TrimEnd('\') + '\'))
    $to = New-Object Uri([IO.Path]::GetFullPath($ToPath))
    return [Uri]::UnescapeDataString($from.MakeRelativeUri($to).ToString())
}

function Md-Escape([string]$Text) {
    if ($null -eq $Text) { return '' }
    return $Text.Replace('\', '\\').Replace('|', '\|')
}

function Md-LinkPath([string]$Path) {
    return $Path.Replace(' ', '%20').Replace('#', '%23')
}

function Read-ZipText($Zip, [string]$Name) {
    $entry = $Zip.GetEntry($Name)
    if (-not $entry) { return $null }
    $reader = New-Object IO.StreamReader($entry.Open(), [Text.Encoding]::UTF8)
    try { return $reader.ReadToEnd() } finally { $reader.Dispose() }
}

function New-NamespaceManager($Xml) {
    $ns = New-Object Xml.XmlNamespaceManager($Xml.NameTable)
    $ns.AddNamespace('w', $wNs)
    $ns.AddNamespace('r', $rNs)
    $ns.AddNamespace('a', $aNs)
    return ,$ns
}

function Get-Attr($Node, [string]$LocalName, [string]$Namespace = $wNs) {
    if (-not $Node) { return '' }
    return $Node.GetAttribute($LocalName, $Namespace)
}

function Get-RunMarkdown($Run, $Ns, $Relationships, [string]$AssetRelative) {
    $parts = New-Object Collections.Generic.List[string]
    foreach ($child in $Run.ChildNodes) {
        switch ($child.LocalName) {
            't' { $parts.Add((Md-Escape $child.InnerText)) }
            'tab' { $parts.Add("`t") }
            'br' { $parts.Add('<br>') }
            'drawing' {
                foreach ($blip in $child.SelectNodes('.//a:blip', $Ns)) {
                    $rid = $blip.GetAttribute('embed', $rNs)
                    if ($rid -and $Relationships.ContainsKey($rid)) {
                        $name = [IO.Path]::GetFileName($Relationships[$rid])
                        $parts.Add("![Image incorporée]($(Md-LinkPath "$AssetRelative/$name"))")
                    }
                }
            }
            'pict' { $parts.Add('[Objet graphique VML — voir le fichier DOCX source]') }
        }
    }
    $text = $parts -join ''
    if (-not $text) { return '' }
    $props = $Run.SelectSingleNode('./w:rPr', $Ns)
    if ($props -and $props.SelectSingleNode('./w:strike', $Ns)) { $text = "~~$text~~" }
    if ($props -and $props.SelectSingleNode('./w:i', $Ns)) { $text = "*$text*" }
    if ($props -and $props.SelectSingleNode('./w:b', $Ns)) { $text = "**$text**" }
    return $text
}

function Get-InlineMarkdown($Node, $Ns, $Relationships, [string]$AssetRelative) {
    $parts = New-Object Collections.Generic.List[string]
    foreach ($child in $Node.ChildNodes) {
        switch ($child.LocalName) {
            'r' { $parts.Add((Get-RunMarkdown $child $Ns $Relationships $AssetRelative)) }
            'hyperlink' {
                $label = Get-InlineMarkdown $child $Ns $Relationships $AssetRelative
                $rid = $child.GetAttribute('id', $rNs)
                if ($rid -and $Relationships.ContainsKey($rid)) {
                    $parts.Add("[$label]($($Relationships[$rid]))")
                } else { $parts.Add($label) }
            }
            'fldSimple' { $parts.Add((Get-InlineMarkdown $child $Ns $Relationships $AssetRelative)) }
            'smartTag' { $parts.Add((Get-InlineMarkdown $child $Ns $Relationships $AssetRelative)) }
            'sdt' { $parts.Add((Get-InlineMarkdown $child $Ns $Relationships $AssetRelative)) }
        }
    }
    return $parts -join ''
}

function Get-ParagraphMarkdown($Paragraph, $Ns, $Relationships, $NumberFormats, [string]$AssetRelative, [switch]$InTable) {
    $text = Get-InlineMarkdown $Paragraph $Ns $Relationships $AssetRelative
    if (-not $text -or $text -eq [char]0xA0) { return '' }
    if ($InTable) { return $text.Replace("`r", '').Replace("`n", '<br>') }

    $sizeNode = $Paragraph.SelectSingleNode('./w:pPr/w:rPr/w:sz | .//w:rPr/w:sz', $Ns)
    $size = 0
    if ($sizeNode) { [int]::TryParse((Get-Attr $sizeNode 'val'), [ref]$size) | Out-Null }
    $numPr = $Paragraph.SelectSingleNode('./w:pPr/w:numPr', $Ns)
    if ($numPr) {
        $levelNode = $numPr.SelectSingleNode('./w:ilvl', $Ns)
        $numNode = $numPr.SelectSingleNode('./w:numId', $Ns)
        $level = 0
        if ($levelNode) { [int]::TryParse((Get-Attr $levelNode 'val'), [ref]$level) | Out-Null }
        $numId = if ($numNode) { Get-Attr $numNode 'val' } else { '' }
        $format = if ($NumberFormats.ContainsKey("$numId/$level")) { $NumberFormats["$numId/$level"] } else { 'bullet' }
        $marker = if ($format -in @('decimal','lowerLetter','upperLetter','lowerRoman','upperRoman')) { '1.' } else { '-' }
        return (('  ' * $level) + "$marker $text")
    }
    $bold = [bool]$Paragraph.SelectSingleNode('.//w:rPr/w:b', $Ns)
    if ($size -ge 40) { return "## $text" }
    if ($bold -and $size -ge 36) { return "### $text" }
    if ($bold -and $size -ge 28) { return "#### $text" }
    return $text
}

function Get-TableMarkdown($Table, $Ns, $Relationships, $NumberFormats, [string]$AssetRelative) {
    $rows = @($Table.SelectNodes('./w:tr', $Ns))
    if ($rows.Count -eq 0) { return '' }
    $matrix = New-Object Collections.Generic.List[object]
    $maxColumns = 0
    foreach ($row in $rows) {
        $cells = New-Object Collections.Generic.List[string]
        foreach ($cell in $row.SelectNodes('./w:tc', $Ns)) {
            $paras = New-Object Collections.Generic.List[string]
            foreach ($p in $cell.SelectNodes('./w:p', $Ns)) {
                $value = Get-ParagraphMarkdown $p $Ns $Relationships $NumberFormats $AssetRelative -InTable
                if ($value) { $paras.Add($value) }
            }
            $cells.Add((($paras -join '<br>').Replace('|','\|')))
        }
        if ($cells.Count -gt $maxColumns) { $maxColumns = $cells.Count }
        $matrix.Add($cells)
    }
    $lines = New-Object Collections.Generic.List[string]
    for ($r = 0; $r -lt $matrix.Count; $r++) {
        $cells = New-Object Collections.Generic.List[string]
        for ($c = 0; $c -lt $maxColumns; $c++) {
            $cells.Add($(if ($c -lt $matrix[$r].Count) { $matrix[$r][$c] } else { '' }))
        }
        $lines.Add('| ' + ($cells -join ' | ') + ' |')
        if ($r -eq 0) { $lines.Add('| ' + ((1..$maxColumns | ForEach-Object { '---' }) -join ' | ') + ' |') }
    }
    return $lines -join "`n"
}

function Convert-Docx([IO.FileInfo]$File, [string]$Destination, [string]$AssetDirectory) {
    $zip = [IO.Compression.ZipFile]::OpenRead($File.FullName)
    try {
        $doc = New-Object Xml.XmlDocument
        $doc.PreserveWhitespace = $true
        $doc.LoadXml((Read-ZipText $zip 'word/document.xml'))
        $ns = New-NamespaceManager $doc

        $relationships = @{}
        $relsText = Read-ZipText $zip 'word/_rels/document.xml.rels'
        if ($relsText) {
            $rels = [xml]$relsText
            foreach ($rel in $rels.Relationships.Relationship) { $relationships[$rel.Id] = [string]$rel.Target }
        }

        $numberFormats = @{}
        $numberingText = Read-ZipText $zip 'word/numbering.xml'
        if ($numberingText) {
            $numbering = New-Object Xml.XmlDocument
            $numbering.LoadXml($numberingText)
            $abstractByNum = @{}
            foreach ($num in $numbering.GetElementsByTagName('num', $wNs)) {
                $numId = Get-Attr $num 'numId'
                $abstractIdNode = $num.GetElementsByTagName('abstractNumId', $wNs) | Select-Object -First 1
                $abstractByNum[$numId] = Get-Attr $abstractIdNode 'val'
            }
            foreach ($abstract in $numbering.GetElementsByTagName('abstractNum', $wNs)) {
                $abstractId = Get-Attr $abstract 'abstractNumId'
                foreach ($numId in @($abstractByNum.Keys | Where-Object { $abstractByNum[$_] -eq $abstractId })) {
                    foreach ($level in $abstract.GetElementsByTagName('lvl', $wNs)) {
                        $levelId = Get-Attr $level 'ilvl'
                        $formatNode = $level.GetElementsByTagName('numFmt', $wNs) | Select-Object -First 1
                        $numberFormats["$numId/$levelId"] = Get-Attr $formatNode 'val'
                    }
                }
            }
        }

        [IO.Directory]::CreateDirectory($AssetDirectory) | Out-Null
        foreach ($entry in $zip.Entries | Where-Object { $_.FullName -like 'word/media/*' }) {
            $target = Join-Path $AssetDirectory ([IO.Path]::GetFileName($entry.FullName))
            [IO.Compression.ZipFileExtensions]::ExtractToFile($entry, $target, $true)
        }

        $assetRelative = Relative-Path (Split-Path -Parent $Destination) $AssetDirectory
        $body = $doc.SelectSingleNode('//w:body', $ns)
        $out = New-Object Collections.Generic.List[string]
        $out.Add("# $($File.BaseName)")
        $out.Add('')
        $out.Add("Source : [$($File.Name)]($(Md-LinkPath (Relative-Path (Split-Path -Parent $Destination) $File.FullName)))")
        $out.Add('')
        $out.Add("> Transcription structurée de l’export DOCX OneNote. L’ordre des paragraphes, listes, tableaux, liens et images est conservé.")
        $out.Add('')
        foreach ($child in $body.ChildNodes) {
            $value = ''
            if ($child.LocalName -eq 'p') { $value = Get-ParagraphMarkdown $child $ns $relationships $numberFormats $assetRelative }
            elseif ($child.LocalName -eq 'tbl') { $value = Get-TableMarkdown $child $ns $relationships $numberFormats $assetRelative }
            if ($value) { $out.Add($value); $out.Add('') }
        }
        Write-Utf8 $Destination (($out -join "`n").TrimEnd() + "`n")

        # Independent plain-text witness: every Word text node, in document order.
        $witness = New-Object Collections.Generic.List[string]
        foreach ($child in $body.ChildNodes) {
            if ($child.LocalName -notin @('p','tbl')) { continue }
            $text = (@($child.SelectNodes('.//w:t', $ns) | ForEach-Object { $_.InnerText }) -join '')
            if ($text.Length -gt 0) { $witness.Add($text) }
        }
        $witnessPath = [IO.Path]::ChangeExtension($Destination, '.texte-integral.txt')
        Write-Utf8 $witnessPath (($witness -join "`n").TrimEnd() + "`n")

        $sourceTextNodes = @($doc.SelectNodes('//w:body//w:t', $ns))
        $sourceChars = ($sourceTextNodes | ForEach-Object { $_.InnerText.Length } | Measure-Object -Sum).Sum
        $witnessChars = ($witness | ForEach-Object { $_.Length } | Measure-Object -Sum).Sum
        return [pscustomobject]@{
            File = $File.Name; TextNodes = $sourceTextNodes.Count; SourceCharacters = $sourceChars
            WitnessCharacters = $witnessChars; Complete = ($sourceChars -eq $witnessChars)
            Media = @($zip.Entries | Where-Object { $_.FullName -like 'word/media/*' }).Count
        }
    } finally { $zip.Dispose() }
}

[IO.Directory]::CreateDirectory($OutputRoot) | Out-Null
foreach ($generatedName in @('OneNote','Notion','GitHub','MANIFESTE.csv','CONTROLE-EXHAUSTIVITE.md','README.md')) {
    $generatedPath = Join-Path $OutputRoot $generatedName
    if (Test-Path -LiteralPath $generatedPath) { Remove-Item -LiteralPath $generatedPath -Recurse -Force }
}

$oneNoteOut = Join-Path $OutputRoot 'OneNote'
$audit = New-Object Collections.Generic.List[object]
foreach ($docx in Get-ChildItem (Join-Path $SourceRoot 'OneNote\.Docx\*.docx') | Sort-Object Name) {
    $destination = Join-Path $oneNoteOut ($docx.BaseName + '.md')
    $assets = Join-Path $oneNoteOut ('assets\' + $docx.BaseName)
    $audit.Add((Convert-Docx $docx $destination $assets))
}

$notionSource = Join-Path $SourceRoot 'Notion'
$notionOut = Join-Path $OutputRoot 'Notion'
[IO.Directory]::CreateDirectory($notionOut) | Out-Null
Get-ChildItem -LiteralPath $notionSource -Force | Copy-Item -Destination $notionOut -Recurse -Force

$githubOut = Join-Path $OutputRoot 'GitHub'
[IO.Directory]::CreateDirectory($githubOut) | Out-Null
Get-ChildItem -LiteralPath (Join-Path $SourceRoot 'Github') -Force | Copy-Item -Destination $githubOut -Recurse -Force

$manifestRows = New-Object Collections.Generic.List[object]
foreach ($file in Get-ChildItem $SourceRoot -Recurse -File | Sort-Object FullName) {
    $manifestRows.Add([pscustomobject]@{
        Source = Relative-Path $ProjectRoot $file.FullName
        Bytes = $file.Length
        SHA256 = (Get-FileHash $file.FullName -Algorithm SHA256).Hash
        Restitution = if ($file.Extension -eq '.docx') { "OneNote/$($file.BaseName).md" } elseif ($file.FullName.StartsWith($notionSource)) { Relative-Path $OutputRoot (Join-Path $notionOut ($file.FullName.Substring($notionSource.Length).TrimStart('\'))) } elseif ($file.FullName -like '*\Github\*') { Relative-Path $OutputRoot (Join-Path $githubOut $file.Name) } else { 'Conservé dans Sources (binaire de référence)' }
    })
}
$manifestPath = Join-Path $OutputRoot 'MANIFESTE.csv'
$manifestRows | Export-Csv -LiteralPath $manifestPath -NoTypeInformation -Encoding UTF8

$auditLines = @(
    "# Contrôle d’exhaustivité", '',
    'Chaque export DOCX a été lu directement depuis `word/document.xml`. Le témoin `.texte-integral.txt` contient tous les nœuds textuels `w:t`, dans leur ordre documentaire.', '',
    '| Export | Nœuds texte | Caractères source | Caractères témoin | Identiques | Médias extraits |',
    '|---|---:|---:|---:|:---:|---:|'
)
foreach ($row in $audit) { $auditLines += "| $($row.File) | $($row.TextNodes) | $($row.SourceCharacters) | $($row.WitnessCharacters) | $($row.Complete) | $($row.Media) |" }
$auditLines += @('', "Les fichiers `.one` restent les binaires de référence. Leur export DOCX homonyme est la source de la transcription, l’API OneNote n’étant pas disponible dans cet environnement.", '')
Write-Utf8 (Join-Path $OutputRoot 'CONTROLE-EXHAUSTIVITE.md') ($auditLines -join "`n")

$readme = @'
# Restitution complète des projets de jeux — V1

Cette restitution conserve le corpus sous trois vues complémentaires :

- `OneNote/` : transcription structurée de chaque section, plus un témoin texte intégral et les images incorporées ;
- `Notion/` : export original intégral (Markdown, CSV et images), sans réécriture ;
- `GitHub/` : document du projet GitHub, sans réécriture ;
- `MANIFESTE.csv` : inventaire de chaque source avec taille, empreinte SHA-256 et destination ;
- `CONTROLE-EXHAUSTIVITE.md` : preuve quantitative de couverture des textes DOCX.
- [Analyse transversale](ANALYSE-TRANSVERSALE.md) : familles de projets, maturité et liens entre les différentes sources.

## Accès rapide

### OneNote

- [Général](OneNote/Général.md)
- [Sport — BOXE](OneNote/Sport%20-%20BOXE.md)
- [Sport — Volley](OneNote/Sport%20-%20Volley.md)
- [Stratégie — KINGDOMS](OneNote/Stratégie%20-%20KINGDOMS.md)
- [Village](OneNote/Village.md)
- [WAFE — Banalités](OneNote/WAFE%20-%20Banalités.md)
- [WAFE — Donjon](OneNote/WAFE%20-%20Donjon.md)
- [WAFE — King battle](OneNote/WAFE%20-%20King%20battle.md)
- [WAFE — LandProtect](OneNote/WAFE%20-%20LandProtect.md)
- [WAFE](OneNote/WAFE.md)
- [YNSECTS](OneNote/YNSECTS.md)

### Autres exports

- [Projet GitHub — Sheepering](GitHub/Sheepering.md)
- [Catalogue Notion](Notion/Liste%20des%20jeux%2014f78fb2cc9180b7a3e8dd05c57df425.csv)
- [Pages Notion](Notion/Liste%20des%20jeux/)

## Règle de fidélité

La synthèse et l’organisation servent de navigation ; elles ne remplacent jamais les transcriptions intégrales. En cas d’ambiguïté de mise en forme, le DOCX puis le fichier `.one` homonyme dans `Sources/OneNote` font foi.
'@
Write-Utf8 (Join-Path $OutputRoot 'README.md') $readme

if (@($audit | Where-Object { -not $_.Complete }).Count -gt 0) { throw 'Le contrôle textuel DOCX a échoué.' }
Write-Output "Restitution generated: $OutputRoot"
Write-Output "Source files: $($manifestRows.Count); DOCX complete: $($audit.Count)/$($audit.Count)"
