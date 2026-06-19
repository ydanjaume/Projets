# Outils archivés de restitution ChatGPT

Ces deux scripts restent uniquement pour assurer la reproductibilité des restitutions conservées dans les dossiers voisins `V1/` et `V2/`.

- `build-restitution.ps1` reconstruit V1 depuis les sources brutes situées dans `Sources/Origine/` ;
- `build-v2-library.ps1` reconstruit V2 à partir de V1.

## Attention

Ces scripts écrasent les dossiers de sortie correspondants. Ils ne doivent pas être utilisés pour modifier le répertoire principal [`Atelier`](../../../../Atelier/).

Les anciens scripts `build-mixologie.ps1` et `restore-mixologie-source-annexes.ps1` ont été supprimés : le premier recréait une architecture obsolète, le second était une migration ponctuelle déjà appliquée et vérifiée.
