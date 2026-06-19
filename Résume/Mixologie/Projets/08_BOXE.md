# Sport — Boxe
> Sources : OneNote `Sport - BOXE.docx` — juillet 2025

---

## Résumé

| | |
|---|---|
| **Thème** | Boxe, Combat, Sport |
| **État** | En cours |
| **Type** | Jeu de cartes — versus 1 vs 1 |
| **Joueurs** | 2 |
| **Difficulté** | Moyen |
| **Interaction** | Versus |
| **Envie de dév.** | — [Non renseigné dans les sources] |
| **Inspirations** | — |

> *Jeu de cartes dans lequel deux joueurs incarnent chacun un boxeur. À chaque tour, les deux joueurs choisissent secrètement une carte et la révèlent simultanément. Le vainqueur est celui qui réduit les PV de l'adversaire à 0 en gérant intelligemment son énergie, son initiative et ses coups.*

---

## Statistiques de base *(4 juillet 2025)*

| Stat | Maximum | Récupération | Effet du vide |
|------|---------|-------------|---------------|
| Vie | 10 | +2 par tour | 5 pts perdus en 1 round → KO · Tout perdu → KO |
| Énergie | 15 | +5 par tour | Tout perdu → Récupération forcée |

**Initiative :**
- Prise lorsqu'une attaque touche l'adversaire
- Accorde +1 en vitesse

---

## Principes de base

- Chaque joueur a **5 cartes en main**
- Réserve d'énergie de départ : 3 ⚡ *(ajustable selon tests)*
- PV de départ : 10 à 15 *(à équilibrer)*
- Les deux joueurs choisissent secrètement puis révèlent **simultanément**
- Résolution selon priorité, contres et initiative

---

## Initiative

L'initiative détermine qui peut jouer certains coups spéciaux (Crochet, Uppercut).

**Changement de camp quand un joueur :**
- Touche l'adversaire (attaque non contrée)
- Réussit une défense ou un contre
- Joue une garde ou une esquive réussie

**Règle particulière :** Le Clinch fait perdre l'initiative même s'il réussit.

---

## Énergie

- Chaque carte a un **coût en énergie ⚡**
- Certaines cartes **récupèrent** de l'énergie *(ex : Garde = –1 ⚡)*
- Si le joueur n'a plus assez d'énergie : passer ou jouer une action gratuite (Garde, Esquive)

---

## Cartes — Tableaux complets

*Deux versions du tableau existent dans les sources (brouillon + version reformatée). Les deux sont conservés car ils ne contiennent pas exactement les mêmes données.*

### Version brouillon OneNote *(tableau original)*

| Nom | Portée | Coût | Dégât | Désarmé | Initiative | Contre |
|-----|--------|------|-------|---------|-----------|--------|
| Jab | 2 | 1 | 1 | Non | — | Clinch |
| Croisé | 2 | Jab | 2 | Non | — | Clinch |
| Crochet | 1 | 2 | 3 | Oui | Oui | Garde |
| Uppercut | 1 | 3 | 5 | Oui | Oui | Garde |
| Direct | 2 | 2 | 3 | Oui | Oui | Esquive, Clinch |
| Garde | 2 | 0 | 0 | Non | — | Jab/Croisé, Direct, Uppercut |
| Esquive | 2 | 2 | 0 | Non | — | Crochet, Direct, Uppercut |
| Contre | 2 | Parade | ×2 | Oui | — | Tout |
| Clinch | 1 | –4 | 0 | Non | — | — |
| Parade | 2 | 1 | 0 | Oui | Oui | Crochet |
| Avancer | — | 0 | — | — | — | — |
| Reculer | — | 0 | — | — | — | — |
| Récupérer | — | –2 | — | — | — | — |

### Version reformatée *(données étendues)*

| Nom | Vitesse | Portée | Énergie | Dégât | État | Description |
|-----|---------|--------|---------|-------|------|-------------|
| Jab | 1 | 2 | –1 | 1 | — | — |
| Croisé | 2 | 2 | 0 | 2 | — | Nécessite initiative |
| Crochet | 6 | 1 | –2 | 2 | Détruit la garde + Assomme | Nécessite initiative |
| Uppercut | 7 | 1 | –3 | 5 | Assomme | Nécessite initiative |
| Direct | 4 | 2 | –2 | 3 | Assomme | — |
| Garde | 0 | 2 | –1 | — | — | — |
| Esquive | 0 | 2 | –3 | — | — | — |
| Contre | 3 | 2 | –3 | ×2 | — | — |
| Clinch | 5 | 1 | +2 | — | — | — |
| Récupérer | — | — | +3 | — | — | — |
| Avancer | — | — | –1 | — | Déplacement +1 | — |
| Reculer | — | — | –1 | — | Déplacement –1 | — |

