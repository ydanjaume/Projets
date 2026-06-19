param(
    [string]$ProjectRoot = (Join-Path $PSScriptRoot '..'),
    [string]$SourceCommit = '7db5550'
)

$ErrorActionPreference = 'Stop'
$ProjectRoot = [IO.Path]::GetFullPath($ProjectRoot)
$Mix = Join-Path $ProjectRoot 'Résume\Mixologie'
$utf8 = New-Object Text.UTF8Encoding($false)
$begin = '<!-- SOURCE-ARCHIVE:BEGIN -->'
$end = '<!-- SOURCE-ARCHIVE:END -->'

function Read-Utf8([string]$Path) { [IO.File]::ReadAllText($Path, [Text.Encoding]::UTF8) }
function Write-Utf8([string]$Path, [string]$Text) { [IO.File]::WriteAllText($Path, ($Text.TrimEnd() + "`n"), $utf8) }
function Git-Text([string]$RepoPath) {
    Push-Location $ProjectRoot
    try {
        $lines = @(& git show "${SourceCommit}:$RepoPath")
        if ($LASTEXITCODE -ne 0) { throw "git show failed: $RepoPath" }
        return $lines -join "`n"
    } finally { Pop-Location }
}
function Add-Archive([string]$Destination, [string[]]$OldPaths, [hashtable]$Replacements = @{}) {
    $path = Join-Path $Mix $Destination
    $current = Read-Utf8 $path
    $marker = $current.IndexOf($begin)
    if ($marker -ge 0) { $current = $current.Substring(0, $marker).TrimEnd() }
    $parts = New-Object Collections.Generic.List[string]
    foreach ($oldPath in $OldPaths) {
        $text = Git-Text $oldPath
        foreach ($key in $Replacements.Keys) { $text = $text.Replace($key, $Replacements[$key]) }
        $parts.Add($text.Trim())
    }
    $archive = $parts -join "`n`n---`n`n"
    $block = @"


---

$begin
## Annexe — Notes sources exhaustives

<details>
<summary>Afficher la transcription exhaustive et les variantes historiques</summary>

> Cette annexe est la couche de référence restaurée depuis Mixologie avant restructuration (`$SourceCommit`). Elle ne doit pas être condensée. Seuls les chemins des médias ont été adaptés à la nouvelle arborescence.

$archive

</details>
$end
"@
    Write-Utf8 $path ($current + $block)
}
function Add-EditorialImages([string]$Destination, [string]$Anchor, [string]$ImagesMarkdown) {
    $path = Join-Path $Mix $Destination
    $text = Read-Utf8 $path
    if ($text.Contains($ImagesMarkdown.Trim())) { return }
    $index = $text.IndexOf($Anchor)
    if ($index -lt 0) { throw "Image anchor not found in $Destination" }
    $insertAt = $index + $Anchor.Length
    $text = $text.Substring(0, $insertAt) + "`n`n" + $ImagesMarkdown.Trim() + $text.Substring($insertAt)
    Write-Utf8 $path $text
}

$old = 'Résume/Mixologie'
Add-Archive 'Projets\01_SHEEPERING.md' @("$old/01-Sheepering/NOTES-SOURCES.md")
Add-Archive 'Projets\02_WAFE_UNIVERS.md' @("$old/02-WAFE/01-Univers-NOTES-SOURCES.md") @{'../assets/'='assets/'}
Add-Archive 'Projets\03_WAFE_KING_BATTLE.md' @("$old/02-WAFE/02-King-Battle-NOTES-SOURCES.md")
Add-Archive 'Projets\04_WAFE_LANDPROTECT.md' @("$old/02-WAFE/03-LandProtect-NOTES-SOURCES.md")
Add-Archive 'Projets\05_WAFE_DONJON.md' @("$old/02-WAFE/04-Donjon-NOTES-SOURCES.md") @{'../assets/'='assets/'}
Add-Archive 'Projets\06_KINGDOMS.md' @("$old/03-Kingdoms/NOTES-SOURCES.md")
Add-Archive 'Projets\07_BASE_ET_SURVIE.md' @("$old/04-Base-et-survie/NOTES-SOURCES.md") @{'../assets/'='assets/'}
Add-Archive 'Projets\08_BOXE.md' @("$old/05-Boxe/NOTES-SOURCES.md")
Add-Archive 'Projets\09_VOLLEY.md' @("$old/06-Volley/NOTES-SOURCES.md")
Add-Archive 'Projets\10_VILLAGE.md' @("$old/07-Village/NOTES-SOURCES.md")
Add-Archive 'Projets\11_YNSECTS.md' @("$old/08-YNSECTS/NOTES-SOURCES.md") @{'../assets/'='assets/'}
Add-Archive 'Projets\12_AUTRES_IDEES.md' @(
    "$old/09-Autres-idees/01-Reign.md",
    "$old/09-Autres-idees/02-Gestion-foret.md",
    "$old/09-Autres-idees/03-Jeu-sur-les-sens.md",
    "$old/09-Autres-idees/04-Abeilles-gestion-equipe.md"
)
Add-Archive 'Documentation\References.md' @("$old/10-References-NOTES-SOURCES.md")

Add-EditorialImages 'Projets\05_WAFE_DONJON.md' '- `assets/wafe-donjon/image5.jpeg`' @'
![Illustration Donjon 1](assets/wafe-donjon/image1.jpeg)

![Illustration Donjon 2](assets/wafe-donjon/image2.jpg)

![Illustration Donjon 3](assets/wafe-donjon/image3.jpeg)

![Illustration Donjon 4](assets/wafe-donjon/image4.jpeg)

![Illustration Donjon 5](assets/wafe-donjon/image5.jpeg)
'@
Add-EditorialImages 'Projets\07_BASE_ET_SURVIE.md' '- `assets/base-et-survie/image 2.png` — Plateau type' @'
![Fiche personnage](assets/base-et-survie/image.png)

![Fiche personnage — suite](assets/base-et-survie/image%201.png)

![Exemple de plateau](assets/base-et-survie/image%202.png)
'@
Add-EditorialImages 'Projets\11_YNSECTS.md' '- `assets/ynsects/image3.jpg`' @'
![Fanart — fourmis stylisées](assets/ynsects/image1.jpg)

![Fanart — personnage insecte ailé](assets/ynsects/image2.jpg)

![Fanart — classes d’insectes](assets/ynsects/image3.jpg)
'@

$readmePath = Join-Path $Mix 'README.md'
$readme = Read-Utf8 $readmePath
$sentence = 'Chaque fichier projet contient une couche éditoriale immédiatement lisible et, en fin de document, une annexe repliable `Notes sources exhaustives` qui conserve les formulations et variantes historiques.'
if (-not $readme.Contains($sentence)) {
    $readme = $readme.Replace('Cette bibliothèque regroupe tous les projets de jeux de Yann Danjaume, issus de OneNote, Notion et GitHub.', "Cette bibliothèque regroupe tous les projets de jeux de Yann Danjaume, issus de OneNote, Notion et GitHub.`n`n$sentence")
    Write-Utf8 $readmePath $readme
}

Write-Output 'Source annexes restored into 12 projects and References.md.'
