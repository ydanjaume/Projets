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

**R2 — La couche exhaustive (NOTES-SOURCES) ne se modifie pas**
Elle fait foi en cas de désaccord. Seule la couche éditoriale (README) évolue.

**R3 — Toujours lire NOTES-SOURCES avant d'écrire dans README**
Les données semblant absentes du README sont souvent dans les notes. Ne jamais déclarer une section "à compléter" sans avoir vérifié.

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

**R9 — Les tableaux de cartes et données structurées vont dans le README éditorial**
Si des tableaux sont dans NOTES-SOURCES, les copier (pas paraphraser) dans le README dans une section dédiée.

**R10 — Couche éditoriale vs couche source**
La couche éditoriale (README) : synthèse lisible, fiche signalétique, pitch, sections claires.
La couche source (NOTES-SOURCES) : transcription intégrale, aucune condensation.

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

---

*Prochaine IA à travailler sur ce dossier : lire ce fichier en premier, puis IA_Share.md pour le contexte complet.*
