# Sheepering — Document de travail

> Brouillon actif. Les règles ici évoluent librement. Quand elles se stabilisent → snapshot dans `regles/v1.3.md`.

---

## Prochaines étapes

### Règles
- [ ] Écrire un exemple complet de tour (format à définir)
- [ ] Définir la disposition fixe des tuiles chemin pour la partie initiation
- [ ] Écrire la section "Partie initiation" (disposition fixe + règles simplifiées si nécessaire)
- [ ] Valider les effets des chemins spéciaux à la table (forêt, rivière, col, éboulis)

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
- [ ] Chemin forêt : 2 occurrences suffisent-elles pour garantir des apparitions de loups sans saturer ?
- [ ] Chemin rivière (stoppe sur la case) : trop punitif sur le chemin principal ?
- [ ] Col de montagne à 2 moutons max : tension satisfaisante ou trop bloquant ?
- [ ] Ravin (chemin) : les moutons trouvent-ils naturellement un détour par le terrain adjacent ou est-ce frustrant ?
- [ ] Niveaux de difficulté : quels paramètres (nombre de chemins spéciaux, fréquence loups, loups max) ?
- [ ] Durée de partie cible : non définie

---

## Règles — version de travail (base v1.2)

*Modifier ici librement. Cette version deviendra `regles/v1.3.md` quand elle sera stable.*

> **Niveaux de jeu prévus :**
> - **Initiation** : disposition fixe des tuiles chemin (à définir), règles simplifiées si besoin
> - **Standard** : disposition aléatoire des tuiles chemin

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
| Chemin de prairie | 7 | Chemin normal, sans effet |
| Chemin forêt | 2 | Compte comme une forêt pour les événements loups — point d'apparition |
| Chemin rivière | 1 | Stoppe le déplacement sur la case (même effet que la rivière terrain) |
| Col de montagne | 1 | Capacité 2 moutons maximum (au lieu de 3) |
| Ravin | 1 | Infranchissable pour les moutons — chiens, loups et berger passent normalement |

Les chemins spéciaux n'ont aucune règle de pose particulière — leurs effets s'appliquent directement sur la case, sans terrain à placer autour.

**Le terrain** : toute case occupée doit être entourée de tuiles révélées. Dès qu'une entité entre sur une case dont une case adjacente est vide, révéler immédiatement une tuile terrain.

**Orientation** : le nord est un côté fixe. Les 6 directions : nord, nord-est, sud-est, sud, sud-ouest, nord-ouest.

| Terrain | Qté | Franchissable par | Effet |
|---|---|---|---|
| Prairie | 40 | Tous | Aucun — dont 5 réservées pour entourer la ferme au départ |
| Forêt | 5 | Tous | Génère des loups (événements) |
| Rivière | 5 | Tous | Stoppe le déplacement sur la case |
| Montagne | 5 | Personne | Infranchissable |
| Ravin | 5 | Chiens et loups | Infranchissable pour les moutons |

*Total : 60 tuiles. Deck aléatoire après mise en place (55 tuiles) : ~65 % prairie, ~9 % de chaque terrain spécial. Combiné aux chemins : 7 forêts, 6 rivières, 5 montagnes, 6 ravins potentiels sur la table.*

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
| Aboyer | Loups adjacents éliminés. |
| Conduire | Pousse 1 mouton adjacent d'1 case dans la direction opposée au chien. |
| Guider | Moutons sur la case du chien se déplacent vers 1 case adjacente au choix. |
| Sprint | +2 déplacements supplémentaires ce tour — remplace l'action normale. |

#### Actions spéciales (1 usage par partie, s'ajoute à l'action normale)

| Chien | Action spéciale | Effet |
|---|---|---|
| Patou | **Gel** | Tous les loups immobilisés pendant 1 tour entier. |
| Border Collie | **Grand Sprint** | Utiliser Sprint et une autre action (Aboyer, Conduire ou Guider) le même tour — 5 déplacements + 1 action. |
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

*Référence : Besoins primaires du prédateur*

Niveaux d'apparition des loups :
🟡 Faible = 1 loup dans 1 forêt aléatoire | 🟠 Modéré = 1 loup par forêt à ≤4 cases du troupeau | 🔴 Fort = 1 loup dans toutes les forêts révélées