### Tableau synthétique (contres et prérequis)

| Carte | ⚡ Coût | 💥 Dégâts | 🔁 Contre | 🛡️ Contrée par | Init. requise | Notes |
|-------|---------|-----------|----------|--------------|--------------|-------|
| Jab | 1 | 1 | Uppercut, Clinch | Crochet, Garde, Esquive | Non | Rapide, reprend l'initiative |
| Crochet | 1 | 2 | Jab, Clinch | Garde, Esquive | Oui | Enchaîne efficacement après Jab |
| Uppercut | 3 | 3 | Garde | Jab, Esquive | Oui | Puissant, passe la Garde, lisible |
| Garde | –1 | 0 | Jab, Crochet | Uppercut | Non | Rend 1 ⚡ si réussie |
| Esquive | 0 | 0 | Crochet, Uppercut | Jab | Non | Anti-gros coups, rend l'initiative |
| Contre | 2 | ×1 | Toute attaque directe | Rien si aucune attaque en face | Non | Risqué mais puissant si deviné |
| Clinch | –2 | 0 | — | Jab, Crochet | Non | +2 ⚡ mais perd toujours l'initiative |

---

## Notes tactiques

| Situation | Conseil |
|-----------|---------|
| Jab → Crochet | Combo de base très rentable |
| Garde | Défense polyvalente et récupératrice |
| Uppercut | Le plus puissant mais facilement contré |
| Esquive | Efficace contre les gros coups, faible contre le Jab |
| Contre | Pari fort : annule et riposte si deviné correctement |
| Clinch | Permet de recharger, mais doit être bien placé (risqué) |

---

## Règles optionnelles *(propositions)*

| Option | Détail |
|--------|--------|
| Deck fermé | Petit deck à épuisement — ex : 3 exemplaires de chaque type de carte |
| Effet KO | Si un joueur reçoit 3 dégâts en 1 tour → jet de "stabilité" pour rester debout |
| Cartes bonus événement | Fatigue · Sang · Seconde chance · etc. |


---

<!-- SOURCE-ARCHIVE:BEGIN -->
## Annexe — Notes sources exhaustives

<details>
<summary>Afficher la transcription exhaustive et les variantes historiques</summary>

> Cette annexe est la couche de référence restaurée depuis Mixologie avant restructuration (7db5550). Elle ne doit pas être condensée. Seuls les chemins des médias ont été adaptés à la nouvelle arborescence.

> **Couche exhaustive — ChatGPT V2.** Ce document conserve les formulations, variantes, répétitions, dates, tableaux et médias issus des exports. Il fait foi lorsqu’une synthèse éditoriale simplifie ou interprète un point.

# Jeu de cartes de boxe

## Général

vendredi 4 juillet 2025

22:06

| Nom | Portée | Cout | Degat | Désarmé | Initiative | Contre |
| --- | --- | --- | --- | --- | --- | --- |
| Jab | 2 | 1 | 1 | Non |  | Clinch |
| Croisé | 2 | Jab | 2 | Non |  | Clinch |
| Crochet | 1 | 2 | 3 | Oui | Oui | Garde |
| Uppercut | 1 | 3 | 5 | Oui | Oui | Garde |
| Direct | 2 | 2 | 3 | Oui | Oui | Esquive, Clinch |
| Garde | 2 | 0 | 0 | Non |  | Jab/Croisé, Direct,Uppercut |
| Esquive | 2 | 2 | 0 | Non |  | Crochet, Direct, Uppercut |
| Contre | 2 | Parade | X2 | Oui |  | Tout |
| Clinch | 1 | -4 | 0 | Non |  |  |
| Parade | 2 | 1 | 0 | Oui | Oui | Crochet |
| Avancer |  | 0 |  |  |  |  |
| Reculer |  | 0 |  |  |  |  |
| Récupérer |  | -2 |  |  |  |  |

| **Nom ** | **Vitesse** | **Portée ** | **Energie** | **Degat ** | **Etat** | **Description** |
| --- | --- | --- | --- | --- | --- | --- |
| Jab  | 1 | 2  | -1 | 1  |   |   |
| Croisé  | 2 | 2  | 0 | 2  |   | Necessite initiative |
| Crochet  | 6 | 1  | -2 | 2 | Détruit la garde + Assome | Necessite initiative |
| Uppercut  | 7 | 1  | -3 | 5  | Assome | Necessite initiative |
| Direct  | 4 | 2  | -2 | 3 |  Assome |   |
| Garde  |  0 | 2 | -1 |   |   |   |
| Esquive  |  0 | 2 | -3 |   |   |   |
| Contre  |  3 | 2  | -3 | X2  |   |   |
| Clinch  | 5 | 1  | 2 |   |   |   |
| Récupérer  |   |   | 3 |   |   |   |
| Avancer |   |   | -1 |   | Déplacement +1 |   |
| Reculer |   |   | -1 |   | Déplacement -1 |   |

