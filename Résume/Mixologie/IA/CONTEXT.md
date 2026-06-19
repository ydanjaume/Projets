# CONTEXT — Document de référence partagé Claude & ChatGPT

> **Ce fichier est la première chose à lire** avant tout travail sur Mixologie.
> Il contient les règles en vigueur et l'historique de ce qui a été fait.
> Chaque IA doit le mettre à jour à la fin de sa session.

---

## Comment utiliser ce fichier

1. **Lire les règles** avant de toucher quoi que ce soit.
2. **Appliquer les règles** sans exception — elles existent parce qu'un problème a déjà été rencontré.
3. **Ajouter une entrée dans le changelog** à la fin de chaque session, avec la date et la liste des modifications.
4. **Ajouter ou mettre à jour une règle** dès que Yann en formule une nouvelle.

---

## Règles en vigueur

### Règles d'intégrité des données

**R1 — Ne jamais perdre de données**
Aucune information présente dans les sources ne doit disparaître. Si elle ne tient pas dans la couche éditoriale, elle va dans NOTES-SOURCES.

**R2 — La couche exhaustive intégrée ne se modifie pas**
Depuis la restructuration en un fichier par projet, elle se trouve dans l’annexe repliable `Annexe — Notes sources exhaustives`, délimitée par les marqueurs `SOURCE-ARCHIVE`. Elle fait foi en cas de désaccord. Seule la partie éditoriale située avant cette annexe évolue. Une adaptation de chemin de média est autorisée lors d’un déplacement, sans modifier le contenu.

**R3 — Toujours lire l’annexe exhaustive avant d’écrire dans la partie éditoriale**
Les données semblant absentes de la partie éditoriale sont souvent dans l’annexe du même fichier. Ne jamais déclarer une section "à compléter" sans avoir vérifié jusqu’à la fin du document.

### Règles sur les inférences

**R4 — Marquer chaque champ inféré dans la cellule elle-même**
Format : `Valeur [Inférence]` ou `Non défini [Inférence Claude : "X" — non confirmé]`.
Pas dans une note en bas de page — dans la cellule du tableau résumé.

**R5 — Ne jamais fusionner deux documents source sans confirmation**
Si deux projets se ressemblent (ex : "Donjon à plusieurs" et "WAFE — Donjon"), les maintenir séparés avec une note "à arbitrer avec Yann".

**R6 — Ne jamais convertir les valeurs Notion sans confirmation**
La propriété "Envie de développer" contient des valeurs 0, 1 ou 2 — pas une échelle sur 5.
Conserver la valeur brute ou laisser `— [Non renseigné]` jusqu'à confirmation de Yann.

**R7 — Les étoiles ★ pour les projets hors Notion sont du remplissage**
Sheepering, WAFE, Kingdoms, Boxe, Village, YNSECTS n'ont pas de valeur Notion.
Utiliser `— [Non renseigné dans les sources]` sauf instruction contraire de Yann.

### Règles éditoriales

**R8 — Ne pas supprimer les questions ouvertes**
Les mentions "à définir", "à équilibrer", "à arbitrer" dans les READMEs sont des signaux de conception actifs — les conserver.

**R9 — Les tableaux de cartes et données structurées vont dans la partie éditoriale**
Si des tableaux sont dans l’annexe exhaustive, les copier (pas paraphraser) dans la partie éditoriale, avant le marqueur `SOURCE-ARCHIVE`, dans une section dédiée.

**R10 — Couche éditoriale vs couche source dans un fichier unique**
La couche éditoriale, placée en premier : synthèse lisible, fiche signalétique, pitch, sections claires.
La couche source, placée en annexe repliable : transcription intégrale, aucune condensation.

---

## Questions ouvertes (en attente de réponse de Yann)

| # | Question | Contexte |
|---|----------|---------|
| Q1 | Quelle est la signification réelle de 0, 1 et 2 dans "Envie de développer" ? | La propriété Notion utilise ces valeurs mais sans légende définie |
| Q2 | "Donjon à plusieurs" est-il le même projet que "WAFE — Donjon" ? | Actuellement maintenus séparés — à arbitrer |
| Q3 | Quelle échelle d'étoiles appliquer aux projets hors Notion ? | Ou faut-il laisser "Non renseigné" pour tous ? |

---

## Changelog

### 2026-06-19 — Claude (claude-sonnet-4-6)

**Session initiale d'analyse et de structuration**

Travail effectué :

