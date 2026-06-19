# Changelog — Atelier et corpus de projets

> Journal partagé entre Yann, Claude, ChatGPT et toute autre IA intervenant sur ce dépôt.
> Fuseau horaire de référence : **Europe/Paris** (`UTC+02:00` pour les entrées ci-dessous).

---

## Règles de tenue du journal

1. Toute intervention qui modifie un fichier doit ajouter une entrée en tête de la section **Historique** avant la fin de la session.
2. Chaque entrée doit contenir la date, l’heure locale, l’auteur réel du travail, les fichiers ou la portée, les changements et les contrôles effectués.
3. Lorsqu’une IA travaille avec l’identité Git de Yann, indiquer séparément **Auteur du travail** et **Auteur Git**.
4. Utiliser `Commit : en attente` tant que le commit n’existe pas, puis remplacer cette mention par son hash après commit si la session inclut le commit.
5. Ne pas réécrire une ancienne entrée pour embellir l’historique. Une correction factuelle doit être ajoutée comme nouvelle entrée et référencer l’entrée corrigée.
6. Les entrées antérieures à la création de ce fichier sont marquées **Historique reconstruit**. Elles reposent sur Git, `IA/CONTEXT.md`, `IA/IA_Share.md` et le contexte de conversation disponible.

### Modèle d’entrée

```markdown
## AAAA-MM-JJ HH:mm:ss — Auteur — Titre court

- **Auteur du travail :** Yann | Claude (modèle) | ChatGPT (modèle) | autre
- **Auteur Git :** nom et adresse, ou `sans commit`
- **Commit :** hash court | `en attente` | `aucun`
- **Type :** ajout | modification | correction | restructuration | contrôle | fusion
- **Portée :** fichiers ou dossiers concernés

### Changements

- ...

### Contrôles

- ...
```

---

# Historique

## 2026-06-19 13:24:37 — Auteur non déterminé — Sources brutes regroupées sous Origine

- **Auteur du travail :** auteur non déterminé — modification concurrente observée pendant la session ChatGPT
- **Auteur Git :** sans commit
- **Commit :** en attente
- **Type :** restructuration
- **Portée :** `Sources/Github`, `Sources/Notion`, `Sources/OneNote` → `Sources/Origine/`

### Changements observés et intégrés

- Regroupement des trois familles de sources brutes sous `Sources/Origine/`.
- Adaptation par ChatGPT de `Sources/README.md`, du générateur V1 et des 11 liens DOCX des restitutions ChatGPT.
- Attribution volontairement laissée indéterminée faute de preuve sur l’IA ou la personne ayant effectué le déplacement concurrent.

### Contrôles

- Les 11 liens des pages OneNote V1 pointent vers `Sources/Origine/OneNote/.Docx` et se résolvent correctement.
- Syntaxe de `build-restitution.ps1` validée après adaptation de sa source par défaut.

---

## 2026-06-19 13:23:36 — ChatGPT — Mixologie devient Atelier

- **Auteur du travail :** ChatGPT (Codex, GPT-5)
- **Auteur Git :** sans commit
- **Commit :** en attente
- **Type :** renommage, documentation
- **Portée :** `Mixologie/` → `Atelier/`, liens racine, sources, contexte et outils archivés

### Changements

- Renommage du répertoire principal `Mixologie` en `Atelier`, nom validé par Yann.
- Mise à jour des liens actifs dans les README racine, Sources, Atelier et outils archivés.
- Mise à jour des consignes actives dans `IA/CONTEXT.md` et `IA/IA_Share.md`.
- Conservation volontaire du terme « Mixologie » dans les entrées et annexes historiques décrivant l’ancien état du dépôt.

### Contrôles

- 101 fichiers Markdown analysés, aucun lien local cassé.
- Aucun lien actif ne pointe encore vers un répertoire `Mixologie/`.
- Les occurrences restantes de « Mixologie » décrivent l’ancien nom dans l’historique, les annexes et les analyses IA.
- Syntaxe des deux outils ChatGPT archivés validée.

---

## 2026-06-19 13:17:39 — ChatGPT — Mixologie devient le répertoire principal

- **Auteur du travail :** ChatGPT (Codex, GPT-5)
- **Auteur Git :** sans commit
- **Commit :** en attente
- **Type :** restructuration, archivage, nettoyage
- **Portée :** racine du dépôt, `Mixologie/`, `Sources/Restitutions/`, anciens dossiers `Résume/` et `tools/`