Autre :

- Initiative :

  - Prise quand attaque touche

  - Donne un en vitesse

- Vie :

  - Maximum 10

  - Récupération 2 par tour

  - 5 pts perdu dans un round => KO, Tout perdu => KO

- Energie :

  - Maximum 15

  - Récupération 5 par tour

  - Tout perdu => Récupération forcée

## Chatgpt

vendredi 4 juillet 2025

22:15

### 🎲 Jeu de cartes de Boxe – Résumé Complet

#### 🥊 Objectif du jeu

Chaque joueur incarne un boxeur. Le but est de **réduire les points de vie de l’adversaire à 0** en gérant l'énergie, l’initiative et les coups.

### 🧠 Principes de base

- Chaque joueur possède :

  - **5 cartes** en main (représentant différents coups ou défenses)

  - Une réserve d'**énergie** (⚡), par exemple de 3 au départ *(ajustable selon tests)*

  - Un nombre de **points de vie** (ex : 10-15 PV, à équilibrer)

- À chaque tour, les joueurs **choisissent secrètement une carte** et la révèlent en même temps.

- La **résolution** se fait selon les règles de priorité, contres, initiative, etc.

### 🔄 Initiative

#### 🎯 Qu’est-ce que l’initiative ?

- L’initiative détermine qui peut utiliser certains coups spéciaux (comme le Crochet ou l’Uppercut).

- Elle **commence aléatoirement** au début de la partie.

- Elle **change de camp** dès qu’un joueur :

  - **Touche** l’adversaire (attaque non contrée)

  - **Réussit une défense ou un contre**

  - Joue une garde ou une esquive réussie

- **Le Clinch** fait **perdre automatiquement l’initiative**, même s’il fonctionne.

### ⚡ Énergie

- Chaque carte a un **coût en énergie** (⚡)

- Certaines cartes **rendent de l’énergie** (ex : Garde = –1 ⚡)

- Si un joueur **n’a plus assez d’énergie** pour jouer une carte, il doit passer ou jouer une action gratuite (Garde, Esquive…)

### 🧩 Tableau des cartes

| Carte | ⚡ Coût | 💥 Dégâts | 🔁 Contre ces cartes | 🛡️ Est contrée par ces cartes | 🎯 Initiative requise | 🧠 Remarques principales |
| --- | --- | --- | --- | --- | --- | --- |
| **Jab** | 1 | 1 | Uppercut, Clinch | **Crochet, Garde, Esquive** | ❌ Non | Rapide et clé pour reprendre l’initiative |
| **Crochet** | 1 | 2 | Jab, Clinch | **Garde, Esquive** | ✅ Oui | Enchaînement efficace après un Jab réussi |
| **Uppercut** | 3 | 3 | Garde | **Jab, Esquive** | ✅ Oui | Puissant, passe la Garde, mais très lisible |
| **Garde** | –1 | 0 | Jab, Crochet | **Uppercut** | ❌ Non | Rend 1 ⚡ si réussie, utile pour casser le rythme |
| **Esquive** | 0 | 0 | Crochet, Uppercut | **Jab** | ❌ Non | Parfaite contre gros coups, rend initiative |
| **Contre** | 2 | 1 | Toute attaque directe | **Échec si aucune attaque en face** | ❌ Non | Risqué, mais frappe + initiative si réussi |
| **Clinch** | –2 | 0 | — | **Jab, Crochet** | ❌ Non | Récupère 2 ⚡, mais **perd toujours l’initiative** |

### 🧠 Notes tactiques

- Jab → Crochet = combo de base très rentable

- **Garde** est une défense polyvalente et récupératrice

- **Uppercut** est le plus puissant mais facilement contré

- **Esquive** est l’anti-gros coups, mais faible contre Jab

- **Contre** est un pari fort : annule et frappe si deviné juste

- **Clinch** sert à recharger, mais doit être bien placé (risqué)

### 📌 Règles optionnelles (propositions)

- **Deck fermé :** les joueurs ont un petit deck de cartes à épuisement (ex : 3 de chaque type)

- **Effet KO :** si un joueur reçoit 3 dégâts en un seul tour, il doit **lancer un jet de "stabilité"** pour rester debout

- **Cartes bonus événement :** fatigue, sang, seconde chance, etc.

</details>
<!-- SOURCE-ARCHIVE:END -->
