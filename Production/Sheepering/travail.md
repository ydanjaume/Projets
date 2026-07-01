# Sheepering — Document de travail

> Brouillon actif. Les règles ici évoluent librement. Quand elles se stabilisent → snapshot dans `regles/v1.3.md`.

---

## Prochaines étapes

### Règles
- [ ] Écrire un exemple complet de tour (à intégrer dans la prochaine version)
- [ ] Vérifier si 2 chemins forestiers suffisent pour stabiliser les apparitions de loups
- [ ] Vérifier si le col de montagne ne crée pas un goulot trop bloquant pour les moutons
- [ ] Trancher : les terrains latéraux des chemins spéciaux sont-ils déduits de la réserve globale ?

### Assets
- [ ] Tuiles terrain (prairie, forêt, rivière, montagne, trou) + 4 types de chemin
- [ ] Pions : moutons numérotés, chiens (4 types), berger, loups
- [ ] Cartes événements (~26 cartes, 4 familles)
- [ ] Jetons "action spéciale épuisée" (4 chiens)

### Playtesting
- [ ] Organiser une première partie physique (print & play minimaliste)
- [ ] Valider le ressenti des chiens à 3 déplacements
- [ ] Définir les niveaux de difficulté (nombre de forêts, fréquence des événements loups)

---

## Questions ouvertes

- [ ] 3 déplacements chiens : satisfaisant à la table ? (simulation = équivalent à 4, mais l'IA joue parfaitement — l'humain ressentira la différence)
- [ ] 2 chemins forestiers en v1.2 : garantissent-ils des loups sans saturer la partie ?
- [ ] Col de montagne : trop bloquant pour les moutons ou tension bien dosée ?
- [ ] Terrains latéraux des chemins spéciaux : dans la réserve ou en supplément ?
- [ ] Niveaux de difficulté : quels paramètres (forêts, fréquence loups, loups max, vitesse loups) ?
- [ ] Durée de partie cible : non définie

---

## Règles — version de travail (base v1.2)

*Modifier ici librement. Cette version deviendra `regles/v1.3.md` quand elle sera stable.*

---

### Objectif

Sauver le maximum de moutons. Un mouton atteignant le **pâturage final** est **immédiatement sauvé** : retiré du plateau et hors d'atteinte. Il n'y a pas de défaite — on cherche à faire mieux à chaque partie.

---

### Configuration

| Joueurs | Chiens | Moutons | Loups max | Répartition |
|---|---|---|---|---|
| 1 | 3 | 9 | 9 | Choisit 3 types parmi 4, contrôle les 3 |
| 2 | 4 | 12 | 12 | 2 chiens par joueur (2 types chacun) |
| 3 | 3 | 9 | 9 | Choisit 3 types parmi 4, 1 chien par joueur |
| 4 | 4 | 12 | 12 | 1 chien par joueur, 1 type chacun |