### Changements

- Déplacement de `Résume/Mixologie` vers `Mixologie` à la racine : ce dossier devient l’espace principal de travail.
- Déplacement des restitutions historiques vers `Sources/Restitutions/ChatGPT` et `Sources/Restitutions/Claude`.
- Suppression des répertoires racine désormais vides `Résume/` et `tools/`.
- Conservation de `build-restitution.ps1` et `build-v2-library.ps1` dans `Sources/Restitutions/ChatGPT/Outils/`, avec chemins adaptés à la nouvelle arborescence.
- Suppression de `build-mixologie.ps1`, devenu dangereux car il reconstruisait l’ancienne structure.
- Suppression de `restore-mixologie-source-annexes.ps1`, migration ponctuelle déjà appliquée et contrôlée.
- Normalisation du nom `IA/CONTEXT.md` et correction des liens des restitutions V1 vers les DOCX OneNote.
- Ajout d’une documentation expliquant le rôle limité des outils archivés.
- Ajout d’un `README.md` à la racine et d’un index `Sources/README.md` pour rendre la séparation travail actif / archives explicite.

### Contrôles

- 101 fichiers Markdown analysés, aucun lien local cassé.
- Syntaxe des deux scripts conservés validée sans exécuter leurs écritures.
- 26 fichiers Claude comparés à leurs blobs Git : aucun manquant, aucun contenu modifié.
- 90 fichiers ChatGPT comparés : aucun manquant ; seules les 11 pages OneNote dont les liens source devaient changer diffèrent.
- 35 fichiers Mixologie suivis comparés : aucun manquant ; seules les documentations `README.md` et `IA/CONTEXT.md` diffèrent en plus du nouveau changelog.
- Absence confirmée des anciens dossiers racine `Résume/` et `tools/`.

---

## 2026-06-19 13:09:31 — ChatGPT — Création du changelog partagé

- **Auteur du travail :** ChatGPT (Codex, GPT-5)
- **Auteur Git :** sans commit
- **Commit :** en attente
- **Type :** ajout, documentation, reconstruction historique
- **Portée :** `Documentation/changelog.md`, `IA/CONTEXT.md`, `README.md`

### Changements

- Création du journal demandé par Yann avec date, heure et auteur obligatoires.
- Reconstruction de l’historique depuis les commits Git, le contexte partagé et les relais IA.
- Séparation explicite entre l’auteur du travail et l’identité enregistrée dans Git.
- Ajout d’une règle commune imposant la mise à jour du présent fichier à chaque intervention.
- Observation d’une modification locale concomitante de `README.md` à 13:07:25 ; auteur non déterminé, donc non attribué arbitrairement.

### Contrôles

- Chronologie Git lue du commit initial `0bbeaf7` au commit `eeff65c`.
- Dates et heures reprises au format ISO des métadonnées Git.

---

## 2026-06-19 11:59:04 — Claude — Révision après restauration des annexes

- **Auteur du travail :** Claude (claude-sonnet-4-6, d’après `IA/CONTEXT.md`)
- **Auteur Git :** `yann.danjaume <yann.danjaume@groupe-gpa.fr>`
- **Commit :** `eeff65c`
- **Type :** correction, contrôle
- **Portée :** 13 projets, `Documentation/References.md`, `IA/CONTEXT.md`
- **Source :** historique Git et contexte IA — **Historique reconstruit**

### Changements

- Remplacement du placeholder littéral `$SourceCommit` par `7db5550` dans les annexes restaurées.
- Ajout du lien croisé manquant entre WAFE — Donjon et `13_DONJON_A_PLUSIEURS.md`.
- Contrôle du catalogue, des en-têtes WAFE et de l’équilibre des annexes.

---

## 2026-06-19 11:52:53 — ChatGPT — Restauration de l’intégrité de Mixologie

- **Auteur du travail :** ChatGPT (Codex, GPT-5)
- **Auteur Git :** `ydanjaume <40659597+ydanjaume@users.noreply.github.com>`
- **Commit :** `b6d69b8`
- **Type :** correction, restauration, contrôle
- **Portée :** 13 projets, références, contexte IA, README et script de restauration
- **Source :** historique Git, conversation et contexte IA — **Historique reconstruit**