| Carte | Besoin | Effet |
|---|---|---|
| Odeur de proie | Chasse | Les loups effectuent immédiatement 1 déplacement supplémentaire vers leur cible, avant la phase loups normale. |
| Proie isolée | Survie | Ce tour, tous les loups ciblent le mouton le plus éloigné du berger au lieu du plus proche. |
| Territoire de chasse | Territoire | 🔴 1 loup dans toutes les forêts révélées. Les moutons adjacents à un loup fuient d'1 case supplémentaire ce tour. |
| Hurlement de la meute | Appartenance | Chaque loup adjacent à un autre loup se déplace immédiatement d'1 case pour s'éloigner de ses voisins loups. |
| Faim de la meute | Faim | Tout mouton mangé ce tour fait apparaître 1 loup supplémentaire dans la forêt la plus proche. |
| Chasse nocturne | Rythme | 🟡 1 loup. Aboyer et Grand Aboiement sont sans effet ce tour. |

#### Vices du troupeau

*Référence : Les 7 péchés capitaux*

| Carte | Péché | Effet |
|---|---|---|
| Psychose | Colère | Les moutons fuient le berger. |
| Amour fugace | Luxure | Les moutons seuls rejoignent la case avec le plus de moutons la plus proche. |
| Excès de zèle | Orgueil | Les moutons ignorent les chiens. |
| Faim débordante | Gourmandise | Les moutons rejoignent la prairie la plus proche. |
| Procrastination | Paresse | Les moutons ne bougent pas. |
| Appel de la nature | Envie | Les moutons rejoignent le chien le plus proche. |
| Territorialité | Avarice | Les moutons ne peuvent pas entrer sur une case occupée. |

#### Humeurs du berger

*Référence : Les 6 émotions de base (Ekman)*

| Carte | Émotion | Effet |
|---|---|---|
| Amour du troupeau | Joie | Tous les moutons rejoignent le berger. |
| Mal du pays | Tristesse | Le berger recule d'une case. |
| Difficulté du métier | Dégoût | Les moutons adjacents au berger fuient d'une case. |
| Arrêt brutal | Peur | Le berger ne bouge pas. |
| Travail mal fait | Colère | Les chiens dépensent tous leurs déplacements vers le berger. |
| Accélération incertaine | Surprise | Le berger avance de 2 cases. |

#### Éléments naturels

*Référence : Les 4 éléments*

| Carte | Élément | Effet |
|---|---|---|
| Vent du nord | Air | Toutes les entités gagnent +1 déplacement pour chaque case vers la prairie. |
| Brume épaisse | Brume | Les moutons ignorent le berger. |
| Pluie battante | Eau | Toutes les entités ont vitesse 1. |
| Gel | Glace | Déplacements doublés et obligatoires dans la direction du premier déplacement du tour. |
| Soleil brûlant | Feu | Les loups perdent 1 déplacement. |
| Foudre | Foudre | Les chiens ne peuvent pas conduire ni aboyer. |
| Terre meuble | Terre | Les déplacements sur prairie gagnent +1. |

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
- Sprint (+2) garde un intérêt tactique réel (5 déplacements vs 3 normaux)
- Grand Sprint du Border Collie (Sprint + action) devient une combinaison décisive
- Plus de tension, chaque déplacement compte

### Border Collie — Grand Sprint redesigné

Sprint passe de +1 à +2 déplacements (pour tous les chiens). Grand Sprint du Border Collie change de nature : au lieu d'être "encore plus de déplacements", il permet de combiner Sprint et une autre action le même tour (5 déplacements + 1 action, une fois par partie). Le Border Collie devient le seul chien capable d'agir et de sprinter simultanément — identité tactique propre, pas juste un chien plus rapide.

Traits passifs à envisager pour tous les chiens (idée ouverte, à traiter en playtest).

### Évolution des chemins thématiques (v1.2 → v1.3)

**v1.2** : les tuiles chemin spéciales plaçaient des terrains latéraux à la pose (forêts, rivière, montagnes autour du chemin). Problème : règle de pose complexe, question de réserve non résolue, setup lourd.

**v1.3** : les effets sont portés directement par les tuiles chemin, sans placement latéral.

| Chemin | Effet |
|---|---|
| Forêt | Point d'apparition loups (même règle que les forêts terrain) |
| Rivière | Stoppe le déplacement sur la case (même règle que la rivière terrain) |
| Col de montagne | Capacité 2 moutons max sur la case (au lieu de 3) |
| Ravin | Infranchissable pour les moutons (même règle que le ravin terrain) |

Règle unifiée : chemin et terrain partagent toujours le même effet pour un type donné. Pas de règle spéciale à mémoriser selon qu'on est sur le chemin ou hors chemin.

À valider lors du premier playtest : rivière sur le chemin trop punitive ? Col trop bloquant ? Ravin — détour naturel ou frustrant ?
