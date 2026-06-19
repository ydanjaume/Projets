param([string]$ProjectRoot = (Join-Path $PSScriptRoot '..'))

$ErrorActionPreference = 'Stop'
$ProjectRoot = [IO.Path]::GetFullPath($ProjectRoot)
$Chat = Join-Path $ProjectRoot 'Résume\ChatGPT\V2'
$Claude = Join-Path $ProjectRoot 'Résume\Claude\V2'
$Out = Join-Path $ProjectRoot 'Résume\Mixologie'
$utf8 = New-Object Text.UTF8Encoding($false)

function Read-Utf8([string]$Path) { [IO.File]::ReadAllText($Path, [Text.Encoding]::UTF8) }
function Write-Utf8([string]$Path, [string]$Text) {
    [IO.Directory]::CreateDirectory((Split-Path -Parent $Path)) | Out-Null
    [IO.File]::WriteAllText($Path, ($Text.TrimEnd() + "`n"), $utf8)
}
function Editorial([string]$ClaudeFile, [string]$NotesLink = '') {
    $text = Read-Utf8 (Join-Path $Claude $ClaudeFile)
    $lines = $text -split "`r?`n"
    $insert = @(
        '',
        '> **Couche éditoriale.** Cette page organise et synthétise les notes. Les champs de maturité, les étoiles et certaines qualifications sont des lectures de Claude, pas toujours des données explicitement écrites dans les sources.'
    )
    $result = @($lines[0]) + $insert + @($lines[1..($lines.Count-1)])
    if ($NotesLink) {
        $result += @('', '---', '', '## Notes exhaustives', '', "La transcription complète, les variantes et les éléments non retenus dans cette synthèse sont dans [NOTES-SOURCES.md]($NotesLink).")
    }
    return $result -join "`n"
}
function SourceNotes([string]$ChatPath, [string]$Label, [hashtable]$Replacements = @{}) {
    $text = Read-Utf8 (Join-Path $Chat $ChatPath)
    foreach ($key in $Replacements.Keys) { $text = $text.Replace($key, $Replacements[$key]) }
    return "> **Couche exhaustive — $Label.** Ce document conserve les formulations, variantes, répétitions, dates, tableaux et médias issus des exports. Il fait foi lorsqu’une synthèse éditoriale simplifie ou interprète un point.`n`n" + $text
}
function Write-Project([string]$Folder, [string]$ClaudeFile, [string]$ChatPath, [hashtable]$Replacements = @{}) {
    Write-Utf8 (Join-Path $Out "$Folder\README.md") (Editorial $ClaudeFile 'NOTES-SOURCES.md')
    Write-Utf8 (Join-Path $Out "$Folder\NOTES-SOURCES.md") (SourceNotes $ChatPath 'ChatGPT V2' $Replacements)
}

if (Test-Path -LiteralPath $Out) { Remove-Item -LiteralPath $Out -Recurse -Force }
[IO.Directory]::CreateDirectory($Out) | Out-Null
Copy-Item -LiteralPath (Join-Path $Chat 'assets') -Destination (Join-Path $Out 'assets') -Recurse

Write-Project '01-Sheepering' '01_SHEEPERING.md' 'Bibliotheque\01-Sheepering.md'
Write-Project '03-Kingdoms' '05_KINGDOMS.md' 'Bibliotheque\03-Kingdoms.md'
Write-Project '04-Base-et-survie' '06_BASE_ET_SURVIE.md' 'Bibliotheque\04-Base-et-survie.md'
Write-Project '05-Boxe' '08_BOXE.md' 'Bibliotheque\02-Boxe.md'
Write-Project '06-Volley' '09_VOLLEY.md' 'Bibliotheque\13-Volley.md'
Write-Project '07-Village' '10_VILLAGE.md' 'Bibliotheque\05-Village.md'
Write-Project '08-YNSECTS' '11_YNSECTS.md' 'Bibliotheque\11-YNSECTS.md'
$ynsectsPath = Join-Path $Out '08-YNSECTS\README.md'
$ynsectsText = Read-Utf8 $ynsectsPath
$ynsectsVisual = @'

## Validation des visuels

Cette information vient des images et non du texte OneNote : les fanarts montrent des fourmis stylisées, un personnage insecte ailé, ainsi qu’une planche identifiant une libellule, une mante orchidée, une fourmi coupe-feuille et un frelon géant asiatique. Cela confirme le thème général des insectes, sans définir de mécanique de jeu.
'@
Write-Utf8 $ynsectsPath ($ynsectsText + $ynsectsVisual)