- **V1** créée (`Résumé/Claude/V1/`) : 12 fichiers — extraction complète de toutes les sources (11 DOCX OneNote, 7 pages Notion, 2 CSV Notion, 1 GitHub)
- **V2** créée (`Résumé/Claude/V2/`) : 14 fichiers — King Battle, LandProtect et Donjon extraits de WAFE comme fichiers indépendants ; fiches signalétiques et résumés ajoutés en tête de chaque fichier
- **Mixologie — passe éditoriale** : corrections appliquées sur 4 fichiers après comparaison avec NOTES-SOURCES ChatGPT :
  - `05-Boxe/README.md` — 3 tableaux de cartes complets ajoutés (brouillon, reformaté, synthèse contres)
  - `07-Village/README.md` — "semi-coopératif" supprimé (inférence non sourcée), étoiles retirées, note éditoriale ajoutée
  - `02-WAFE/03-LandProtect.md` — "Gestion / Survie" remplacé par "Non défini [Inférence]", étoiles retirées
  - `08-YNSECTS/README.md` — "insectes sociaux" corrigé (libellule et mante ne sont pas sociales), provenance visuelle précisée
- **IA_Share.md** — section d'analyse Claude ajoutée : auto-critique, règles pour les prochaines sessions, état après passage
- **CONTEXT.md** — ce fichier créé pour centraliser règles et changelog

Fichiers Mixologie : 34 Markdown (33 existants + CONTEXT.md) + 16 médias.

### 2026-06-19 — Claude (claude-sonnet-4-6) — Restructuration complète

**Restructuration demandée par Yann :**

- **Nouvelle structure à 3 dossiers** :
  - `IA/` — CONTEXT.md, IA_Share.md
  - `Documentation/` — Catalogue.md, References.md
  - `Projets/` — un fichier .md par projet + `_exemple.md` + `assets/`

- **12 fichiers projets fusionnés** (README + NOTES-SOURCES → fichier unique) :
  - `01_SHEEPERING.md` à `12_AUTRES_IDEES.md`
  - King Battle, LandProtect et Donjon extraits de WAFE comme fichiers indépendants (avec lien vers l'univers)
  - Entête signalétique générique standardisée sur chaque fichier

- **`_exemple.md`** créé — template pour démarrer un nouveau projet

### 2026-06-19 — ChatGPT — Audit d’intégrité après restructuration

**Problème détecté :** la fusion `README + NOTES-SOURCES → fichier unique` avait supprimé la couche exhaustive, contrairement aux règles R1 et R2. Les images étaient seulement listées comme chemins, sans être affichées.

**Corrections appliquées :**

- restauration verbatim des anciennes couches `NOTES-SOURCES` depuis le commit `7db5550` ;
- intégration dans une annexe repliable à la fin de chacun des 12 fichiers projet ;
- restauration analogue des notes générales dans `Documentation/References.md` ;
- conservation de la structure demandée : toujours un seul fichier Markdown par projet ;
- adaptation uniquement des chemins de médias à `Projets/assets/` ;
- affichage effectif des images dans WAFE Donjon, Base et de survie et YNSECTS ;
- ajout de marqueurs `SOURCE-ARCHIVE:BEGIN/END` pour protéger la couche exhaustive ;
- mise à jour des règles R2, R3, R9 et R10 pour refléter l’architecture actuelle.
- remplacement des valeurs Notion transformées `0/2`, `1/2`, `2/2` par les valeurs brutes `0`, `1`, `2` avec mention « échelle non définie » ;
- création de `Projets/13_DONJON_A_PLUSIEURS.md` afin d’appliquer R5 et de ne plus attribuer ses métadonnées à WAFE — Donjon.

**Contrôle final :** 14 annexes complètes (13 projets + références), 16 anciens documents vérifiés verbatim, marqueurs de début/fin équilibrés, 0 lien local cassé et 0 média différent de ChatGPT V2.

---

### 2026-06-19 — Claude (claude-sonnet-4-6) — Passe de révision post-ChatGPT

**Corrections appliquées :**

- `$SourceCommit` — placeholder non résolu retrouvé dans les 13 annexes SOURCE-ARCHIVE ; remplacé par le hash réel `7db5550` sur tous les fichiers.
- `05_WAFE_DONJON.md` — ajout d'un lien croisé vers `13_DONJON_A_PLUSIEURS.md` (lien réciproque manquant — l'autre fichier pointait déjà vers celui-ci).

**Vérifications effectuées :**
- README.md : à jour, arborescence correcte, 13 projets dans le tableau.
- Catalogue.md : 7 entrées Notion, valeurs brutes, note sur l'échelle non définie.
- Headers des fichiers WAFE : inférences marquées correctement.
- Annexes SOURCE-ARCHIVE : présentes et équilibrées dans les 13 fichiers projet.

---

*Prochaine IA à travailler sur ce dossier : lire ce fichier en premier, puis IA_Share.md pour le contexte complet.*
