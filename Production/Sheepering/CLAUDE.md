# Sheepering — Guide IA

Jeu de société coopératif, 1–4 joueurs. Plateau hexagonal. Les joueurs incarnent des chiens de berger qui escortent un troupeau de la ferme à l'Alpage, contre des loups. Pas de défaite — le score est le nombre de moutons sauvés.

## État du projet

Version courante : **v1.4** (voir `regles/v1.4.md`).

### Décisions stables

- Plateau hexagonal. Zones de départ (Ferme + 5 Enclos) et d'arrivée (Alpage + 5 Pâturage) dédiées et symétriques, reliées par un chemin de 12 tuiles à coude, révélé et posé au fil du tirage — aucun motif fixe, orientation libre à la pose (avec règle de secours anti-chevauchement).
- Les effets des chemins spéciaux (forêt, rivière, col de montagne, ravin) sont portés directement par la tuile chemin — pas de terrain latéral à placer autour.
- Chiens : 3 déplacements + 1 action par tour. 4 types uniques, 1 exemplaire chacun.
- Loups : 3 déplacements. Plafond = 2 × nombre de chiens en jeu.
- Moutons : 2 déplacements, priorité automatique. Numérotés ; tirés aléatoirement parmi les 12 si la configuration en utilise moins.
- Chaque chien a 1 action spéciale, utilisable une seule fois par partie.
- Capacité de case uniforme : maximum 3 moutons par case, sans exception (Ferme, Enclos, Alpage, Pâturage inclus).
- Chaque carte Instincts sauvages garantit l'apparition d'au moins 1 loup, en plus de son effet propre.
- Fin de partie : 3 tours de rapatriement après que le berger atteint l'Alpage ou une tuile Pâturage adjacente.

## Fichiers

| Fichier | Rôle |
|---|---|
| `travail.md` | Brouillon actif — règles en cours + tâches + questions + notes de design |
| `ficheprojet.md` | Référence stable — concept, config, simulations, décisions figées |
| `CLAUDE.md` | Ce fichier — guide IA et protocole de contribution |
| `regles/v1.4.md` | Snapshot stable le plus récent |
| `regles/v1.3.md` / `v1.2.md` / `v1.1.md` | Versions précédentes archivées |
| `playtests/` | Comptes-rendus des parties physiques |
| `assets/` | Tuiles, pions, cartes (à créer) |

## Règles de contribution

Avant toute modification : lire `travail.md`.

Si une règle change :
1. Modifier directement dans `travail.md`
2. Documenter le changement dans les notes de design de `travail.md`
3. Quand la version se stabilise → créer `regles/v1.x.md` (prochain numéro) depuis `travail.md`
4. La version précédente devient archivée — ne plus la modifier

Ne jamais modifier une version archivée. Garder tous les documents en français.
