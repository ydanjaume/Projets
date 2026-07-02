# Sheepering — Fiche projet

## Concept

Les joueurs incarnent des **chiens de berger** qui escortent un troupeau de la **ferme** jusqu'à l'**Alpage**, en esquivant loups et événements imprévisibles. Pas de défaite — on cherche à faire mieux à chaque partie. Score = moutons sauvés.

| | |
|---|---|
| **Type** | Coopératif, plateau hexagonal |
| **Joueurs** | 1 à 4 |
| **Durée** | — (non définie) |
| **Version courante** | v1.4 (voir `regles/v1.4.md`) |
| **État** | Prototype — règles en évolution active, non fabriqué physiquement |

---

## Piliers de design (stables)

- Pas de défaite — scoring par moutons sauvés, progression de partie en partie
- 4 chiens asymétriques, 1 exemplaire chacun, 1 action spéciale par partie (s'ajoute à l'action normale)
- Moutons à priorité automatique : fuir loup → événement → berger → immobile
- Événements : 1 carte tirée par tour, défaussée immédiatement, 4 familles ; chaque carte Instincts sauvages garantit l'apparition d'au moins 1 loup
- Plateau hexagonal : zones de départ (Ferme + 5 Enclos) et d'arrivée (Alpage + 5 Pâturage) dédiées et symétriques, reliées par un chemin de 12 tuiles à coude, révélé et posé au fil du tirage avant la partie
- Capacité de case uniforme : maximum 3 moutons par case, sans exception

---

## Configuration (validée)

| Joueurs | Chiens | Moutons | Loups max | Répartition |
|---|---|---|---|---|
| 1 | 3 | 9 | 6 | Choisit 3 types parmi 4, contrôle les 3 |
| 2 | 4 | 12 | 8 | 2 chiens par joueur |
| 3 | 3 | 9 | 6 | 1 chien par joueur, 3 types parmi 4 |
| 4 | 4 | 12 | 8 | 1 chien par joueur |

Loups max = 2 × chiens (plafond volontairement bas pour éviter le carnage).

---

## Résultats de simulation (référence)

*100–200 parties par configuration. L'IA joue parfaitement — les chiffres surestiment les vrais joueurs.*

> ⚠️ Simulations antérieures aux changements v1.4 du 2026-07-02 (plafond loups 3× → 2× chiens, spawn garanti sur chaque carte Instincts sauvages, zones Enclos/Alpage/Pâturage). À rejouer pour rester représentatives.

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
| Chemin à coude (4 tuiles penchées sur 12), posé au feeling (v1.4) | Tracé sinueux et organique sans motif fixe à mémoriser ; boucle fermée mathématiquement impossible ; règle de secours si chevauchement |
| Effets de chemin portés directement par la tuile (v1.3) | Remplace le placement de terrains latéraux (v1.2, setup trop lourd) — chemin et terrain partagent le même effet par type |
| Zones de départ/arrivée dédiées : Enclos et Pâturage (v1.4) | Ferme + 5 Enclos / Alpage + 5 Pâturage, symétriques — identité visuelle propre, sauvetage dès l'entrée dans l'une des tuiles de la zone d'arrivée |
| Loups max = 2 × chiens (v1.4) | Plafond volontairement bas pour éviter le carnage, même en cas de pic de spawn |
| Spawn garanti sur chaque carte Instincts sauvages (v1.4) | Corrige un taux de spawn initial de ~7,7 % (2 cartes sur 26) qui risquait de ne jamais faire apparaître de loup en partie |
| Fin de partie : 3 tours de rapatriement | Donne le temps de rentrer les derniers moutons sans prolonger inutilement |
| Action spéciale s'ajoute à l'action normale | Elle ne remplace pas — sinon elle punit son usage |

---

## Fichiers du projet

| Fichier | Rôle |
|---|---|
| `ficheprojet.md` | Ce fichier — référence stable |
| `travail.md` | Brouillon actif : règles en cours + tâches + questions + échanges |
| `CLAUDE.md` | Protocole de contribution |
| `regles/v1.4.md` | Snapshot stable le plus récent |
| `regles/v1.3.md` / `v1.2.md` / `v1.1.md` | Versions précédentes archivées |
| `playtests/` | Comptes-rendus des parties physiques |
| `assets/` | Tuiles, pions, cartes (à créer) |
