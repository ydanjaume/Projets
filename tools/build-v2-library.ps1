param(
    [string]$ProjectRoot = (Join-Path $PSScriptRoot '..')
)

$ErrorActionPreference = 'Stop'
$ProjectRoot = [IO.Path]::GetFullPath($ProjectRoot)
$V1 = Join-Path $ProjectRoot 'Résume\ChatGPT\V1'
$Out = Join-Path $ProjectRoot 'Résume\ChatGPT\V2'
$Library = Join-Path $Out 'Bibliotheque'
$Assets = Join-Path $Out 'assets'
$Meta = Join-Path $Out '_meta'
$utf8 = New-Object Text.UTF8Encoding($false)

function Read-Utf8([string]$Path) { return [IO.File]::ReadAllText($Path, [Text.Encoding]::UTF8) }
function Write-Utf8([string]$Path, [string]$Text) {
    [IO.Directory]::CreateDirectory((Split-Path -Parent $Path)) | Out-Null
    [IO.File]::WriteAllText($Path, ($Text.TrimEnd() + "`n"), $utf8)
}
function Table-Escape([string]$Text) {
    if ($null -eq $Text) { return '' }
    return $Text.Replace('|','\|').Replace("`r",'').Replace("`n",'<br>')
}
function Clean-Markdown([string]$Text) {
    $lines = $Text -split "`r?`n"
    for ($i=0; $i -lt $lines.Count; $i++) {
        if ($lines[$i] -match '\*{4,}') { $lines[$i] = $lines[$i].Replace('*','') }
    }
    return (($lines -join "`n").Replace(')![', ")`n`n!["))
}
function Normalize-Sheepering([string]$Text) {
    $lines = $Text -split "`r?`n"
    for ($i=1; $i -lt $lines.Count; $i++) {
        if ($lines[$i] -match '^(#{1,5})\s') { $lines[$i] = '#' + $lines[$i] }
    }
    return $lines -join "`n"
}
function Strip-OneNote([string]$Path, [string]$Title) {
    $lines = (Read-Utf8 $Path) -split "`r?`n"
    $quote = -1
    for ($i=0; $i -lt $lines.Count; $i++) { if ($lines[$i] -like '> Transcription structurée*') { $quote=$i; break } }
    if ($quote -lt 0) { throw "Preamble not found: $Path" }
    $body = $lines[($quote+1)..($lines.Count-1)] -join "`n"
    return Clean-Markdown ("# $Title`n`n" + $body.Trim())
}
function Convert-Notion([string]$Path, [string]$AssetPrefix = '') {
    $lines = (Read-Utf8 $Path) -split "`r?`n"
    $title = $lines[0] -replace '^#\s+',''
    $metadata = New-Object Collections.Generic.List[object]
    $i = 1
    while ($i -lt $lines.Count -and -not $lines[$i].Trim()) { $i++ }
    while ($i -lt $lines.Count -and $lines[$i] -match '^([^:]+):\s*(.*)$') {
        $metadata.Add([pscustomobject]@{Name=$matches[1];Value=$matches[2]})
        $i++
    }
    while ($i -lt $lines.Count -and -not $lines[$i].Trim()) { $i++ }
    $out = New-Object Collections.Generic.List[string]
    $out.Add("# $title")
    if ($metadata.Count -gt 0) {
        $out.Add(''); $out.Add('## Fiche projet'); $out.Add('')
        $out.Add('| Propriété | Valeur |'); $out.Add('|---|---|')
        foreach ($item in $metadata) { $out.Add("| $(Table-Escape $item.Name) | $(Table-Escape $item.Value) |") }
    }
    if ($i -lt $lines.Count) { $out.Add(''); $out.Add(($lines[$i..($lines.Count-1)] -join "`n").Trim()) }
    $text = $out -join "`n"
    if ($AssetPrefix) {
        $text = $text.Replace('Base%20et%20de%20survie/', $AssetPrefix)
    }
    return $text
}
function Write-OneNote([string]$SourceName, [string]$Destination, [string]$Title, [hashtable]$Replacements = @{}) {
    $text = Strip-OneNote (Join-Path $V1 "OneNote\$SourceName.md") $Title
    foreach ($key in $Replacements.Keys) { $text = $text.Replace($key, $Replacements[$key]) }
    Write-Utf8 (Join-Path $Library $Destination) $text
}
function Write-Notion([string]$Pattern, [string]$Destination, [string]$AssetPrefix = '') {
    $source = Get-ChildItem (Join-Path $V1 'Notion\Liste des jeux') -Filter "$Pattern*.md" | Select-Object -First 1
    if (-not $source) { throw "Notion page not found: $Pattern" }
    Write-Utf8 (Join-Path $Library $Destination) (Convert-Notion $source.FullName $AssetPrefix)
}

