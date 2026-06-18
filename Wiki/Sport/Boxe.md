---
tags:
  - sport
  - jeu-de-cartes
  - boxe
statut: en-développement
---

# Boxe

Jeu de cartes d'affrontement 1v1. Chaque joueur incarne un boxeur.  
**Objectif** : réduire les points de vie de l'adversaire à 0 en gérant énergie, initiative et coups.

---

## Stats du boxeur

| Stat | Valeur max | Récupération |
|------|-----------|--------------|
| **Vie** | 10 | — |
| **Énergie** | 15 | 5 par tour |

---

## Principes de base

- Chaque joueur démarre avec une réserve d'**énergie** ⚡ (3 au départ, ajustable).
- Chaque carte a un **coût en énergie**.
- Certaines cartes **rendent** de l'énergie (ex : Garde = −1 ⚡ = récupère 1).
- Sans énergie suffisante → passer son tour ou jouer une action gratuite (Garde, Esquive).

---

## Initiative

L'initiative détermine qui peut jouer les coups spéciaux (Crochet, Uppercut).

**Elle change de camp quand un joueur :**
- Touche l'adversaire avec une attaque non contrée

**Cas particulier :**
- Le **Clinch** fait perdre l'initiative automatiquement, même s'il réussit.

---

## Cartes

| Carte | ⚡ Coût | 💥 Dégâts | Initiative requise | Contre / Contrée par | Remarques |
|-------|---------|----------|--------------------|----------------------|-----------|
| **Jab (Direct)** | — | — | ❌ Non | — | Rapide, reprend l'initiative |
| **Crochet** | — | — | ✅ Oui | — | Peut assommer |
| **Garde** | −1 ⚡ | 0 | ❌ Non | — | Récupère 1 ⚡ si réussie |
| **Contre** | — | — | — | — | — |
| **Avancer** | — | — | — | — | Déplacement −1 |
| **Récupérer** | — | 0 | — | — | Récupère 2 ⚡, perd l'initiative |
| **Esquive** | — | 0 | — | — | Anti-gros coups, faible contre Jab |

> Les valeurs précises de coût et dégâts sont à compléter lors du playtest.

---

## Combos et tactiques

- **Jab → Crochet** = combo de base très rentable
- **Esquive** est l'anti-gros coups, mais reste faible face au Jab

---

## Règles optionnelles

> À définir lors des playtests.

---

## Journal

| Date | Note |
|------|------|
| — | Brainstorming initial avec ChatGPT |