### Changements

- Détection de la perte des anciennes couches `NOTES-SOURCES` pendant la restructuration précédente.
- Restauration verbatim des notes dans des annexes repliables protégées par `SOURCE-ARCHIVE:BEGIN/END`.
- Conservation de la structure « un fichier par projet ».
- Restauration de l’affichage des images et contrôle de leurs empreintes.
- Création de `13_DONJON_A_PLUSIEURS.md` comme projet distinct de WAFE — Donjon.
- Remplacement des valeurs Notion artificielles `0/2`, `1/2`, `2/2` par les valeurs brutes `0`, `1`, `2` avec échelle non définie.
- Ajout d’une partie ChatGPT dans `IA/IA_Share.md` et adaptation des règles du contexte.

### Contrôles

- Anciens documents vérifiés dans les annexes.
- Liens locaux et médias contrôlés avant commit.

---

## 2026-06-19 11:29:18 — Claude — Restructuration en trois dossiers

- **Auteur du travail :** Claude (d’après le contexte et le message du commit)
- **Auteur Git :** `yann.danjaume <yann.danjaume@groupe-gpa.fr>`
- **Commit :** `4233aa1`
- **Type :** restructuration
- **Portée :** ensemble de `Résume/Mixologie`
- **Source :** historique Git et `IA/CONTEXT.md` — **Historique reconstruit**

### Changements

- Création des dossiers `IA/`, `Documentation/` et `Projets/`.
- Passage à un fichier Markdown par projet et création de `_exemple.md`.
- Déplacement des 16 médias sous `Projets/assets/`.
- Centralisation de `CONTEXT.md` et `IA_Share.md` dans `IA/`.

### Incident historique

- La suppression des fichiers séparés `NOTES-SOURCES` n’avait pas réintégré tout leur contenu ; cette régression a été corrigée par `b6d69b8`.

---

## 2026-06-19 11:04:39 — Claude — Première passe éditoriale sur Mixologie

- **Auteur du travail :** Claude (claude-sonnet-4-6)
- **Auteur Git :** `yann.danjaume <yann.danjaume@groupe-gpa.fr>`
- **Commit :** `7db5550`
- **Type :** correction éditoriale, auto-audit
- **Portée :** Boxe, Village, LandProtect, YNSECTS et `IA_Share.md`
- **Source :** historique Git et contexte IA — **Historique reconstruit**

### Changements

- Ajout des tableaux complets de cartes dans Boxe.
- Suppression ou marquage d’inférences non sourcées dans Village et LandProtect.
- Correction du thème YNSECTS en s’appuyant explicitement sur les visuels.
- Auto-critique Claude et premières règles de collaboration consignées dans `IA_Share.md`.

---

## 2026-06-19 10:50:18 — ChatGPT — Création de Mixologie

- **Auteur du travail :** ChatGPT (Codex, GPT-5)
- **Auteur Git :** `ydanjaume <40659597+ydanjaume@users.noreply.github.com>`
- **Commit :** `f3f7b75`
- **Type :** ajout, consolidation
- **Portée :** création de `Résume/Mixologie`, 50 fichiers
- **Source :** historique Git et conversation — **Historique reconstruit**

### Changements

- Combinaison des vues éditoriales Claude V2 et des transcriptions exhaustives ChatGPT V2.
- Organisation initiale par projet avec paire `README.md` / `NOTES-SOURCES.md`.
- Création d’un catalogue, des références, de `IA_Share.md` et d’un script de génération.
- Copie des 16 médias dans la bibliothèque consolidée.

---

## 2026-06-19 10:39:22 — Yann — Fusion des travaux parallèles

- **Auteur du travail :** Yann Danjaume
- **Auteur Git :** `yann.danjaume <yann.danjaume@groupe-gpa.fr>`
- **Commit :** `9c85591`
- **Type :** fusion Git
- **Portée :** branches contenant les sorties ChatGPT et Claude
- **Source :** historique Git — **Historique reconstruit**

### Changements

- Fusion de la branche distante `main` avec les travaux IA produits en parallèle.

---

## 2026-06-19 10:39:09 — Claude — Création des restitutions Claude V1 et V2

