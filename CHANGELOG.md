# Journal des modifications

Format inspiré de [Keep a Changelog](https://keepachangelog.com/fr/1.1.0/).
Ce fichier sert au dépôt et à rédiger les notes de version Steam ; RimWorld ne l'affiche pas en jeu.

## [1.0.0] — non publié

Première version. RimWorld 1.6. Aucun code, aucune def, aucun fichier d'autrui : quatre fichiers
de patchs, seize opérations racine, toutes gardées.

### Instruments — 9 props

Les neuf instruments de Miniature Props and Decor deviennent jouables via le cadre de Musical
Instruments (Continued). Un colon s'approche, s'assied et joue sur place.

Deux composants sont obligatoires, vérifiés par décompilation de `MusicalInstruments.dll` :
`CompProperties_MusicalInstrument` et `CompProperties_MusicSpot`. Aucune recherche préalable
n'est ajoutée, contrairement au marimba de Mlie — ces props sont déjà débloqués.

Le métronome est laissé de côté.

### Loisirs — 2 props

La console de jeu et la radio à ondes courtes reçoivent enfin un type de loisir. Toutes deux
vivaient déjà dans un fichier nommé `Buildings_Recreation.xml`, sans qu'aucun `joyKind` ne leur
soit attaché.

### Fontaines — 7 props

Les sept fontaines d'Alpha Props deviennent des focus de méditation **naturels**, pas artistiques :
c'est le seul type que le jeu associe à l'eau, aux plantes et au calme, et c'est celui des
psycasters tribaux, la voie la plus dépourvue de mobilier en jeu de base.

La force suit la taille, seule échelle objective disponible. Pour référence, le sanctuaire
naturel vanilla vaut 0,22 et la pierre d'animus 0,34. La fontaine zen reçoit un cran de plus que
ses jumelles de même taille : c'est littéralement son objet.

Elles cessent aussi de compter comme construction artificielle près des autres focus.

### Haies — anima et gauranlen

Elles renforcent désormais les focus naturels voisins — arbre anima, pierre d'animus, sanctuaires
— au lieu de devenir chacune un focus autonome. Une haie se pose par dizaines de cases : en faire
des focus indépendants aurait créé une forêt de points de méditation identiques.

Elles cessent également de compter comme construction artificielle.
