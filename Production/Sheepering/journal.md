# 🐑 Sheepering — Journal de projet

Résumé de toutes les décisions de design prises au cours du développement du prototype.

---

## 1. Concept de base

Jeu coopératif sur plateau hexagonal, 1 à 4 joueurs. Les joueurs incarnent des chiens de berger qui escortent un troupeau de moutons de la ferme au pâturage final, en évitant loups et événements imprévisibles. Pas de condition de défaite — on cherche à faire mieux à chaque partie.

---

## 2. Configuration des joueurs

| Joueurs | Chiens | Moutons | Loups max |
|---------|--------|---------|-----------|
| 1 | 3 | 9 | 9 |
| 2 | 4 | 12 | 12 |
| 3 | 3 | 9 | 9 |
| 4 | 4 | 12 | 12 |

Chiens : entre 3 et 4 pour donner autant de chiens par joueur que possible sans descendre sous 3. Loups max = 3 × chiens.

---

## 3. Plateau

### Enclos de départ
La ferme est entourée de 5 prairies **ouvertes** (non fermées — les moutons peuvent s'éparpiller dès le début, créant potentiellement du carnage immédiat). La 6e direction ouvre sur le chemin.

### Chemin
12 tuiles (réduit depuis 15) : 6 droites + 6 diagonales (orientation gauche/droite aléatoire à la pose). Révélé entièrement avant la partie.

### Terrain
Toute case occupée doit être entourée de tuiles révélées — révélation au fur et à mesure, pas seulement au bord du plateau.

| Terrain | Quantité | Notes |
|---------|----------|-------|
| Prairie | 16 | Terrain neutre majoritaire |
| Forêt | 5 | Génère des loups via événements |
| Rivière | 5 | Stoppe le déplacement sur la case |
| Montagne | 3 | Infranchissable |
| Trou/Ravin | 2 | Bloque les moutons, pas les chiens/loups |

### Placement initial
Tous les moutons et chiens sont placés librement par les joueurs dans l'enclos avant le début. Pas d'apparition progressive.

---

## 4. Vitesses et déplacements

| Entité | Déplacements |
|--------|-------------|
| Berger | 1 |
| Moutons | 2 |
| Chiens | **3** (décision finale — voir §10) |
| Loups | 3 |

---

## 5. Règles de déplacement

### Moutons — priorité
1. Fuir un loup adjacent (forcé — ignore les cases pleines)
2. Appliquer l'événement (forcé — ignore les cases pleines)
3. Rejoindre la case du berger (volontaire — s'arrête devant une case pleine)
4. Rester immobile

**Déplacement volontaire vs forcé** : distinction clé — un mouton ne va jamais volontairement sur une case pleine, mais peut y être envoyé de force (loup, événement, action chien), déclenchant alors la poussée.

**Tiebreak chemin le plus court** : nord > nord-est > sud-est > sud > sud-ouest > nord-ouest.

### Loups — ciblage
Mouton le plus proche (obstacles contournés, rivière traversée en s'arrêtant dessus). À égalité : plus petit numéro. S'arrêtent avant la case d'un chien ou du berger.

### Aboyer — direction
Direction exacte axe mouton→chien inversé (case à 180°). Si bloqué : le mouton ne bouge pas.

### Gel (événement)
Déplacements doublés et obligatoires dans la direction du premier déplacement du tour.

### Vent du nord
S'applique à toutes les entités.

### Faim de la meute
Les loups mangent **puis** se déplacent.

---

## 6. Capacité des cases

Maximum 3 moutons par case. Berger et chiens ne comptent pas. Enclos illimité.

**Poussée** : un mouton entre sur une case pleine → le plus grand numéro est poussé vers une case adjacente libre. Si aucune : le mouton entrant reste.

**Attaque sur case pleine** : un loup arrive → le plus petit numéro est mangé.

Règle générale : toujours appliquer du plus petit au plus grand numéro.

---

## 7. Types de chiens

4 types, chacun en **un seul exemplaire**. On ne peut pas jouer deux chiens du même type.

| Joueurs | Répartition |
|---------|-------------|
| 1 | Choisit 3 types parmi 4, contrôle les 3 |
| 2 | 2 chiens par joueur (2 types chacun) |
| 3 | Choisit 3 types parmi 4, 1 chien par joueur |
| 4 | 1 chien par joueur, 1 type chacun |

### Actions standard (tous les chiens, chaque tour)

| Action | Effet |
|--------|-------|
| Aboyer | Élimine loups adjacents, moutons adjacents fuient à l'opposé |
| Appeler | Moutons adjacents avancent d'1 case vers le chien |
| Guider | Moutons sur la case se déplacent vers une case adjacente au choix |
| Sprint | +1 déplacement ce tour, en plus de l'action normale |

### Actions spéciales (1 usage par partie, s'ajoute à l'action normale)

| Chien | Action spéciale | Effet |
|-------|-----------------|-------|
| 🐑 Patou | Gel | Tous les loups immobilisés pendant 1 tour entier |
| 🐕 Border Collie | Grand Sprint | +2 déplacements supplémentaires (au lieu de +1) |
| 🐾 Berger Allemand | Grand Aboiement | Élimine tous les loups dans un rayon de 2 cases |
| 🦮 Bouvier des Flandres | Rassemblement | Moutons sur la case et les 6 cases adjacentes avancent d'1 case vers le berger |

Marquer le chien d'un jeton quand l'action spéciale est utilisée.

---

## 8. Événements

1 carte tirée par tour, la précédente est définitivement défaussée. Le deck ne s'épuise jamais sur une partie. 4 familles : Instincts sauvages (loups), Vices du troupeau, Humeurs du berger, Éléments naturels.

**Loups — graduation d'intensité :**
- 🟡 Faible = 1 loup dans 1 forêt aléatoire
- 🟠 Modéré = 1 loup par forêt à ≤4 cases du troupeau
- 🔴 Fort = 1 loup dans toutes les forêts révélées

---

## 9. Fin de partie

Dès que le berger atteint le pâturage final → 3 tours de rapatriement (jeu normal). Score = moutons sauvés. Un mouton atteignant le pâturage est immédiatement sauvé et retiré du plateau.

---

## 10. Décisions issues des simulations

Toutes les simulations ont été réalisées sur 100 à 200 parties par configuration.

### Baseline (sans types de chiens, 4 déplacements)
Taux de survie moyen : ~40-45%. Distribution très bipolaire (beaucoup de 0 ET beaucoup de parfaites) — le jeu dépend fortement de l'aléatoire du plateau et des événements.

### Sprint (+1 déplacement, remplace l'action)
Impact non significatif statistiquement (+2% max). L'IA joue parfaitement donc ne bénéficie pas du déplacement supplémentaire. À la table, l'impact serait plus fort car les vrais joueurs font des erreurs.

### Types de chiens avec actions spéciales (1 par partie)
Gain massif et cohérent : +42 à +44 points de taux de survie vs baseline. Tous les types se tiennent entre 77% et 88% — équilibre bon.

**Chien le plus précieux** : Berger Allemand (Grand Aboiement portée 2 — décisif contre les pics de loups).
**Chien le moins indispensable** : Border Collie (son absence est la moins pénalisante).
**Meilleures combos par config** :
- 1 joueur → Patou + Border + Berger Allemand (85.1%)
- 2 joueurs → J1: Patou+Bouvier / J2: Border+Berger (87.9%)
- 3 joueurs → Patou + Berger Allemand + Bouvier (87.3%)
- 4 joueurs → La seule combo possible (84.3%)

### 3 déplacements vs 4 déplacements (chiens)
**Décision : 3 déplacements.**
Statistiquement équivalent (delta max de ±3 points selon les configs, dans les deux sens). La simulation ne peut pas mesurer le ressenti tactique car l'IA joue parfaitement — un vrai joueur ressentirait bien plus la différence. Raisons du choix de 3 :
- Parité avec les loups (3 dépl.) → vraie course-poursuite
- Sprint (+1) reste un gain tactique significatif
- Grand Sprint du Border Collie (+2) devient décisif
- Plus de tension, chaque déplacement compte

**Limite du simulateur** : il mesure un comportement parfait, pas humain. Pour tout ce qui touche au ressenti tactique (est-ce frustrant ? est-ce excitant ?), seul le test à la table répondra.

---

## 11. Points encore à explorer

- Niveaux de difficulté (nombre de forêts, fréquence des événements loups)
- Exemple de tour complet à écrire pour les règles
- Test physique à la table pour valider le ressenti des 3 déplacements

---

## 12. Évolution v1.2 — chemins thématiques

Décision : créer une version `v1.2` avec des tuiles chemin spéciales.

Problème identifié : avec un chemin entièrement neutre, une partie peut manquer de terrains importants près de la route, notamment de forêts pour les apparitions de loups. Le chemin risque alors de devenir trop linéaire et moins tactique.

Changement retenu :

| Type de chemin | Quantité | Rôle |
| -------------- | -------- | ---- |
| Chemin de prairie | 8 | Chemin normal |
| Chemin forestier | 2 | Garantit des forêts sur ou près de la route |
| Pont / Gué | 1 | Garantit une traversée de rivière |
| Col de montagne | 1 | Crée un passage resserré par des montagnes |

Règle ajoutée : quand un chemin spécial est posé, il place des terrains révélés de chaque côté du chemin. Les chemins forestiers placent des forêts, le pont / gué place de l'eau, et le col de montagne place des montagnes.

Intention :

- Garantir la présence de zones de forêt, rivière et montagne dans toutes les parties.
- Donner aux loups des points d'apparition plus pertinents.
- Créer des passages tactiques sans rendre le chemin infranchissable.
- Rendre la route plus narrative : prairie, bois, rivière, montagne.

À tester :

- Vérifier si 2 chemins forestiers suffisent pour stabiliser les apparitions de loups.
- Vérifier si le col de montagne ne bloque pas trop les moutons.
- Décider si les terrains latéraux placés par les chemins spéciaux doivent être déduits de la réserve globale de terrains.