# WAFE: Claude provides the clean project views; ChatGPT retains the full modules.
$wafe = Join-Path $Out '02-WAFE'
[IO.Directory]::CreateDirectory($wafe) | Out-Null
Write-Utf8 (Join-Path $wafe '01-Univers.md') (Editorial '02_WAFE_UNIVERS.md' '01-Univers-NOTES-SOURCES.md')
$universeNotes = SourceNotes 'Bibliotheque\WAFE\01-Univers-et-systeme.md' 'WAFE — univers principal' @{'../../assets/'='../assets/'}
$commonNotes = SourceNotes 'Bibliotheque\WAFE\02-Regles-communes.md' 'WAFE — règles communes'
Write-Utf8 (Join-Path $wafe '01-Univers-NOTES-SOURCES.md') ($universeNotes + "`n`n---`n`n" + $commonNotes)
Write-Utf8 (Join-Path $wafe '02-King-Battle.md') (Editorial '03_WAFE_KING_BATTLE.md' '02-King-Battle-NOTES-SOURCES.md')
Write-Utf8 (Join-Path $wafe '02-King-Battle-NOTES-SOURCES.md') (SourceNotes 'Bibliotheque\WAFE\04-King-Battle.md' 'WAFE — King Battle')
Write-Utf8 (Join-Path $wafe '03-LandProtect.md') (Editorial '04_WAFE_LANDPROTECT.md' '03-LandProtect-NOTES-SOURCES.md')
Write-Utf8 (Join-Path $wafe '03-LandProtect-NOTES-SOURCES.md') (SourceNotes 'Bibliotheque\WAFE\05-LandProtect.md' 'WAFE — LandProtect')
Write-Utf8 (Join-Path $wafe '04-Donjon.md') (Editorial '07_DONJON.md' '04-Donjon-NOTES-SOURCES.md')
$donjonNotes = SourceNotes 'Bibliotheque\WAFE\03-Donjon.md' 'WAFE — Donjon' @{'../../assets/'='../assets/'}
$notionDonjon = SourceNotes 'Bibliotheque\06-Donjon-a-plusieurs.md' 'concept Notion distinct « Donjon à plusieurs »'
Write-Utf8 (Join-Path $wafe '04-Donjon-NOTES-SOURCES.md') ($donjonNotes + "`n`n---`n`n" + $notionDonjon)
$wafeIndex = @'
# WAFE — famille de projets

WAFE est traité comme un univers partagé comportant plusieurs modes. Les synthèses et les notes exhaustives restent séparées afin de ne pas confondre décisions établies, variantes et pistes anciennes.

| Module | Vue éditoriale | Notes exhaustives |
|---|---|---|
| Univers et RPG principal | [Ouvrir](01-Univers.md) | [Sources](01-Univers-NOTES-SOURCES.md) |
| King Battle | [Ouvrir](02-King-Battle.md) | [Sources](02-King-Battle-NOTES-SOURCES.md) |
| LandProtect | [Ouvrir](03-LandProtect.md) | [Sources](03-LandProtect-NOTES-SOURCES.md) |
| Donjon | [Ouvrir](04-Donjon.md) | [Sources](04-Donjon-NOTES-SOURCES.md) |

> Le rapprochement entre « WAFE — Donjon » et « Donjon à plusieurs » est une hypothèse éditoriale de Claude. Le second concept reste identifié séparément dans les notes exhaustives.
'@
Write-Utf8 (Join-Path $wafe 'README.md') $wafeIndex

# Small Notion concepts: editorial overview plus one source sheet per concept.
$ideas = Join-Path $Out '09-Autres-idees'
[IO.Directory]::CreateDirectory($ideas) | Out-Null
Write-Utf8 (Join-Path $ideas 'README.md') (Editorial '12_AUTRES_IDEES.md')
foreach ($item in @(
    @('01-Reign.md','Bibliotheque\09-Jeu-type-Reign.md','Jeu de type Reign'),
    @('02-Gestion-foret.md','Bibliotheque\07-Gestion-foret.md','Gestion de forêt'),
    @('03-Jeu-sur-les-sens.md','Bibliotheque\08-Jeu-sur-les-sens.md','Jeu sur les sens'),
    @('04-Abeilles-gestion-equipe.md','Bibliotheque\10-Abeilles-gestion-equipe.md',"Abeilles et gestion d’équipe")
)) { Write-Utf8 (Join-Path $ideas $item[0]) (SourceNotes $item[1] $item[2]) }