**Loups max = 3 × chiens.** Au-delà du plafond, aucun nouveau loup n'apparaît.
Les moutons sont **numérotés** (numéros uniques, jamais d'égalité).

---

### Mise en place

#### Plateau

**L'enclos de départ** : la ferme est entourée de 5 prairies ouvertes. La 6e direction ouvre sur le chemin.

**Le chemin** : 12 tuiles posées et révélées avant la partie — 6 droites + 6 diagonales (orientation gauche/droite aléatoire à la pose). Il relie l'enclos au pâturage final.

| Type de chemin | Quantité | Effet |
|---|---|---|
| Chemin de prairie | 8 | Chemin normal, sans effet |
| Chemin forestier | 2 | Compte comme une forêt révélée pour les événements loups |
| Pont / Gué | 1 | Franchissable, traverse une rivière |
| Col de montagne | 1 | Franchissable, passe entre des montagnes |

Quand une tuile chemin spéciale est posée, placer immédiatement les terrains associés sur les deux côtés du chemin, si les emplacements sont libres :

| Chemin spécial | Terrains à placer autour |
|---|---|
| Chemin forestier | 1 forêt de chaque côté |
| Pont / Gué | 1 rivière de chaque côté |
| Col de montagne | 1 montagne de chaque côté |

Si un emplacement est déjà occupé, placer le terrain sur la première case libre adjacente au chemin spécial. Un chemin spécial reste toujours franchissable par toutes les entités.

**Le terrain** : toute case occupée doit être entourée de tuiles révélées. Dès qu'une entité entre sur une case dont une case adjacente est vide, révéler immédiatement une tuile terrain.

**Orientation** : le nord est un côté fixe. Les 6 directions : nord, nord-est, sud-est, sud, sud-ouest, nord-ouest.

| Terrain | Qté | Franchissable par | Effet |
|---|---|---|---|
| Prairie | 16 | Tous | Aucun |
| Forêt | 5 | Tous | Génère des loups (événements) |
| Rivière | 5 | Tous | Stoppe le déplacement sur la case |
| Montagne | 3 | Personne | Infranchissable |
| Trou / Ravin | 2 | Chiens et loups | Infranchissable pour les moutons |

#### Placement initial

Les joueurs choisissent leurs types de chiens, puis placent librement sur la ferme et ses 5 prairies adjacentes : tous les moutons, tous les chiens, et le berger.

---

### Déroulement d'un tour

| Phase | Qui agit | Déplacements | Détail |
|---|---|---|---|
| Événement | — | — | Tirer 1 carte, défausser la précédente |
| Berger | Joueurs | 1 | Décision collective |
| Moutons | Auto | 2 | Ordre croissant des numéros |
| Chiens | Joueurs | 3 + 1 action | Ordre libre |
| Loups | Auto | 3 | Ciblage automatique |

Un obstacle (rivière, montagne) stoppe le déplacement restant. Les chiens peuvent choisir de ne pas utiliser tous leurs déplacements.

---

### Capacité des cases

**Maximum 3 moutons par case.** Le berger et les chiens ne comptent pas. L'enclos est illimité.

**Déplacement volontaire** : un mouton ne se déplace pas vers une case déjà pleine.

**Déplacement forcé** : fuite d'un loup, événement ou action chien — peut envoyer un mouton sur une case pleine, la poussée s'applique.

**Poussée** : si un mouton entre sur une case à 3 moutons, le mouton au **plus grand numéro** est poussé vers une case adjacente libre. S'il n'y en a pas, le mouton entrant reste.

**Attaque sur case pleine** : un loup sur une case à 3 moutons → le mouton au **plus petit numéro** est mangé.

> Règle générale : quand plusieurs moutons sont affectés simultanément, appliquer du **plus petit au plus grand numéro**.

---

### Chiens de berger

Chaque chien dispose de **3 déplacements** et **1 action** par tour, dans n'importe quel ordre.

Les chiens traversent tous les terrains et peuvent se trouver sur la même case. Passer sur un loup ne l'élimine pas.

#### Actions standard (tous les chiens, chaque tour)

| Action | Effet |
|---|---|
| Aboyer | Loups adjacents éliminés. Moutons adjacents fuient d'1 case dans la direction opposée au chien (axe mouton→chien inversé). Si bloqué : ne bougent pas. |
| Appeler | Moutons adjacents avancent d'1 case vers le chien. |
| Guider | Moutons sur la case du chien se déplacent vers 1 case adjacente au choix. |
| Sprint | +1 déplacement supplémentaire ce tour, en plus de l'action normale. |

#### Actions spéciales (1 usage par partie, s'ajoute à l'action normale)

| Chien | Action spéciale | Effet |
|---|---|---|
| Patou | **Gel** | Tous les loups immobilisés pendant 1 tour entier. |
| Border Collie | **Grand Sprint** | +2 déplacements supplémentaires ce tour. |
| Berger Allemand | **Grand Aboiement** | Élimine tous les loups dans un rayon de 2 cases. |
| Bouvier des Flandres | **Rassemblement** | Moutons sur la case et les 6 cases adjacentes avancent d'1 case vers le berger. |

Une action spéciale utilisée est définitivement épuisée — marquer le chien avec un jeton.

---

### Moutons et loups

#### Moutons — priorité de déplacement

1. **Fuir** un loup adjacent (forcé — ignore les cases pleines)
2. **Événement** en cours (forcé — ignore les cases pleines)
3. **Rejoindre la case du berger** (volontaire — s'arrête devant une case pleine)
4. **Rester immobile**

**Chemin le plus court** : à égalité de distance, priorité nord > nord-est > sud-est > sud > sud-ouest > nord-ouest.

#### Loups — ciblage et déplacement

Ciblent le **mouton le plus proche** (chemin le plus court, obstacles contournés sauf rivière). À égalité : **plus petit numéro**. Sans mouton sur le plateau, ne bougent pas. S'arrêtent avant la case d'un chien ou du berger. Peuvent partager une case entre eux.

Tiebreak de chemin : même priorité que les moutons (nord > …).

---

### Événements

1 carte tirée par tour, la précédente est **définitivement défaussée**. Effet valable ce tour uniquement. Le deck ne s'épuise jamais sur une partie.

#### Instincts sauvages

Niveaux d'apparition des loups :
🟡 Faible = 1 loup dans 1 forêt aléatoire | 🟠 Modéré = 1 loup par forêt à ≤4 cases du troupeau | 🔴 Fort = 1 loup dans toutes les forêts révélées

| Carte | Intensité | Effet |
|---|---|---|
| Odeur de proie | 🟠 Modéré | Loups proches. Cible : mouton le plus proche du berger. |
| Proie isolée | 🟡 Faible | 1 loup. Cible : mouton le plus éloigné du berger. |
| Territoire de chasse | 🔴 Fort | Loups partout. |
| Hurlement de la meute | — | Tous les loups gagnent +1 déplacement. |
| Faim de la meute | — | Les loups mangent puis se déplacent s'ils sont adjacents à un mouton. |
| Chasse nocturne | 🟡 Faible | 1 loup. Les chiens ne peuvent pas aboyer ce tour. |

#### Vices du troupeau

| Carte | Effet |
|---|---|
| Psychose | Les moutons fuient le berger. |
| Amour fugace | Les moutons seuls rejoignent la case avec le plus de moutons la plus proche. |
| Excès de zèle | Les moutons ignorent les chiens. |
| Faim débordante | Les moutons rejoignent la prairie la plus proche. |
| Procrastination | Les moutons ne bougent pas. |
| Appel de la nature | Les moutons rejoignent le chien le plus proche. |
| Territorialité | Les moutons ne peuvent pas entrer sur une case occupée. |

#### Humeurs du berger

| Carte | Effet |
|---|---|
| Amour du troupeau | Tous les moutons rejoignent le berger. |
| Travail mal fait | Les chiens dépensent tous leurs déplacements vers le berger. |
| Difficulté du métier | Les moutons adjacents au berger fuient d'une case. |
| Accélération incertaine | Le berger avance de 2 cases. |
| Mal du pays | Le berger recule d'une case. |
| Arrêt brutal | Le berger ne bouge pas. |

#### Éléments naturels

| Carte | Effet |
|---|---|
| Vent du nord | Toutes les entités gagnent +1 déplacement pour chaque case vers le nord. |
| Pluie battante | Toutes les entités ont vitesse 1. |
| Soleil brûlant | Les loups perdent 1 déplacement. |
| Terre meuble | Les déplacements sur prairie gagnent +1. |
| Brume épaisse | Les moutons ignorent le berger. |
| Foudre | Les chiens ne peuvent pas appeler ni aboyer. |
| Gel | Déplacements doublés et obligatoires dans la direction du premier déplacement du tour. |

---

### Fin de partie

Dès que le berger atteint le pâturage final → **3 tours de rapatriement** (jeu normal). Score = **moutons sauvés**.

---

### Référence rapide

| Entité | Dépl. | Règle clé |
|---|---|---|
| Berger | 1 | Ne compte pas dans la capacité des cases |
| Moutons | 2 | Max 3/case · ordre croissant · volontaire = s'arrête devant case pleine |
| Chiens | 3 + action | Ordre libre · traversent tout · même case OK · 1 action spéciale/partie |
| Loups | 3 | Contournent les obstacles · bloqués par chiens/berger |

**Priorité moutons :** Fuir loup → Événement → Berger → Immobile

**Conflit multi-moutons :** toujours du plus petit au plus grand numéro.

---

## Notes de design

### Pourquoi 3 déplacements pour les chiens

Statistiquement équivalent à 4 (delta max ±3 points selon les configs, dans les deux sens). La simulation ne mesure pas le ressenti tactique. Raisons du choix de 3 :
- Parité avec les loups → vraie course-poursuite
- Sprint (+1) garde un intérêt tactique réel
- Grand Sprint du Border Collie (+2) devient décisif au lieu d'être anecdotique
- Plus de tension, chaque déplacement compte

### Pourquoi les chemins thématiques (v1.2)

Problème identifié : avec un chemin entièrement neutre, certaines parties manquent de forêts près de la route, rendant le jeu trop linéaire. Les loups n'ont pas de points d'apparition pertinents.

Solution retenue : 4 types de tuile chemin dont 3 spéciaux qui placent des terrains autour d'eux à la pose. Garantit la présence de forêts, rivière et montagne dans toutes les parties.

À valider lors du premier playtest : 2 chemins forestiers suffisent-ils ? Le col ne bloque-t-il pas trop les moutons ?
