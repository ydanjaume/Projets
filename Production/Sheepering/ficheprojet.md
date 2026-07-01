# Sheepering — Fiche projet

## Concept

Les joueurs incarnent des **chiens de berger** qui escortent un troupeau de la **ferme** jusqu'au **pâturage final**, en esquivant loups et événements imprévisibles. Pas de défaite — on cherche à faire mieux à chaque partie. Score = moutons sauvés.

| | |
|---|---|
| **Type** | Coopératif, plateau hexagonal |
| **Joueurs** | 1 à 4 |
| **Durée** | — (non définie) |
| **Version courante** | v1.2 |
| **État** | Prototype — règles stables, non fabriqué physiquement |

---

## Piliers de design (stables)

- Pas de défaite — scoring par moutons sauvés, progression de partie en partie
- 4 chiens asymétriques, 1 exemplaire chacun, 1 action spéciale par partie (s'ajoute à l'action normale)
- Moutons à priorité automatique : fuir loup → événement → berger → immobile
- Événements : 1 carte tirée par tour, défaussée immédiatement, 4 familles
- Plateau hexagonal, chemin de 12 tuiles révélé entièrement avant la partie

---

## Configuration (validée)

| Joueurs | Chiens | Moutons | Loups max | Répartition |
|---|---|---|---|---|
| 1 | 3 | 9 | 9 | Choisit 3 types parmi 4, contrôle les 3 |
| 2 | 4 | 12 | 12 | 2 chiens par joueur |
| 3 | 3 | 9 | 9 | 1 chien par joueur, 3 types parmi 4 |
| 4 | 4 | 12 | 12 | 1 chien par joueur |

---

## Résultats de simulation (référence)

*100–200 parties par configuration. L'IA joue parfaitement — les chiffres surestiment les vrais joueurs.*

| Configuration | Taux de survie |
|---|---|
| Baseline (sans types de chiens, 4 dépl.) | ~40–45 % |
| Avec types + actions spéciales (3 dépl.) | 77–88 % |

**Meilleures combinaisons :**

| Joueurs | Combo | Score |
|---|---|---|
| 1 | Patou + Border Collie + Berger Allemand | 85.1 % |
| 2 | J1 : Patou + Bouvier / J2 : Border + Berger Allemand | 87.9 % |
| 3 | Patou + Berger Allemand + Bouvier | 87.3 % |
| 4 | Seule combo possible | 84.3 % |

Chien le plus précieux : **Berger Allemand** (Grand Aboiement portée 2 — décisif contre les pics de loups).
Chien le moins indispensable : **Border Collie** (son absence est la moins pénalisante).

*Limite : la simulation mesure un comportement parfait. Pour le ressenti tactique (frustration, tension), seul le test à la table répond.*

---

## Décisions figées

| Décision | Justification |
|---|---|
| 3 déplacements pour les chiens | Parité avec les loups, Sprint garde son intérêt tactique, Grand Sprint du Border devient décisif |
| Chemins thématiques (v1.2) | Garantit la présence de forêts, rivière et montagne — évite les parties sans zones de tension |
| Terrains latéraux révélés à la pose | Crée des zones d'entrée pour les loups dès la mise en place |
| Fin de partie : 3 tours de rapatriement | Donne le temps de rentrer les derniers moutons sans prolonger inutilement |
| Action spéciale s'ajoute à l'action normale | Elle ne remplace pas — sinon elle punit son usage |

---

## Fichiers du projet

| Fichier | Rôle |
|---|---|
| `ficheprojet.md` | Ce fichier — référence stable |
| `travail.md` | Brouillon actif : règles en cours + tâches + questions + échanges |
| `CLAUDE.md` | Protocole de contribution |
| `regles/v1.2.md` | Snapshot stable des règles actuelles |
| `regles/v1.1.md` | Version précédente archivée |
| `playtests/` | Comptes-rendus des parties physiques |
| `assets/` | Tuiles, pions, cartes (à créer) |