if (Test-Path -LiteralPath $Out) { Remove-Item -LiteralPath $Out -Recurse -Force }
[IO.Directory]::CreateDirectory($Library) | Out-Null
[IO.Directory]::CreateDirectory($Assets) | Out-Null
[IO.Directory]::CreateDirectory($Meta) | Out-Null

# Standalone and shared projects.
Write-Utf8 (Join-Path $Library '01-Sheepering.md') (Normalize-Sheepering (Read-Utf8 (Join-Path $V1 'GitHub\Sheepering.md')))
Write-OneNote 'Sport - BOXE' '02-Boxe.md' 'Jeu de cartes de boxe'
Write-OneNote 'Stratégie - KINGDOMS' '03-Kingdoms.md' 'KINGDOMS — stratégie sur hexagones'
Write-Notion 'Base et de survie ' '04-Base-et-survie.md' '../assets/base-et-survie/'
Write-OneNote 'Village' '05-Village.md' 'Village'
Write-Notion 'Donjon à plusieurs ' '06-Donjon-a-plusieurs.md'
Write-Notion 'Gestion de Flore Faune ' '07-Gestion-foret.md'
Write-Notion 'Jeu sur les sens ' '08-Jeu-sur-les-sens.md'
Write-Notion 'Jeux de type ' '09-Jeu-type-Reign.md'
Write-Notion 'Jeu abeille ' '10-Abeilles-gestion-equipe.md'
Write-OneNote 'YNSECTS' '11-YNSECTS.md' 'YNSECTS' @{'assets/YNSECTS/'='../assets/ynsects/'}
Write-OneNote 'Général' '12-Ressources-et-inspirations.md' 'Ressources, matériel et inspirations'

# Volley: merge the actual Notion fiche and the otherwise empty OneNote page.
$volleyNotion = Get-ChildItem (Join-Path $V1 'Notion\Liste des jeux') -Filter 'Match de volley *.md' | Select-Object -First 1
$volley = Convert-Notion $volleyNotion.FullName
$volleyOneNote = Strip-OneNote (Join-Path $V1 'OneNote\Sport - Volley.md') 'Notes OneNote'
$volleyOneNote = $volleyOneNote -replace '^# Notes OneNote\s*',''
Write-Utf8 (Join-Path $Library '13-Volley.md') ($volley + "`n`n## Notes OneNote`n`n" + $volleyOneNote.Trim())

# WAFE remains one project family, split into workable modules.
$wafeDir = Join-Path $Library 'WAFE'
[IO.Directory]::CreateDirectory($wafeDir) | Out-Null
Write-OneNote 'WAFE' 'WAFE\01-Univers-et-systeme.md' 'WAFE — univers et système' @{'assets/WAFE/'='../../assets/wafe/'}
Write-OneNote 'WAFE - Banalités' 'WAFE\02-Regles-communes.md' 'WAFE — règles communes'
Write-OneNote 'WAFE - Donjon' 'WAFE\03-Donjon.md' 'WAFE — Donjon' @{'assets/WAFE%20-%20Donjon/'='../../assets/wafe-donjon/';'assets/WAFE - Donjon/'='../../assets/wafe-donjon/'}
Write-OneNote 'WAFE - King battle' 'WAFE\04-King-Battle.md' 'WAFE — King Battle'
Write-OneNote 'WAFE - LandProtect' 'WAFE\05-LandProtect.md' 'WAFE — LandProtect'

# Media used by the Markdown library.
Copy-Item -LiteralPath (Join-Path $V1 'Notion\Liste des jeux\Base et de survie') -Destination (Join-Path $Assets 'base-et-survie') -Recurse
Copy-Item -LiteralPath (Join-Path $V1 'OneNote\assets\WAFE') -Destination (Join-Path $Assets 'wafe') -Recurse
Copy-Item -LiteralPath (Join-Path $V1 'OneNote\assets\WAFE - Donjon') -Destination (Join-Path $Assets 'wafe-donjon') -Recurse
Copy-Item -LiteralPath (Join-Path $V1 'OneNote\assets\YNSECTS') -Destination (Join-Path $Assets 'ynsects') -Recurse

# Canonical Markdown catalogue from the Notion database export.
$csv = Import-Csv -LiteralPath (Join-Path $V1 'Notion\Liste des jeux 14f78fb2cc9180b7a3e8dd05c57df425.csv') -Encoding UTF8
$catalogue = New-Object Collections.Generic.List[string]
$catalogue.Add('# Catalogue des projets')
$catalogue.Add('')
$catalogue.Add('Ce tableau reprend toutes les propriétés de la base Notion. Le second export `_all.csv` contient les mêmes entrées et valeurs, dans un ordre de colonnes différent.')
$catalogue.Add('')
$catalogue.Add('| Projet | État | Interaction | Type | Joueurs | Difficulté | Thème | Envie de développer | Initiateur | Nombre |')
$catalogue.Add('|---|---|---|---|---|---|---|---:|---|---|')
foreach ($row in $csv) {
    $catalogue.Add("| $(Table-Escape $row.Nom) | $(Table-Escape $row.État) | $(Table-Escape $row.Interaction) | $(Table-Escape $row.'Type de jeu') | $(Table-Escape $row.'Nbr joueurs') | $(Table-Escape $row.Difficulté) | $(Table-Escape $row.Thème) | $(Table-Escape $row.'Envie de développer') | $(Table-Escape $row.Initiateur) | $(Table-Escape $row.Nombre) |")
}
Write-Utf8 (Join-Path $Library '00-Catalogue.md') ($catalogue -join "`n")

