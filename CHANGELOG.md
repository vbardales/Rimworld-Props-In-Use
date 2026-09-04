# Journal des modifications

Format inspiré de [Keep a Changelog](https://keepachangelog.com/fr/1.1.0/).
Ce fichier sert au dépôt et à rédiger les notes de version Steam ; RimWorld ne l'affiche pas en jeu.

## [1.0.0] — non publié

Première version. RimWorld 1.6. Aucun code, aucune def, aucun fichier d'autrui : cinq fichiers
de patchs, vingt et une opérations racine, toutes gardées.

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

### Mangeoires — 5 props

Les cinq auges d'Alpha Props deviennent des mangeoires. Le jeu n'a aucun abreuvoir ni mangeoire :
le foin se pose au sol et y pourrit. C'est le seul endroit de ce mod où la fonction manquante et
le prop inutilisé se recouvraient exactement.

Elles deviennent des bâtiments de rangement, pour deux raisons : le filtre, sans lequel une
« mangeoire » se remplirait d'acier, et surtout `preventDeteriorationOnTop` — le foin n'y pourrit
plus sous la pluie, donc la mangeoire peut rester au pré plutôt que sous un toit.

**C'est la seule entrée de ce mod qui change un prix.** `thingClass` est un champ unique, et ces
props portaient déjà `VFEProps.Building_SubstractsSilver`, la classe qui prélève de l'argent à la
construction au lieu d'un `costList`. Prendre `Building_Storage` y renonce, et les auges
seraient devenues gratuites : elles reçoivent 25 bois et 400 de travail à la place.

Les trois auges fleuries sont converties comme les deux autres. Les laisser décoratives aurait
laissé trois props purs debout, ce que ce mod existe précisément pour refuser.

Les cinq reçoivent aussi un libellé et une description français, que le mod d'origine n'a pas.
