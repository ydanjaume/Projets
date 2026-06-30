# Sheepering — Guide IA

Jeu de société coopératif, 1–4 joueurs. Plateau hexagonal. Les joueurs incarnent des chiens de berger qui escortent un troupeau de la ferme au pâturage final, contre des loups. Pas de défaite — le score est le nombre de moutons sauvés.

## État du projet

Version courante : **v1.2**.

### Décisions stables

- Plateau hexagonal, chemin de 12 tuiles dont des chemins thématiques (forêt, pont/gué, col de montagne).
- Les chemins spéciaux placent des terrains révélés autour d'eux (forêts, rivière, montagnes).
- Chiens : 3 déplacements + 1 action par tour. 4 types uniques, 1 exemplaire chacun.
- Loups : 3 déplacements.
- Moutons : 2 déplacements, priorité automatique.
- Chaque chien a 1 action spéciale, utilisable une seule fois par partie.
- Fin de partie : 3 tours de rapatriement après que le berger atteint le pâturage final.

### Questions ouvertes

- Écrire un exemple complet de tour dans les règles.
- Valider physiquement le ressenti des chiens à 3 déplacements.
- Définir des niveaux de difficulté (nombre de forêts, fréquence des événements loups).

## Fichiers

| Fichier | Rôle |
|---|---|
| `regles/v1.2.md` | Règles en vigueur |
| `regles/v1.1.md` | Version précédente archivée |
| `journal.md` | Historique de toutes les décisions de design |
| `assets/` | PNG des tuiles, chiens, événements, pions + SVG templates |
| `assets/generate.py` | Script de génération des PNG depuis les SVG |

## Règles de contribution

Avant toute modification : lire ce fichier, puis `journal.md`.

Si une règle change :
1. Créer `regles/v1.3.md` (copie de `v1.2.md` comme base)
2. Modifier les règles dans le nouveau fichier
3. Documenter la décision dans `journal.md`
4. `v1.2.md` devient archivée — ne plus la modifier

Ne jamais modifier une version archivée. Garder tous les documents en français.
