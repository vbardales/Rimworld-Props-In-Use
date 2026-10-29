# Scénarios fonctionnels de Props in Use

Statut de tous les scénarios, y compris la section Props : **non exécuté**. Cible : RimWorld 1.6.
Les validations XML réussies ne prouvent pas ces comportements en jeu.
Utiliser une nouvelle colonie de test ; noter version exacte, mods, ordre, langue,
date, résultat observé et erreurs éventuelles pour chaque cas.

## Bibliothèque chinoise (RepossessedFurniture)

| ID | Action | Résultat attendu |
|---|---|---|
| I01 | Charger Core + PropsInUse, sans RF ni source chinoise. | Aucune erreur du patch ChineseBookcase, aucune bibliothèque chinoise créée. Les patches historiques restent optionnels. |
| I02 | Charger Core + RF sans PropsInUse ; construire SZ_ZhuangShiShuJia. | Un seul meuble, décoratif ; comportement de RF inchangé, pas de stockage ajouté par PropsInUse. |
| I03 | Nouvelle partie avec Core + RF + PropsInUse dans cet ordre. Construire le meuble avec matériaux et travail requis. | Un seul defName ; coût, qualité, art, recherche et catégorie RF préservés. Onglets Art, Storage et ContentsBooks accessibles sans exception. |
| I04 | Autoriser des livres, proposer 11 livres et du bois ; assigner un transporteur. Puis changer filtres/priorité, copier les réglages vers une bibliothèque vanilla. | Dix livres au maximum, bois refusé, onzième livre ailleurs. Filtres et priorité respectés ; groupe Bookcase compatible. |
| I05 | Retirer un livre par l'onglet, lire un livre stocké, réapprovisionner. Comparer lecture/recherche dans une salle avec livres appropriés et une salle témoin. | Livre accessible, transport et lecture aboutissent. Bonus normaux du moteur, aucune duplication ni exception ; capacité rétablie après retrait. |
| I06 | Regarder les quatre rotations, vide puis remplie, jour/nuit, sélection/désélection, avec peinture et qualité artistique si disponibles. | Image originale stable, sans dos de livres vanilla superposés, ombre/teinte/position cohérentes. Le contenu réel est visible dans l'onglet ; l'image reste volontairement remplie. |
| I07 | Sauvegarder avec livres et filtres personnalisés ; quitter, relancer et recharger. Retirer/replacer un livre, déplacer/minifier si RF l'autorise, puis déconstruire. | Livres et réglages conservés. Livres relâchés sans perte/duplication lors de la déconstruction, aucun conteneur inaccessible. |
| I08 | Dans une copie jetable de sauvegarde, vider puis déconstruire toutes les bibliothèques avant activation/désactivation du patch ; reconstruire après changement. | Activation donne des bibliothèques fonctionnelles ; retrait revient au décor RF, sans perte. Ne pas tester une conversion directe d'instance comme procédure supportée. |
| I09 | Tester français puis anglais, avec et sans RF. | Description utile et avertissement de retrait corrects, label RF conservé, aucune clé d'injection manquante lorsque le propriétaire est absent. |


## Props des mods sources (instruments, loisirs, fontaines, haies, auges)

Chaque scénario se joue avec le mod source concerné actif, sauf P01. Les contrôles faits hors jeu
par `Tests/Test-Patches.ps1` (175 assertions : champs ajoutés, gardes, absence de DLL) ne sont pas
rejoués ici : seul ce qu'un jeu qui tourne montre reste à jouer.

| ID | Action | Résultat attendu |
|---|---|---|
| P01 | Charger Core + PropsInUse seul, puis avec chaque source séparément (Miniature Props and Decor, Alpha Props, Musical Instruments, RF), nouvelle partie. | Aucune erreur ni avertissement du mod dans Player.log, dans chaque combinaison. Sans sa source, un patch ne change rien. |
| P02 | Avec Miniature Props and Decor + Musical Instruments : construire chacun des neuf instruments (accordéon, guzheng, hautbois, caisse claire, trombone, trompette, violon, violoncelle, guitare). Un colon libre joue. | Chaque instrument se pose au même endroit du menu de construction, avec la même texture. Un colon s'approche, s'assied, joue ; le loisir Musique est servi ; aucune exception. Le métronome reste un simple décor. |
| P03 | Même carte, instrument à côté d'un obstacle (mur contre la case d'interaction). | L'instrument reste utilisable ou le colon renonce proprement, sans boucle de job. |
| P04 | Avec Miniature Props and Decor : console de jeu et radio amateur construites. Laisser des colons en loisir. | La console est utilisée par un ou deux colons (loisir dextérité), la radio par un colon seul (écoute) ; textes de job lisibles en français et en anglais ; la tolérance sociale du jeu reste respectée. |
| P05 | Avec Alpha Props : poser les sept fontaines, méditer à côté de chacune (colon avec méditation). Lire l'effet de méditation. | Focus naturel pour chaque fontaine, force proportionnelle à la taille ; la fontaine zen un cran au-dessus de ses jumelles de même taille. |
| P06 | Avec Royalty : arbre anima, fontaines et autres focus autour ; comparer avec et sans PropsInUse. | Les fontaines ne comptent plus comme construction artificielle près de l'arbre : la force de l'arbre n'est plus réduite par elles. |
| P07 | Avec Royalty et Ideology : planter l'arbre anima, poser 1 à 6 haies anima (puis gauranlen) dans un rayon de 9,9 cases. Lire la ligne de force de l'arbre, de la pierre d'animus et des sanctuaires. | Chaque haie ajoute 0,01, jusqu'à 4 haies ; la ligne d'explication s'affiche (« par haie anima / gauranlen à proximité »), en français et en anglais. Les haies ne sont jamais un focus à elles seules. |
| P08 | Construire une auge de chaque type ; coût et temps de travail. | 25 bois et 400 de travail ; les trois auges fleuries se comportent comme les deux autres. |
| P09 | Remplir une auge de foin, laisser la pluie tomber sur une auge posée dehors ; ajouter des animaux d'élevage. | Le foin ne se dégrade pas ; les animaux mangent directement dans l'auge ; filtre limité aux aliments, foin et granulés par défaut ; l'auge ne se remplit pas d'acier. |
| P10 | Sauvegarder avec auges pleines et bibliothèques ; relancer, recharger ; puis retirer PropsInUse, recharger une copie de la sauvegarde. | Contenu et réglages conservés au rechargement. Après retrait : le contenu des auges est traité comme une transition à risque (vider avant, voir la description), aucune partie corrompue sur la copie saine. |
| P11 | Jouer P02, P04, P07 et P08 en français puis en anglais, interface en mode développeur. | Aucune clé brute, aucun texte de repli accentué, aucun rognage dans les lignes d'explication, les libellés des auges et les textes de job. |

Une conversion de classe sur des instances sauvegardées n'est pas annoncée comme sûre : P10 vérifie
seulement le cas sain (rechargement) et documente le cas retrait.


Ne renseigner `tested_on` qu'après exécution réelle. Conserver le Player.log et
la sauvegarde de test ; consigner les échecs et les cas bloqués avec leur cause.
