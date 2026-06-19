# 🐑 SHEEPERING
Jeu coopératif • Plateau hexagonal • 1 à 4 joueurs

Les joueurs incarnent des **chiens de berger** qui escortent un troupeau de la **ferme** jusqu'au **pâturage final**, en évitant loups et événements imprévisibles.

---

## 1. Objectif

Sauver le maximum de moutons. Un mouton atteignant le **pâturage final** est **immédiatement sauvé** : retiré du plateau et hors d'atteinte. Il n'y a pas de défaite — on cherche à faire mieux à chaque partie.

---

## 2. Configuration

Il existe **4 types de chiens**, chacun en un seul exemplaire. Chaque joueur contrôle un type différent — deux joueurs ne peuvent pas jouer le même chien.

| Joueurs | Chiens | Moutons | Loups max | Répartition |
| ------- | ------ | ------- | --------- | ----------- |
| 1       | 3      | 9       | 9         | Choisit 3 types parmi 4, contrôle les 3 |
| 2       | 4      | 12      | 12        | 2 chiens par joueur (2 types chacun) |
| 3       | 3      | 9       | 9         | Choisit 3 types parmi 4, 1 chien par joueur |
| 4       | 4      | 12      | 12        | 1 chien par joueur, 1 type chacun |

**Loups max = 3 × chiens.** Au-delà du plafond, aucun nouveau loup n'apparaît.
Les moutons sont **numérotés** (numéros uniques, jamais d'égalité).

---

## 3. Mise en place

#### Plateau

**L'enclos de départ** : la ferme est entourée de 5 prairies ouvertes. La 6e direction de la ferme ouvre sur le chemin.

**Le chemin** : 12 tuiles posées et révélées avant la partie — 6 droites + 6 diagonales (orientation gauche/droite aléatoire à la pose). Il relie l'enclos au pâturage final.

Le chemin n'est pas uniquement composé de prairies : certaines tuiles chemin traversent des terrains particuliers. Cela garantit que la route comporte des zones de tension et que certains terrains importants apparaissent toujours pendant la partie.

| Type de chemin | Quantité | Effet |
| -------------- | -------- | ----- |
| Chemin de prairie | 8 | Chemin normal, sans effet particulier |
| Chemin forestier | 2 | Compte comme une forêt révélée pour les événements loups |
| Pont / Gué | 1 | Chemin franchissable qui traverse une rivière |
| Col de montagne | 1 | Chemin franchissable qui passe entre des montagnes |

#### Pose des chemins spéciaux

Quand une tuile chemin spéciale est posée, placer immédiatement les terrains associés sur les deux côtés du chemin, si les emplacements sont libres.

| Chemin spécial | Terrains à placer autour |
| -------------- | ------------------------ |
| Chemin forestier | 1 forêt de chaque côté du chemin |
| Pont / Gué | 1 rivière de chaque côté du chemin |
| Col de montagne | 1 montagne de chaque côté du chemin |

Les terrains placés par les chemins spéciaux sont révélés dès la mise en place. Ils comptent comme des terrains normaux pour toutes les règles.

Si un emplacement latéral est déjà occupé par une autre tuile obligatoire, ne pas déplacer cette tuile : placer le terrain associé sur la première case libre adjacente au chemin spécial, en priorité du côté concerné.

Un chemin spécial reste toujours franchissable par toutes les entités. Ce sont les terrains placés autour qui créent les obstacles ou les zones de danger.

**Le terrain** : toute case **occupée** doit être entourée de tuiles révélées. Dès qu'une entité entre sur une case dont une case adjacente est vide, on pioche et révèle immédiatement une tuile terrain pour la combler.

**Orientation de la grille** : le nord est un côté fixe de la grille hexagonale. Les 6 directions sont : nord, nord-est, sud-est, sud, sud-ouest, nord-ouest.

| Terrain      | Qté | Franchissable par | Effet                                 |
| ------------ | --- | ----------------- | ------------------------------------- |
| Prairie      | 16  | Tous              | Aucun                                 |
| Forêt        | 5   | Tous              | Génère des loups (événements)         |
| Rivière      | 5   | Tous              | Stoppe le déplacement sur la case     |
| Montagne     | 3   | Personne          | Infranchissable                       |
| Trou / Ravin | 2   | Chiens et loups   | Infranchissable pour les moutons      |

#### Placement initial

Les joueurs choisissent leurs types de chiens, puis placent librement sur la ferme et ses 5 prairies adjacentes : tous les **moutons**, tous les **chiens**, et le **berger**.

---

## 4. Déroulement d'un tour

| Phase     | Qui agit | Déplacements | Détail                                  |
| --------- | -------- | ------------ | --------------------------------------- |
| Événement | —        | —            | Tirer 1 carte, défausser la précédente  |
| Berger    | Joueurs  | 1            | Décision collective                     |
| Moutons   | Auto     | 2            | Dans l'ordre croissant des numéros      |
| Chiens    | Joueurs  | 3 + 1 action | Ordre libre (voir §6)                   |
| Loups     | Auto     | 3            | Ciblage automatique (voir §7)           |

> Toute entité se déplace de son nombre attitré. Un obstacle (rivière, montagne) stoppe le déplacement restant. Les chiens peuvent choisir de ne pas utiliser tous leurs déplacements.

---

## 5. Capacité des cases

**Maximum 3 moutons par case.** Le berger et les chiens ne comptent pas dans cette limite. L'enclos de départ est illimité.

**Déplacement volontaire** : un mouton ne se déplace pas de lui-même vers une case déjà pleine (3 moutons).

**Déplacement forcé** : la fuite d'un loup, un événement ou l'action d'un chien peuvent envoyer un mouton sur une case pleine — la poussée s'applique alors normalement.

**Poussée** : si un mouton entre sur une case à 3 moutons, le mouton au **plus grand numéro** est poussé vers une case adjacente libre. S'il n'y en a pas, le mouton entrant reste sur place.

**Attaque sur case pleine** : si un loup arrive sur une case à 3 moutons, le mouton au **plus petit numéro** est mangé.

> Règle générale : quand plusieurs moutons sont affectés simultanément, appliquer toujours du **plus petit au plus grand numéro**.

---

## 6. Chiens de berger

Chaque chien dispose de **3 déplacements** et **1 action** par tour, utilisables dans n'importe quel ordre.

Les chiens traversent **tous les terrains** et peuvent se trouver sur la même case. Passer sur un loup ne l'élimine pas.

#### Actions standard

Disponibles pour tous les chiens, à chaque tour.

| Action  | Effet |
| ------- | ----- |
| Aboyer  | Loups adjacents éliminés. Moutons adjacents fuient d'1 case dans la direction **opposée au chien** (axe mouton→chien inversé). Si bloqué : ne bougent pas. |
| Appeler | Moutons adjacents avancent d'1 case vers le chien. |
| Guider  | Moutons sur la case du chien se déplacent vers 1 case adjacente au choix. |
| Sprint  | +1 déplacement supplémentaire ce tour, **en plus** de l'action normale. |

#### Types de chiens et actions spéciales

Chaque chien possède **1 action spéciale**, utilisable **une seule fois par partie**. Elle s'ajoute à l'action normale du tour — elle ne la remplace pas.

| Type                 | Action spéciale | Effet |
| -------------------- | --------------- | ----- |
| 🐑 Patou              | **Gel**         | Tous les loups sont immobilisés pendant **1 tour entier** (ils ne se déplacent pas et n'attaquent pas). |
| 🐕 Border Collie      | **Grand Sprint** | +2 déplacements supplémentaires ce tour (au lieu de +1 pour le Sprint normal), en plus de l'action normale. |
| 🐾 Berger Allemand    | **Grand Aboiement** | Élimine tous les loups dans un rayon de **2 cases** autour du chien. |
| 🦮 Bouvier des Flandres | **Rassemblement** | Tous les moutons sur la case du chien **et sur les 6 cases adjacentes** avancent d'1 case vers le berger. |

> Une action spéciale utilisée est **définitivement épuisée**. Marquer le chien concerné avec un jeton pour s'en souvenir.

---

## 7. Moutons et loups

#### Moutons — priorité de déplacement

1. **Fuir** un loup adjacent (forcé — ignore les cases pleines)
2. **Événement** en cours (forcé — ignore les cases pleines)
3. **Rejoindre la case du berger** (volontaire — s'arrête devant une case pleine)
4. **Rester immobile**

Les moutons ne bougent jamais si leur action est impossible (case bloquée, terrain infranchissable).

**Chemin le plus court** : en cas d'égalité de distance, priorité à la direction la plus proche du nord (nord > nord-est > sud-est > sud > sud-ouest > nord-ouest).

#### Loups — ciblage et déplacement

Les loups ciblent le **mouton le plus proche** (chemin le plus court, obstacles contournés sauf rivière), à égalité : le **plus petit numéro**. Sans mouton sur le plateau, ils ne bougent pas. Ils s'arrêtent avant la case d'un chien ou du berger. Ils peuvent partager une case entre eux.

Tiebreak de chemin identique aux moutons : priorité nord > nord-est > sud-est > sud > sud-ouest > nord-ouest.

---

## 8. Événements

1 carte tirée par tour, la précédente est **définitivement défaussée**. Effet valable ce tour uniquement. Le deck ne s'épuise jamais sur une partie.

---

### 🐺 Instincts sauvages

**Niveaux d'apparition des loups :**
🟡 Faible = 1 loup dans 1 forêt aléatoire | 🟠 Modéré = 1 loup par forêt à ≤4 cases du troupeau | 🔴 Fort = 1 loup dans toutes les forêts révélées

| Carte                 | Intensité  | Effet |
| --------------------- | ---------- | ----- |
| Odeur de proie        | 🟠 Modéré | Loups proches. Cible : mouton le plus proche du berger. |
| Proie isolée          | 🟡 Faible | 1 loup. Cible : mouton le plus éloigné du berger. |
| Territoire de chasse  | 🔴 Fort   | Loups partout. |
| Hurlement de la meute | —          | Tous les loups gagnent +1 déplacement. |
| Faim de la meute      | —          | Les loups mangent **puis** se déplacent s'ils sont adjacents à un mouton. |
| Chasse nocturne       | 🟡 Faible | 1 loup. Les chiens ne peuvent pas aboyer ce tour. |

---

### 🐑 Vices du troupeau

| Carte              | Effet |
| ------------------ | ----- |
| Psychose           | Les moutons fuient le berger. |
| Amour fugace       | Les moutons seuls rejoignent la case avec le plus de moutons la plus proche. |
| Excès de zèle      | Les moutons ignorent les chiens. |
| Faim débordante    | Les moutons rejoignent la prairie la plus proche. |
| Procrastination    | Les moutons ne bougent pas. |
| Appel de la nature | Les moutons rejoignent le chien le plus proche. |
| Territorialité     | Les moutons ne peuvent pas entrer sur une case occupée. |

---

### 🧑 Humeurs du berger

| Carte                   | Effet |
| ----------------------- | ----- |
| Amour du troupeau       | Tous les moutons rejoignent le berger. |
| Travail mal fait        | Les chiens dépensent tous leurs déplacements vers le berger. |
| Difficulté du métier    | Les moutons adjacents au berger fuient d'une case. |
| Accélération incertaine | Le berger avance de 2 cases. |
| Mal du pays             | Le berger recule d'une case. |
| Arrêt brutal            | Le berger ne bouge pas. |

---

### 🌦 Éléments naturels

| Carte          | Effet |
| -------------- | ----- |
| Vent du nord   | Toutes les entités gagnent +1 déplacement pour chaque case vers le nord. |
| Pluie battante | Toutes les entités ont vitesse 1. |
| Soleil brûlant | Les loups perdent 1 déplacement. |
| Terre meuble   | Les déplacements sur prairie gagnent +1. |
| Brume épaisse  | Les moutons ignorent le berger. |
| Foudre         | Les chiens ne peuvent pas appeler ni aboyer. |
| Gel            | Déplacements doublés et obligatoires — chaque pas continue dans la direction choisie au premier déplacement du tour (glissement). |

---

## 9. Fin de partie

Dès que le berger atteint le pâturage final, **3 tours de rapatriement** commencent (jeu normal). À l'issue du 3e tour, la partie se termine. Score = **nombre de moutons sauvés**.

---

## 📋 Référence rapide

| Entité  | Dépl.    | Règle clé |
| ------- | -------- | --------- |
| Berger  | 1        | Ne compte pas dans la capacité des cases |
| Moutons | 2        | Max 3/case · ordre croissant · volontaire = s'arrête devant case pleine |
| Chiens  | 3+action | Ordre libre · traversent tout · même case OK · 1 action spéciale/partie |
| Loups   | 3        | Contournent les obstacles · bloqués par chiens/berger |

| Chien               | Action spéciale    | Usage |
| ------------------- | ------------------ | ----- |
| Patou               | Gel (loups immobiles 1 tour) | 1× par partie |
| Border Collie       | Grand Sprint (+2 dépl.) | 1× par partie |
| Berger Allemand     | Grand Aboiement (portée 2) | 1× par partie |
| Bouvier des Flandres | Rassemblement (zone 7 cases) | 1× par partie |

**Priorité moutons :** Fuir loup → Événement → Berger → Immobile

**Conflit multi-moutons :** toujours du plus petit au plus grand numéro.

---

*v1.2 — Prototype en cours de conception.*
