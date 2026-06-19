# Sheepering
> Source : GitHub — `Sources/Github/Sheepering.md` — v1.2

---

## Résumé

| | |
|---|---|
| **Thème** | Troupeau, Chiens de berger, Nature |
| **État** | Prototype en cours de conception |
| **Type** | Plateau coopératif hexagonal |
| **Joueurs** | 1 à 4 |
| **Difficulté** | Moyen |
| **Interaction** | Coopération |
| **Envie de dév.** | ★★★★★ |
| **Inspirations** | — |

> Les joueurs incarnent des **chiens de berger** qui escortent un troupeau de la ferme jusqu'au pâturage final, en évitant loups et événements imprévisibles. Pas de défaite — on cherche à sauver le maximum de moutons à chaque partie.

---

## Objectif

Un mouton atteignant le **pâturage final** est **immédiatement sauvé** : retiré du plateau, hors d'atteinte. Score final = nombre de moutons sauvés.

---

## Configuration par nombre de joueurs

| Joueurs | Chiens | Moutons | Loups max | Répartition |
|---------|--------|---------|-----------|-------------|
| 1 | 3 | 9 | 9 | Choisit 3 types parmi 4, contrôle les 3 |
| 2 | 4 | 12 | 12 | 2 chiens par joueur (2 types chacun) |
| 3 | 3 | 9 | 9 | Choisit 3 types parmi 4, 1 chien par joueur |
| 4 | 4 | 12 | 12 | 1 chien par joueur, 1 type chacun |

- **Loups max = 3 × chiens.** Au-delà, aucun nouveau loup n'apparaît.
- Les moutons sont **numérotés** — numéros uniques, jamais d'égalité.

---

## Mise en place

### Le chemin

12 tuiles posées et révélées avant la partie : 6 droites + 6 diagonales (orientation aléatoire). Relie l'enclos au pâturage final.

| Type de tuile | Qté | Effet |
|---------------|-----|-------|
| Chemin de prairie | 8 | Aucun effet |
| Chemin forestier | 2 | Compte comme forêt révélée pour les événements loups |
| Pont / Gué | 1 | Franchissable, traverse une rivière |
| Col de montagne | 1 | Franchissable, passe entre des montagnes |

**Terrains posés automatiquement** lors d'une tuile chemin spéciale :

| Chemin spécial | Terrains à placer sur les côtés |
|----------------|---------------------------------|
| Chemin forestier | 1 forêt de chaque côté |
| Pont / Gué | 1 rivière de chaque côté |
| Col de montagne | 1 montagne de chaque côté |

> Si l'emplacement latéral est occupé, placer sur la première case libre adjacente du côté concerné. Un chemin spécial reste toujours franchissable.

### Le terrain (révélation dynamique)

Toute case **occupée** doit être entourée de tuiles révélées. Dès qu'une entité entre sur une case dont une case adjacente est vide → piocher et révéler immédiatement une tuile terrain.

| Terrain | Qté | Franchissable | Effet |
|---------|-----|---------------|-------|
| Prairie | 16 | Tous | Aucun |
| Forêt | 5 | Tous | Génère des loups (événements) |
| Rivière | 5 | Tous | Stoppe le déplacement sur la case |
| Montagne | 3 | Personne | Infranchissable |
| Trou / Ravin | 2 | Chiens & loups | Infranchissable pour les moutons |

**Orientation :** Nord fixe. Les 6 directions : nord, nord-est, sud-est, sud, sud-ouest, nord-ouest.

### Placement initial

Les joueurs choisissent leurs chiens, puis placent librement sur la ferme et ses 5 prairies adjacentes : tous les moutons, tous les chiens, et le berger.

---

## Déroulement d'un tour

| Phase | Qui agit | Déplacements | Détail |
|-------|----------|-------------|--------|
| **Événement** | — | — | Tirer 1 carte, défausser la précédente définitivement |
| **Berger** | Joueurs | 1 | Décision collective |
| **Moutons** | Auto | 2 | Ordre croissant des numéros |
| **Chiens** | Joueurs | 3 + 1 action | Ordre libre |
| **Loups** | Auto | 3 | Ciblage automatique |

> Un obstacle (rivière, montagne) stoppe le déplacement restant. Les chiens peuvent choisir de ne pas tout utiliser.

---

## Capacité des cases et poussée

- **Maximum 3 moutons par case.** Berger et chiens ne comptent pas. L'enclos de départ est illimité.
- **Déplacement volontaire** : un mouton ne se déplace pas vers une case pleine.
- **Déplacement forcé** (fuite, événement, action chien) : peut envoyer vers une case pleine → poussée active.
- **Poussée** : le mouton au **plus grand numéro** est poussé vers une case adjacente libre. Si aucune, le mouton entrant reste sur place.
- **Attaque sur case pleine** : le loup mange le mouton au **plus petit numéro**.

> Règle générale : quand plusieurs moutons sont affectés simultanément → toujours du **plus petit au plus grand numéro**.

---

## Chiens de berger

### Système

Chaque chien : **3 déplacements + 1 action** par tour, dans n'importe quel ordre. Traversent tous les terrains. Peuvent se trouver sur la même case. Passer sur un loup ne l'élimine pas.

### Actions standard (tous les chiens, chaque tour)

