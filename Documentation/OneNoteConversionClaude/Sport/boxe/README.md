# Jeu de cartes de Boxe

Jeu d'affrontement 1 contre 1 où chaque joueur incarne un boxeur.

---

## Objectif

Réduire les points de vie de l'adversaire à 0 en gérant l'énergie, l'initiative et les coups.

---

## Stats du boxeur

| Stat | Valeur max | Récupération |
|------|-----------|--------------|
| **Vie** | 10 | — |
| **Énergie** | 15 | 5 par tour |

---

## Principes de base

- Chaque joueur a une réserve d'**énergie** (⚡), par exemple 3 au départ (ajustable selon tests).
- Chaque carte a un **coût en énergie**.
- Certaines cartes **rendent** de l'énergie (ex : Garde = −1 ⚡).
- Si un joueur n'a plus assez d'énergie, il doit **passer** ou jouer une action gratuite (Garde, Esquive…).

---

## Initiative

L'initiative détermine qui peut utiliser certains coups spéciaux (Crochet, Uppercut).

**Elle change de camp dès qu'un joueur :**
- Touche l'adversaire (attaque non contrée)

**Cas particulier :**
- Le **Clinch** fait perdre automatiquement l'initiative, même s'il fonctionne.

---

## Tableau des cartes

| Carte | ⚡ Coût | 💥 Dégâts | Contre | Est contrée par | Initiative requise | Remarques |
|-------|---------|----------|--------|-----------------|-------------------|-----------|
| **Jab (Direct)** | — | — | — | — | ❌ Non | Rapide, clé pour reprendre l'initiative |
| **Crochet** | — | — | — | — | ✅ Oui | Nécessite l'initiative, peut assommer |
| **Garde** | −1 ⚡ | — | — | — | ❌ Non | Rend 1 ⚡ si réussie, casse le rythme |
| **Contre** | — | — | — | — | — | |
| **Avancer** | — | — | — | — | — | Déplacement −1 |
| **Récupérer** | — | — | — | — | — | Récupère 2 ⚡, perd l'initiative |
| **Esquive** | — | — | — | — | — | Anti-gros coups, faible contre Jab |

> Le contenu complet des stats (portée, dégâts précis, coûts) reste à compléter depuis le OneNote.

---

## Notes tactiques

- **Jab → Crochet** = combo de base très rentable
- **Esquive** est l'anti-gros coups, mais reste faible contre le Jab

---

## Règles optionnelles (propositions)

À compléter depuis la section "Règles optionnelles" du OneNote.

---

## Sections OneNote d'origine

Le fichier `Sport - BOXE.one` contenait :
- **Chatgpt** — brainstorming / génération assistée
- **Général** — règles complètes