# References and canonical Notion catalogue.
Write-Utf8 (Join-Path $Out '10-References.md') (Editorial '13_SOURCES_REFERENCES.md' '10-References-NOTES-SOURCES.md')
Write-Utf8 (Join-Path $Out '10-References-NOTES-SOURCES.md') (SourceNotes 'Bibliotheque\12-Ressources-et-inspirations.md' 'notes générales')
Write-Utf8 (Join-Path $Out '00-Catalogue-Notion.md') (Read-Utf8 (Join-Path $Chat 'Bibliotheque\00-Catalogue.md'))

$readme = @'
# Mixologie — Bibliothèque consolidée des projets de jeux

Cette bibliothèque combine les deux V2 :

- **Claude** apporte une vue éditoriale, des résumés, des fiches projet et une organisation immédiatement exploitable ;
- **ChatGPT** apporte la couverture exhaustive, les variantes historiques, les tableaux complets et les médias.

Chaque projet important possède donc une **vue éditoriale** (`README.md`) et des **notes exhaustives** (`NOTES-SOURCES.md`). En cas de contradiction, les notes exhaustives priment tant qu’une décision de conception n’a pas été explicitement arbitrée.

## Bibliothèque

| Projet | Vue éditoriale | Notes exhaustives |
|---|---|---|
| Sheepering | [Ouvrir](01-Sheepering/README.md) | [Sources](01-Sheepering/NOTES-SOURCES.md) |
| WAFE | [Ouvrir](02-WAFE/README.md) | Par module |
| KINGDOMS | [Ouvrir](03-Kingdoms/README.md) | [Sources](03-Kingdoms/NOTES-SOURCES.md) |
| Base et de survie | [Ouvrir](04-Base-et-survie/README.md) | [Sources](04-Base-et-survie/NOTES-SOURCES.md) |
| Boxe | [Ouvrir](05-Boxe/README.md) | [Sources](05-Boxe/NOTES-SOURCES.md) |
| Volley | [Ouvrir](06-Volley/README.md) | [Sources](06-Volley/NOTES-SOURCES.md) |
| Village | [Ouvrir](07-Village/README.md) | [Sources](07-Village/NOTES-SOURCES.md) |
| YNSECTS | [Ouvrir](08-YNSECTS/README.md) | [Sources](08-YNSECTS/NOTES-SOURCES.md) |
| Autres idées | [Ouvrir](09-Autres-idees/README.md) | Une fiche par idée |

## Documents transversaux

- [Catalogue Notion](00-Catalogue-Notion.md)
- [Références consolidées](10-References.md)
- [Notes générales originales](10-References-NOTES-SOURCES.md)
- [Relais entre IA](IA_Share.md)

Les médias sont centralisés dans `assets/` et référencés depuis les notes exhaustives.
'@
Write-Utf8 (Join-Path $Out 'README.md') $readme

$share = @'
# IA Share — relais ChatGPT → Claude

## Objectif de Mixologie

Cette version ne choisit pas entre synthèse et exhaustivité. Elle présente une couche éditoriale lisible, puis une couche source complète. Claude peut donc améliorer les vues éditoriales sans devoir réextraire les documents ni risquer de supprimer une ancienne variante.

## Ce que ChatGPT a bien fait dans sa V2

- Conservation de l’intégralité textuelle des 11 exports OneNote DOCX, avec contrôle quantitatif en V1.
- Conservation et réparation des tableaux, listes, liens et 13 médias incorporés OneNote.
- Copie exacte des pages et images Notion, puis conversion des métadonnées et du catalogue CSV en Markdown.
- Séparation prudente de projets qui se ressemblent sans preuve qu’ils sont identiques, notamment `WAFE — Donjon` et `Donjon à plusieurs`.
- Maintien des versions historiques, questions, répétitions et contradictions utiles au travail de conception.

## Limites de la V2 ChatGPT

- Trop proche d’une transcription : peu de résumés, d’états de maturité et de points d’entrée éditoriaux.
- Organisation correcte mais froide ; les dates OneNote et certaines listes brutes prennent trop de place dans la lecture principale.
- WAFE était bien séparé en modules, mais sans synthèse globale assez forte.
- Les inspirations communes étaient conservées, mais moins bien reliées aux projets concernés.