- **Auteur du travail :** Claude
- **Auteur Git :** `yann.danjaume <yann.danjaume@groupe-gpa.fr>`
- **Commit :** `fd2ce4d`
- **Type :** ajout, analyse, structuration éditoriale
- **Portée :** `Résume/Claude/V1` et `Résume/Claude/V2`
- **Source :** historique Git et contexte IA — **Historique reconstruit**

### Changements

- Création de 12 documents Claude V1 et 14 documents Claude V2.
- Organisation éditoriale par projet, fiches signalétiques, résumés et index.
- Séparation de King Battle, LandProtect et Donjon comme vues dédiées.

---

## 2026-06-19 10:39:09 — ChatGPT — Création des restitutions ChatGPT V1 et V2

- **Auteur du travail :** ChatGPT (Codex, GPT-5)
- **Auteur Git :** `ydanjaume <40659597+ydanjaume@users.noreply.github.com>`
- **Commit :** `ce7d8c5`
- **Type :** ajout, extraction, contrôle d’exhaustivité
- **Portée :** `Résume/ChatGPT/V1`, `Résume/ChatGPT/V2` et outils de génération
- **Source :** historique Git et conversation — **Historique reconstruit**

### Changements

- Extraction structurée des 11 DOCX OneNote, avec témoins textuels et médias.
- Copie fidèle des exports Notion et GitHub.
- Création d’un manifeste, d’un contrôle d’exhaustivité et d’une analyse transversale en V1.
- Création d’une bibliothèque Markdown organisée par projet en V2.

---

## 2026-06-19 09:51:47 — Yann — Structuration définitive des sources

- **Auteur du travail :** Yann Danjaume
- **Auteur Git :** `ydanjaume <40659597+ydanjaume@users.noreply.github.com>`
- **Commit :** `80e26a2`
- **Type :** restructuration des sources
- **Portée :** `Sources/Github`, `Sources/OneNote/.Docx`, `Sources/OneNote/.One`
- **Source :** historique Git — **Historique reconstruit**

### Changements

- Déplacement de Sheepering vers `Sources/Github/Sheepering.md`.
- Regroupement des exports OneNote DOCX et des fichiers `.one` dans deux sous-dossiers dédiés.
- Suppression des anciens emplacements devenus redondants.

---

## 2026-06-19 09:49:50 — Yann — Import de l’export Notion

- **Auteur du travail :** Yann Danjaume
- **Auteur Git :** `yann.danjaume <yann.danjaume@groupe-gpa.fr>`
- **Commit :** `6497f61`
- **Type :** ajout de sources
- **Portée :** `Sources/Notion`
- **Source :** historique Git — **Historique reconstruit**

### Changements

- Ajout des deux CSV Notion, de sept pages de projets et de trois images pour Base et de survie.

---

## 2026-06-19 09:48:03 — Yann — Centralisation initiale des sources

- **Auteur du travail :** Yann Danjaume
- **Auteur Git :** `ydanjaume <40659597+ydanjaume@users.noreply.github.com>`
- **Commit :** `ac0d186`
- **Type :** déplacement, ajout de sources
- **Portée :** création et alimentation de `Sources/`
- **Source :** historique Git — **Historique reconstruit**

### Changements

- Déplacement des fichiers OneNote depuis `Documentation/OneNote` vers `Sources/OneNote`.
- Ajout des exports DOCX OneNote sous un emplacement source dédié.
- Retrait d’anciennes conversions Claude et Wiki de leur emplacement initial.

---

## 2026-06-18 14:16:30 — Yann et première conversion Claude — Initialisation du dépôt

- **Auteur du travail :** Yann Danjaume ; présence d’une conversion attribuée à Claude d’après les chemins, détail exact non documenté
- **Auteur Git :** `yann.danjaume <yann.danjaume@groupe-gpa.fr>`
- **Commit :** `0bbeaf7`
- **Type :** initialisation, import, première conversion
- **Portée :** fichiers OneNote, `Documentation/OneNoteConversionClaude`, Wiki Obsidian
- **Source :** historique Git — **Historique reconstruit**

### Changements

- Ajout initial des fichiers `.one` et de l’index OneNote.
- Première conversion Markdown organisée attribuée à Claude par le nom du dossier.
- Création d’un Wiki Obsidian reprenant les projets et références.

### Limite de reconstruction

- Aucun journal IA de cette session initiale n’est disponible ; la répartition exacte entre travail manuel et génération Claude ne peut pas être certifiée.