| Action | Effet |
|--------|-------|
| **Aboyer** | Loups adjacents éliminés. Moutons adjacents fuient d'1 case dans la direction opposée au chien. Si bloqué : ne bougent pas. |
| **Appeler** | Moutons adjacents avancent d'1 case vers le chien. |
| **Guider** | Moutons sur la case du chien se déplacent vers 1 case adjacente au choix. |
| **Sprint** | +1 déplacement supplémentaire ce tour, en plus de l'action normale. |

### Actions spéciales (1× par partie, s'ajoute à l'action normale)

| Chien | Action spéciale | Effet |
|-------|-----------------|-------|
| 🐑 Patou | **Gel** | Tous les loups immobilisés pendant 1 tour entier (pas de déplacement, pas d'attaque). |
| 🐕 Border Collie | **Grand Sprint** | +2 déplacements ce tour (au lieu de +1). |
| 🐾 Berger Allemand | **Grand Aboiement** | Élimine tous les loups dans un rayon de 2 cases. |
| 🦮 Bouvier des Flandres | **Rassemblement** | Tous les moutons sur la case du chien et les 6 cases adjacentes avancent d'1 case vers le berger. |

> Action spéciale utilisée = **définitivement épuisée**. Marquer le chien avec un jeton.

---

## Moutons — Priorité de déplacement

1. **Fuir** un loup adjacent *(forcé — ignore les cases pleines)*
2. **Événement** en cours *(forcé — ignore les cases pleines)*
3. **Rejoindre le berger** *(volontaire — s'arrête devant une case pleine)*
4. **Rester immobile**

**Tiebreak de chemin** (égalité de distance) : priorité nord > nord-est > sud-est > sud > sud-ouest > nord-ouest.

---

## Loups — Ciblage et déplacement

- Ciblent le **mouton le plus proche** (chemin le plus court, obstacles contournés sauf rivière).
- À égalité de distance → le **plus petit numéro**.
- Sans mouton sur le plateau → ne bougent pas.
- S'arrêtent avant la case d'un chien ou du berger.
- Peuvent partager une case entre eux.
- Même tiebreak de direction que les moutons.

---

## Événements

1 carte tirée par tour, la précédente est **définitivement défaussée**. Effet valable ce tour uniquement. Le deck ne s'épuise jamais.

### Instincts sauvages — Apparition de loups

| Intensité | Règle |
|-----------|-------|
| 🟡 Faible | 1 loup dans 1 forêt aléatoire |
| 🟠 Modéré | 1 loup par forêt à ≤ 4 cases du troupeau |
| 🔴 Fort | 1 loup dans toutes les forêts révélées |

| Carte | Intensité | Effet |
|-------|-----------|-------|
| Odeur de proie | 🟠 Modéré | Loups proches. Cible : mouton le plus proche du berger. |
| Proie isolée | 🟡 Faible | 1 loup. Cible : mouton le plus éloigné du berger. |
| Territoire de chasse | 🔴 Fort | Loups partout. |
| Hurlement de la meute | — | Tous les loups gagnent +1 déplacement. |
| Faim de la meute | — | Les loups mangent **puis** se déplacent s'ils sont adjacents à un mouton. |
| Chasse nocturne | 🟡 Faible | 1 loup. Les chiens ne peuvent pas aboyer ce tour. |

### Vices du troupeau

| Carte | Effet |
|-------|-------|
| Psychose | Les moutons fuient le berger. |
| Amour fugace | Les moutons seuls rejoignent la case avec le plus de moutons la plus proche. |
| Excès de zèle | Les moutons ignorent les chiens. |
| Faim débordante | Les moutons rejoignent la prairie la plus proche. |
| Procrastination | Les moutons ne bougent pas. |
| Appel de la nature | Les moutons rejoignent le chien le plus proche. |
| Territorialité | Les moutons ne peuvent pas entrer sur une case occupée. |

### Humeurs du berger

| Carte | Effet |
|-------|-------|
| Amour du troupeau | Tous les moutons rejoignent le berger. |
| Travail mal fait | Les chiens dépensent tous leurs déplacements vers le berger. |
| Difficulté du métier | Les moutons adjacents au berger fuient d'une case. |
| Accélération incertaine | Le berger avance de 2 cases. |
| Mal du pays | Le berger recule d'une case. |
| Arrêt brutal | Le berger ne bouge pas. |

### Éléments naturels

| Carte | Effet |
|-------|-------|
| Vent du nord | Toutes les entités gagnent +1 déplacement pour chaque case vers le nord. |
| Pluie battante | Toutes les entités ont vitesse 1. |
| Soleil brûlant | Les loups perdent 1 déplacement. |
| Terre meuble | Les déplacements sur prairie gagnent +1. |
| Brume épaisse | Les moutons ignorent le berger. |
| Foudre | Les chiens ne peuvent pas appeler ni aboyer. |
| Gel | Déplacements doublés et obligatoires — glissement dans la direction du premier déplacement du tour. |

---

## Fin de partie

Dès que le berger atteint le pâturage final → **3 tours de rapatriement** (jeu normal). Score = **moutons sauvés**.

---

## Référence rapide

| Entité | Dépl. | Règle clé |
|--------|-------|-----------|
| Berger | 1 | Ne compte pas dans la capacité des cases |
| Moutons | 2 | Max 3/case · ordre croissant · volontaire = s'arrête case pleine |
| Chiens | 3 + action | Traversent tout · même case OK · 1 action spéciale/partie |
| Loups | 3 | Contournent les obstacles · bloqués par chiens/berger |

**Priorité moutons :** Fuir loup → Événement → Berger → Immobile

**Conflit multi-moutons :** toujours du plus petit au plus grand numéro.
