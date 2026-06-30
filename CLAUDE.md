# Projets de jeux — Guide IA

Dépôt personnel de Yann Danjaume : idées de jeux de société et projets en phase de production.

## Structure

```
Projets/
├── Idées/          → fiches d'idées, une par projet
├── Production/     → projets en développement actif (ex : Sheepering/)
├── Documentation/  → changelog.md, References.md
└── Sources/        → sources originales et archives IA — ne pas modifier
```

## Règles

**R1 — Ne jamais perdre de données**
Si une information ne tient pas dans la couche éditoriale, elle va dans l'annexe SOURCE-ARCHIVE du même fichier.

**R2 — L'annexe SOURCE-ARCHIVE ne se modifie pas**
Chaque fiche projet contient une annexe repliable délimitée par `<!-- SOURCE-ARCHIVE:BEGIN -->` et `<!-- SOURCE-ARCHIVE:END -->`. Elle fait foi en cas de désaccord. Seule la partie éditoriale au-dessus peut évoluer.

**R3 — Lire l'annexe avant de déclarer une donnée absente**
Les informations semblant manquantes dans la couche éditoriale sont souvent dans l'annexe du même fichier.

**R4 — Marquer chaque champ inféré dans la cellule elle-même**
Format : `Valeur [Inférence]` ou `Non défini [Inférence]`. Pas dans une note de bas de page.

## Journalisation

Toute modification de fichier doit être consignée dans `Documentation/changelog.md` avec date, heure (Europe/Paris), auteur réel et auteur Git si différent.
