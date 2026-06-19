# Contrôle d’exhaustivité

Chaque export DOCX a été lu directement depuis `word/document.xml`. Le témoin `.texte-integral.txt` contient tous les nœuds textuels `w:t`, dans leur ordre documentaire.

| Export | Nœuds texte | Caractères source | Caractères témoin | Identiques | Médias extraits |
|---|---:|---:|---:|:---:|---:|
| Général.docx | 36 | 628 | 628 | True | 0 |
| Sport - BOXE.docx | 393 | 3575 | 3575 | True | 0 |
| Sport - Volley.docx | 3 | 27 | 27 | True | 0 |
| Stratégie - KINGDOMS.docx | 163 | 4479 | 4479 | True | 0 |
| Village.docx | 6 | 130 | 130 | True | 0 |
| WAFE - Banalités.docx | 405 | 2178 | 2178 | True | 0 |
| WAFE - Donjon.docx | 783 | 14194 | 14194 | True | 5 |
| WAFE - King battle.docx | 125 | 885 | 885 | True | 0 |
| WAFE - LandProtect.docx | 8 | 94 | 94 | True | 0 |
| WAFE.docx | 648 | 7021 | 7021 | True | 5 |
| YNSECTS.docx | 15 | 89 | 89 | True | 3 |

Les fichiers .one restent les binaires de référence. Leur export DOCX homonyme est la source de la transcription, l’API OneNote n’étant pas disponible dans cet environnement.
