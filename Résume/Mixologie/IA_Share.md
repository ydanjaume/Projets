# IA Share — relais ChatGPT → Claude

## Objectif de Mixologie

Cette version ne choisit pas entre synthèse et exhaustivité. Elle présente une couche éditoriale lisible, puis une couche source complète. Claude peut donc améliorer les vues éditoriales sans devoir réextraire les documents ni risquer de supprimer une ancienne variante.

## Ce que ChatGPT a bien fait dans sa V2

- Conservation de l’intégralité textuelle des 11 exports OneNote DOCX, avec contrôle quantitatif en V1.
- Conservation et réparation des tableaux, listes, liens et 13 médias incorporés OneNote.
- Copie exacte des pages et images Notion, puis conversion des métadonnées et du catalogue CSV en Markdown.
- Séparation prudente de projets qui se ressemblent sans preuve qu’ils sont identiques, notamment `WAFE — Donjon` et `Donjon à plusieurs`.
- Maintien des versions historiques, questions, répétitions et contradictions utiles au travail de conception.

## Limites de la V2 ChatGPT

- Trop proche d’une transcription : peu de résumés, d’états de maturité et de points d’entrée éditoriaux.
- Organisation correcte mais froide ; les dates OneNote et certaines listes brutes prennent trop de place dans la lecture principale.
- WAFE était bien séparé en modules, mais sans synthèse globale assez forte.
- Les inspirations communes étaient conservées, mais moins bien reliées aux projets concernés.

## Ce que Claude a bien fait dans sa V2

- Excellente façade éditoriale : résumés, fiches signalétiques, tableaux cohérents et titres explicites.
- Regroupement utile de la famille WAFE et classement thématique des références.
- Mise en évidence des versions de KINGDOMS et du Donjon.
- Présentation plus directement exploitable pour prioriser ou reprendre la conception.

## Risques et limites repérés dans la V2 Claude

- Plusieurs champs ne viennent pas explicitement des sources : étoiles d’envie, maturité, difficulté supposée, interaction ou type de jeu pour certains projets.
- Certaines phrases transforment une interprétation plausible en fait. Exemples à revoir : Village qualifié de semi-coopératif et LandProtect qualifié de jeu de survie/gestion. Pour YNSECTS, le thème des insectes est confirmé par les visuels, mais pas écrit dans le texte OneNote.
- La fusion de `Donjon à plusieurs` avec `WAFE — Donjon` est plausible mais non confirmée par les sources.
- Des détails ont été condensés ou omis : l’écart est particulièrement important pour WAFE — Donjon et Boxe ; Sheepering est aussi raccourci.
- Les images intégrées n’étaient pas reprises dans Claude V2.
- Le tableau d’étoiles utilise une échelle de 5 alors que la propriété Notion « Envie de développer » contient des valeurs 0, 1 ou 2 sans définition d’une échelle sur 5.

## Arbitrages déjà appliqués

- Les fichiers Claude servent de vues éditoriales, avec un avertissement systématique sur les inférences.
- Les fichiers ChatGPT servent de notes exhaustives et font foi en cas de désaccord.
- WAFE reste une famille ; ses quatre modules sont distincts.
- `Donjon à plusieurs` est joint aux notes Donjon pour faciliter la comparaison, mais reste explicitement identifié comme concept Notion distinct.
- Les petites idées sont regroupées dans une vue d’ensemble tout en conservant une fiche Markdown individuelle chacune.
- Toutes les images de ChatGPT V2 sont conservées dans `assets/`.

## Travail recommandé pour le passage de Claude

1. Vérifier chaque champ des fiches signalétiques et marquer clairement `Source`, `Inférence` ou `Proposition`.
2. Comparer les vues éditoriales avec `NOTES-SOURCES.md`, surtout Donjon, Boxe, WAFE Univers et Sheepering, puis réinjecter les règles omises qui affectent réellement le gameplay.
3. Ne pas supprimer les notes exhaustives après consolidation ; elles constituent l’historique et la preuve de couverture.
4. Arbitrer avec l’utilisateur si `Donjon à plusieurs` appartient réellement à WAFE.
5. Confirmer l’échelle de la propriété Notion « Envie de développer » avant de conserver les étoiles.
6. Pour YNSECTS, conserver la provenance visuelle : l’inspection confirme fourmis, insecte ailé, libellule, mante orchidée, fourmi coupe-feuille et frelon géant asiatique, mais aucune mécanique.
7. Transformer progressivement les répétitions en sections `Décision actuelle`, `Anciennes variantes` et `Questions ouvertes`, sans effacer les formulations originales.

## Règle de sécurité éditoriale

Une reformulation peut clarifier une donnée. Une fusion, une valeur ajoutée ou un changement de statut doit être étiqueté comme inférence ou proposition tant qu’il n’est pas confirmé par Yann.

## État technique au passage de relais

- 33 fichiers Markdown dans Mixologie.
- 16 médias copiés avec des empreintes identiques à ChatGPT V2.
- 0 lien Markdown local cassé.
- 0 marqueur de gras Word mal formé (`****`).
- Les 13 vues de contenu Claude V2 sont représentées ; son index est remplacé par le `README.md` Mixologie.
- Tous les documents de projet ChatGPT V2 sont représentés dans les couches exhaustives ou le catalogue ; son index WAFE est remplacé par celui de Mixologie.
- Les références aux fichiers sources dans les vues Claude sont conservées comme provenance textuelle, mais la bibliothèque ne dépend d’aucun lien vers les répertoires Claude, ChatGPT ou Sources.
