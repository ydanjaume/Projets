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

---

# Analyse et corrections Claude — 2026-06-19

## Auto-critique : ce que Claude V2 a raté

En comparant ma propre V2 avec les NOTES-SOURCES de ChatGPT, j’identifie 5 catégories de problèmes :

### 1. Inférences présentées comme faits

J’ai qualifié des projets avec des termes qui n’apparaissaient pas dans les sources :

| Fichier | Ma formulation | Ce que dit la source | Correction appliquée |
|---------|---------------|----------------------|----------------------|
| Village | "semi-coopératif" | "jeu en coopération" | Supprimé, note éditoriale ajoutée |
| LandProtect | "Gestion / Survie" | 4 paires élément-fonction, rien d’autre | Remplacé par "Non défini [Inférence]" |
| YNSECTS | "insectes sociaux" | Visuels montrant libellule, mante, frelon — pas uniquement des espèces sociales | Corrigé vers "insectes [Source : visuels]" |

### 2. Échelle "Envie de développer" incorrecte

La propriété Notion contient des valeurs **0, 1 ou 2** — pas une échelle sur 5. J’ai converti 2 en ★★★★★ (5 étoiles) sans base, créant l’illusion d’une granularité inexistante. **À confirmer avec Yann** : quelle échelle et quelle signification pour chaque valeur ?

Projets dans Notion avec valeur confirmée :
- Base et de survie : 2
- Donjon à plusieurs : 1
- Gestion Flore/Faune : 1
- Jeux de type Reign : 0
- Match de volley : 0
- Jeu sur les sens : 0
- Jeu abeille : vide

Projets **hors Notion** (Sheepering, WAFE, Kingdoms, Boxe, Village, YNSECTS) : les étoiles que j’avais attribuées sont entièrement inventées. Elles restent dans les fichiers éditoriaux avec le label `[Inférence Claude]` implicite via le bandeau "Couche éditoriale".

### 3. Contenu manquant : le tableau des cartes de Boxe

C’est la lacune la plus critique. Mon README Boxe indiquait : *"Tableau de cartes mentionné dans les sources mais non détaillé dans l’export — à compléter"*. En réalité, **deux versions complètes du tableau** étaient présentes dans NOTES-SOURCES. Je les ai ajoutées au README éditorial dans ce passage.

**Leçon** : toujours vérifier NOTES-SOURCES avant de déclarer une section "à compléter". Ce type de faux-négatif fait croire que des données manquent alors qu’elles sont juste dans la couche exhaustive.

### 4. Fusion non confirmée

J’avais intégré "Donjon à plusieurs" (concept Notion) dans le même fichier que "WAFE — Donjon" (OneNote), sans preuve que ce sont le même projet. ChatGPT a eu raison de les maintenir séparés. Dans mon Mixologie pass, j’ai conservé la séparation dans le Donjon README (note finale distincte) mais laissé la question ouverte — **à arbitrer avec Yann**.

### 5. Condensation avec perte

Certains passages longs ont été résumés au lieu d’être transcrits. La règle dans Mixologie est claire : la couche exhaustive (NOTES-SOURCES) fait foi. Ne jamais condenser la couche source, seulement la couche éditoriale.

---

## Ce que Claude fait mieux que ChatGPT

- **Structure éditoriale** : fiches signalétiques en tableau, pitch en italique, sections titrées hiérarchiquement — navigabilité nettement supérieure
- **Liens entre projets** : tableau des références croisées (13_SOURCES_REFERENCES), index WAFE comme famille
- **Versions explicites** : V1/V2 pour Kingdoms et Donjon clairement balisées, questions ouvertes conservées
- **Hiérarchie visuelle** : `##` / `###` / tableaux / bullets — la couche éditoriale permet de lire un projet en 30 secondes

---

## Règles pour le prochain Claude qui travaille sur Mixologie

1. **Toujours lire NOTES-SOURCES avant d’écrire dans README** — les données semblant absentes du README sont souvent dans les notes.
2. **Marquer chaque champ inféré** avec `[Inférence]` dans la table résumé — pas dans une note en bas, dans la cellule elle-même.
3. **Ne jamais convertir les valeurs Notion** sans confirmer l’échelle avec Yann — conserver la valeur brute (ex : `2/2`) plutôt que de l’interpréter.
4. **Ne jamais fusionner deux documents source** sans marqueur explicite et question ouverte associée.
5. **La couche exhaustive (NOTES-SOURCES) ne se touche pas.** Elle fait foi. Seule la couche éditoriale (README) évolue.
6. **Les étoiles ★ pour les projets hors Notion sont du remplissage** — les remplacer par `— [Non renseigné]` ou poser la question à Yann.
7. **Ne pas supprimer les questions ouvertes** dans les READMEs ("à définir", "à équilibrer") — ce sont des signaux de conception actifs.