$wafeIndex = @'
# WAFE

WAFE est conservé comme une famille unique, répartie en modules afin que chaque axe puisse être travaillé sans charger l’ensemble du corpus.

- [Univers et système](01-Univers-et-systeme.md)
- [Règles communes](02-Regles-communes.md)
- [Donjon](03-Donjon.md)
- [King Battle](04-King-Battle.md)
- [LandProtect](05-LandProtect.md)

Les variantes, questions et répétitions sont volontairement conservées : elles représentent l’historique de conception.
'@
Write-Utf8 (Join-Path $wafeDir 'README.md') $wafeIndex

$readme = @'
# Bibliothèque de conception de jeux — V2

Cette version est une base de travail Markdown. Elle ne reproduit plus l’arborescence des exports : les contenus sont classés par projet et directement éditables.

## Entrées principales

- [Catalogue des projets](Bibliotheque/00-Catalogue.md)
- [Sheepering](Bibliotheque/01-Sheepering.md)
- [Jeu de cartes de boxe](Bibliotheque/02-Boxe.md)
- [KINGDOMS](Bibliotheque/03-Kingdoms.md)
- [Base et de survie](Bibliotheque/04-Base-et-survie.md)
- [Village](Bibliotheque/05-Village.md)
- [Donjon à plusieurs](Bibliotheque/06-Donjon-a-plusieurs.md)
- [Gestion de forêt](Bibliotheque/07-Gestion-foret.md)
- [Jeu sur les sens](Bibliotheque/08-Jeu-sur-les-sens.md)
- [Jeu de type Reign](Bibliotheque/09-Jeu-type-Reign.md)
- [Abeilles et gestion d’équipe](Bibliotheque/10-Abeilles-gestion-equipe.md)
- [YNSECTS](Bibliotheque/11-YNSECTS.md)
- [Ressources et inspirations](Bibliotheque/12-Ressources-et-inspirations.md)
- [Volley](Bibliotheque/13-Volley.md)
- [Famille WAFE](Bibliotheque/WAFE/README.md)

Les images nécessaires aux documents sont dans `assets/`. Le dossier `_meta/` sert uniquement au contrôle de couverture.
'@
Write-Utf8 (Join-Path $Out 'README.md') $readme

$coverage = @'
# Couverture des sources

Le corpus source compte 36 fichiers. La bibliothèque représente leurs contenus éditables dans 22 fichiers Markdown et conserve les 16 images utiles dans `assets/`.

## OneNote

Chaque paire `.one` / `.docx` est absorbée dans un document Markdown :

| Section source | Destination V2 |
|---|---|
| Général | `Bibliotheque/12-Ressources-et-inspirations.md` |
| Sport - BOXE | `Bibliotheque/02-Boxe.md` |
| Sport - Volley | `Bibliotheque/13-Volley.md` |
| Stratégie - KINGDOMS | `Bibliotheque/03-Kingdoms.md` |
| Village | `Bibliotheque/05-Village.md` |
| WAFE | `Bibliotheque/WAFE/01-Univers-et-systeme.md` |
| WAFE - Banalités | `Bibliotheque/WAFE/02-Regles-communes.md` |
| WAFE - Donjon | `Bibliotheque/WAFE/03-Donjon.md` |
| WAFE - King battle | `Bibliotheque/WAFE/04-King-Battle.md` |
| WAFE - LandProtect | `Bibliotheque/WAFE/05-LandProtect.md` |
| YNSECTS | `Bibliotheque/11-YNSECTS.md` |

`Ouvrir le bloc-notes.onetoc2` est l’index technique du bloc-notes OneNote : il ne contient pas une note de projet supplémentaire. Sa fonction de navigation est remplacée par le présent index et par `Bibliotheque/WAFE/README.md`.

## Notion

Les sept pages sont converties en documents de projet. Les deux CSV sont représentés par `Bibliotheque/00-Catalogue.md`. Leurs différences portent sur l’ordre des colonnes, pas sur les valeurs. Les trois images sont intégrées à Base et de survie.

## GitHub

`Sheepering.md` devient `Bibliotheque/01-Sheepering.md` sans réduction de contenu.
'@
Write-Utf8 (Join-Path $Meta 'COUVERTURE.md') $coverage

Write-Output "V2 generated: $Out"