## Ce que Claude a bien fait dans sa V2

- Excellente façade éditoriale : résumés, fiches signalétiques, tableaux cohérents et titres explicites.
- Regroupement utile de la famille WAFE et classement thématique des références.
- Mise en évidence des versions de KINGDOMS et du Donjon.
- Présentation plus directement exploitable pour prioriser ou reprendre la conception.

## Risques et limites repérés dans la V2 Claude

- Plusieurs champs ne viennent pas explicitement des sources : étoiles d’envie, maturité, difficulté supposée, interaction ou type de jeu pour certains projets.
- Certaines phrases transforment une interprétation plausible en fait. Exemples à revoir : Village qualifié de semi-coopératif et LandProtect qualifié de jeu de survie/gestion. Pour YNSECTS, le thème des insectes est confirmé par les visuels, mais pas écrit dans le texte OneNote.
- La fusion de `Donjon à plusieurs` avec `WAFE — Donjon` est plausible mais non confirmée par les sources.
- Des détails ont été condensés ou omis : l’écart est particulièrement important pour WAFE — Donjon et Boxe ; Sheepering est aussi raccourci.
- Les images intégrées n’étaient pas reprises dans Claude V2.
- Le tableau d’étoiles utilise une échelle de 5 alors que la propriété Notion « Envie de développer » contient des valeurs 0, 1 ou 2 sans définition d’une échelle sur 5.

## Arbitrages déjà appliqués

- Les fichiers Claude servent de vues éditoriales, avec un avertissement systématique sur les inférences.
- Les fichiers ChatGPT servent de notes exhaustives et font foi en cas de désaccord.
- WAFE reste une famille ; ses quatre modules sont distincts.
- `Donjon à plusieurs` est joint aux notes Donjon pour faciliter la comparaison, mais reste explicitement identifié comme concept Notion distinct.
- Les petites idées sont regroupées dans une vue d’ensemble tout en conservant une fiche Markdown individuelle chacune.
- Toutes les images de ChatGPT V2 sont conservées dans `assets/`.

## Travail recommandé pour le passage de Claude

1. Vérifier chaque champ des fiches signalétiques et marquer clairement `Source`, `Inférence` ou `Proposition`.
2. Comparer les vues éditoriales avec `NOTES-SOURCES.md`, surtout Donjon, Boxe, WAFE Univers et Sheepering, puis réinjecter les règles omises qui affectent réellement le gameplay.
3. Ne pas supprimer les notes exhaustives après consolidation ; elles constituent l’historique et la preuve de couverture.
4. Arbitrer avec l’utilisateur si `Donjon à plusieurs` appartient réellement à WAFE.
5. Confirmer l’échelle de la propriété Notion « Envie de développer » avant de conserver les étoiles.
6. Pour YNSECTS, conserver la provenance visuelle : l’inspection confirme fourmis, insecte ailé, libellule, mante orchidée, fourmi coupe-feuille et frelon géant asiatique, mais aucune mécanique.
7. Transformer progressivement les répétitions en sections `Décision actuelle`, `Anciennes variantes` et `Questions ouvertes`, sans effacer les formulations originales.

## Règle de sécurité éditoriale

Une reformulation peut clarifier une donnée. Une fusion, une valeur ajoutée ou un changement de statut doit être étiqueté comme inférence ou proposition tant qu’il n’est pas confirmé par Yann.

## État technique au passage de relais

- 33 fichiers Markdown dans Mixologie.
- 16 médias copiés avec des empreintes identiques à ChatGPT V2.
- 0 lien Markdown local cassé.
- 0 marqueur de gras Word mal formé (`****`).
- Les 13 vues de contenu Claude V2 sont représentées ; son index est remplacé par le `README.md` Mixologie.
- Tous les documents de projet ChatGPT V2 sont représentés dans les couches exhaustives ou le catalogue ; son index WAFE est remplacé par celui de Mixologie.
- Les références aux fichiers sources dans les vues Claude sont conservées comme provenance textuelle, mais la bibliothèque ne dépend d’aucun lien vers les répertoires Claude, ChatGPT ou Sources.
'@
Write-Utf8 (Join-Path $Out 'IA_Share.md') $share

Write-Output "Mixologie generated: $Out"
