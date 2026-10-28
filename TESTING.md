# Scénarios fonctionnels — bibliothèque chinoise PropsInUse

Statut de tous les scénarios : **non exécuté**. Cible : RimWorld 1.6.
Les validations XML réussies ne prouvent pas ces comportements en jeu.
Utiliser une nouvelle colonie de test ; noter version exacte, mods, ordre, langue,
date, résultat observé et erreurs éventuelles pour chaque cas.

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

Ne renseigner `tested_on` qu'après exécution réelle. Conserver le Player.log et
la sauvegarde de test ; consigner les échecs et les cas bloqués avec leur cause.
