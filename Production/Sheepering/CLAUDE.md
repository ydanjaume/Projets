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

## Fichiers

| Fichier | Rôle |
|---|---|
| `travail.md` | Brouillon actif — règles en cours + tâches + questions + notes de design |
| `ficheprojet.md` | Référence stable — concept, config, simulations, décisions figées |
| `CLAUDE.md` | Ce fichier — guide IA et protocole de contribution |
| `regles/v1.2.md` | Snapshot stable des règles actuelles |
| `regles/v1.1.md` | Version précédente archivée |
| `playtests/` | Comptes-rendus des parties physiques |
| `assets/` | Tuiles, pions, cartes (à créer) |

## Règles de contribution

Avant toute modification : lire `travail.md`.

Si une règle change :
1. Modifier directement dans `travail.md`
2. Quand la version se stabilise → créer `regles/v1.3.md` depuis `travail.md`
3. Documenter le changement dans les notes de design de `travail.md`
4. `regles/v1.2.md` devient archivée — ne plus la modifier

Si une règle change :
1. Créer `regles/v1.3.md` (copie de `v1.2.md` comme base)
2. Modifier les règles dans le nouveau fichier
3. Documenter la décision dans `journal.md`
4. `v1.2.md` devient archivée — ne plus la modifier

Ne jamais modifier une version archivée. Garder tous les documents en français.