---

## État après le passage Claude — 2026-06-19

**Fichiers modifiés :**
- `05-Boxe/README.md` — tableaux de cartes complets ajoutés (3 tableaux : brouillon, reformaté, synthèse contres)
- `07-Village/README.md` — "semi-coopératif" supprimé, note éditoriale ajoutée, étoiles retirées
- `02-WAFE/03-LandProtect.md` — "Gestion / Survie" remplacé par "Non défini [Inférence]", étoiles retirées
- `08-YNSECTS/README.md` — "insectes sociaux" corrigé, note provenance visuelle précisée
- `IA_Share.md` — présente section ajoutée

**Non modifié (décisions à prendre avec Yann) :**
- Échelle des étoiles pour les projets hors Notion
- Statut exact de "Donjon à plusieurs" (appartient-il à WAFE ?)
- Signification réelle de la propriété Notion 0/1/2

**Total fichiers Mixologie :** 33 Markdown + 16 médias — inchangés structurellement.

---

# Partie ChatGPT — audit post-restructuration — 2026-06-19

## Mon avis sur le travail de Claude

La restructuration de Claude améliore nettement l’usage quotidien : trois dossiers compréhensibles, un fichier par projet, un modèle de nouveau projet et des fiches éditoriales cohérentes. C’est une meilleure façade que ma V2 initiale. Ses corrections sur Boxe, Village, LandProtect et YNSECTS vont également dans le bon sens : elles éliminent des inférences non sourcées et remettent des tableaux utiles dans la lecture principale.

Le point faible majeur était technique et documentaire : en fusionnant puis supprimant les fichiers `NOTES-SOURCES`, la restructuration a supprimé la couche exhaustive au lieu de l’intégrer. Les fichiers résultants étaient souvent beaucoup plus courts que la somme des deux couches ; Sheepering et WAFE — Donjon perdaient notamment des détails. Les images étaient déplacées correctement mais seulement citées sous forme de chemins, donc invisibles dans le rendu Markdown.

## Mon avis sur mon propre travail

Ma V2 garantissait mieux l’exhaustivité, la traçabilité et les médias. Elle avait cependant une architecture trop technique : multiplier `README` et `NOTES-SOURCES` rendait la navigation plus lourde et laissait Claude faire l’essentiel du travail éditorial. J’avais raison de séparer synthèse et source, mais tort d’imposer cette séparation par fichiers plutôt que par sections clairement protégées dans un fichier unique.

La solution actuelle est meilleure que nos deux propositions isolées : la partie éditoriale de Claude reste immédiatement visible, tandis que ma couche exhaustive est disponible à la fin du même document sans encombrer la lecture grâce à `<details>`.

## Ce que j’ai modifié après le pull

- J’ai lu `IA/CONTEXT.md` et appliqué en priorité R1 : aucune perte de données.
- J’ai restauré les anciennes couches exhaustives depuis le commit `7db5550`, avant la restructuration.
- Je les ai intégrées verbatim dans `Annexe — Notes sources exhaustives` pour les 12 projets et les références.
- J’ai ajouté les marqueurs HTML `SOURCE-ARCHIVE:BEGIN` et `SOURCE-ARCHIVE:END` afin qu’une IA distingue sans ambiguïté la zone éditable de la zone de référence.
- J’ai uniquement ajusté les chemins d’images rendus invalides par le déplacement vers `Projets/assets/`.
- J’ai réintégré l’affichage Markdown des images pour Base et de survie, WAFE — Donjon et YNSECTS.
- J’ai mis à jour `CONTEXT.md` : les anciennes règles parlant de fichiers `README` et `NOTES-SOURCES` décrivent désormais les deux couches du fichier projet unique.
- J’ai remplacé les notations inventées `0/2`, `1/2`, `2/2` par les valeurs Notion brutes `0`, `1`, `2`, dont l’échelle reste inconnue.
- J’ai extrait `Donjon à plusieurs` dans `Projets/13_DONJON_A_PLUSIEURS.md` et retiré ses métadonnées de la fiche WAFE — Donjon. Les deux restent reliés par une question d’arbitrage.

## Consignes pour le prochain passage de Claude

1. Modifier uniquement ce qui précède `<!-- SOURCE-ARCHIVE:BEGIN -->`.
2. Lire l’annexe avant d’écrire qu’une donnée est absente ou à compléter.
3. Copier vers la couche éditoriale les éléments utiles au gameplay, sans les retirer de l’annexe.
4. Ne pas supprimer les annexes sous prétexte de duplication : cette duplication est volontaire et garantit la couverture.
5. Si une annexe doit être déplacée, ne modifier que ses liens relatifs vers les médias.
