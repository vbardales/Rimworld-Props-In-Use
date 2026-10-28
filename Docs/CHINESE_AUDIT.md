# Audit privé — Chinese Traditional Cultural Things Expanded

2026-09-12. Conclusion : **une fonction retenue, aucune définition ni ressource importée**.

`SZ_ZhuangShiShuJia` reste la propriété de RepossessedFurniture. PropsInUse contient
uniquement `Mod/Patches/ChineseBookcase.xml`, qui transforme cette bibliothèque
décorative de 2x1 cases en bibliothèque vanilla contenant dix livres. Ce choix
correspond directement à l'objet représenté et au périmètre du projet.

## Provenance et périmètre

Source en lecture seule : `C:\Program Files (x86)\Steam\steamapps\workshop\content\294100\2877536640`.
`LoadFolders.xml` charge la racine et `1.5` pour la version amont retenue ; la branche
CE conditionnelle est hors de cet audit de mobilier. La racine contient également
des patches actifs et un UpdateInfoDef, exclus de l'import.
739 définitions concrètes sont indexées dans `CHINESE_MANIFEST.json`, par type,
defName, chemin, décision et routage. Les parents abstraits ne sont pas comptés
comme définitions concrètes. Les empreintes SHA-256 des XML inspectés sont conservées.
Le routage d'un contenu exclu ne constitue pas une promesse d'intégration ailleurs.

L'édition 2877536640 est classée **forbidden** : refus de republications sans
permission dans `About/About.xml`, lignes 17–24. Travail strictement privé.
L'accueil de patches ne vaut pas autorisation de republication. Aucun push,
publication, assemblage, texture ou définition amont copié dans PropsInUse.
Les patches originaux restent sous leur licence MIT ; cela ne relicencie pas
le contenu des auteurs. Crédits et index : `ATTRIBUTION.md`, `SOURCES.json`.

Les documents STATUS, ATTRIBUTION et TEST_SCENARIOS du port animal autonome ont été
consultés. Ce port n'a été ni modifié ni utilisé comme propriétaire du mobilier.

## Frontières confirmées avec les autres tâches

| Pièce | Décision PropsInUse et justification |
|---|---|
| SZ_ZhuangShiShuJia | Fonction de stockage retenue. RF conserve la def et l'art ; Style a décliné. Accord explicite de RF pour le patch externe. |
| SZ_ShuiChi, SZ_ShuiChi_B | Déjà contemplables grâce à CompArt.canBeEnjoyedAsArt ; pas de conversion en fontaines de méditation. |
| Chi_Gu | Déjà référencé comme bonus de méditation dans les sculptures (FocusStrengthOffset_BuildingDefsWithQuality). Pas un instrument entièrement inerte. |
| Chi_ShuiJing | Patch racine DubsBadHygiene avec WaterInlet déjà présent. Une remise en état de cette compatibilité appartient au propriétaire du puits. |
| SZ_ShuZhuangJing | Patch racine Ideology : Building_StylingStation et case d'interaction déjà prévus. |
| Chi_DaoCaoRen | Faire fuir la faune demanderait de choisir et concevoir un système supplémentaire ; aucun bonus artificiel ajouté. |
| Chi_GaoShiPai | Aucun système d'affichage ou de travail choisi ; pas de bonus inventé. |
| Chi_XiangLu | PropsAsDeco possède l'encensoir et conserve sa facility ; aucune redéfinition. |
| Chi_QingHuaCiA, SZ_Un_QingCi | Reportés, chaîne céramique sans propriétaire retenu ; aucune dépendance cassée introduite. |
| Chi_New_* | Supports sur pied selon la QA de Deco, libérés vers RF ; pas de fonction nouvelle retenue ici. |
| Lits, tables, chaises, stockages, lampes, brasero, facilities, statues | Déjà fonctionnels : RF, Style ou Joy selon leurs arbitrages. |
| Cuisine, boissons et leurs équipements | FoodCourt. Animaux, plantes, habits, médecine, armes, terrains, narrateurs et scénarios : hors PropsInUse. |

Coordination : PropsAsDeco `01a09721-1c0f-7462-9286-fc06001f75d6`,
PropsAsStyle `01a09721-2c82-7bc1-8eff-d166752e79a2`,
RepossessedFurniture `01a09721-4f84-78e0-b048-dbb1563d185d`.

## Contrat technique

Ordre : Core → RepossessedFurniture (`nelim.repossessedfurniture`) → PropsInUse.
La dépendance est optionnelle et va du consommateur au propriétaire. RF n'a pas
besoin de PropsInUse. La garde exige la def exacte, `building`, `size=(2,1)` et
la présence de `Bookcase` vanilla. Sans correspondance : aucune modification.
Les remplacements/ajouts internes sont idempotents. Seule la combinaison avec
le propriétaire RF en 1.6 a été testée statiquement ; pas la source amont complète.

`Building_Bookcase`, `Books`, priorité Important, cinq livres par case et groupe
Bookcase viennent du contrat vanilla local de `BookcaseBase`/`ShelfBase`.
Les onglets Art, Storage et ContentsBooks sont conservés/ajoutés explicitement.
Pas de placeWorker de recherche ajouté : l'indication pendant le placement est
facultative et ne justifie pas de remplacer les éventuels placeWorkers du propriétaire.
Le patch ne change ni coût, ni stats, ni qualité, ni art, ni recherche, ni texture,
ni extension RepossessedMember. Il change la classe, le mode de rendu, le stockage,
les onglets, la description et empêche le dépôt libre d'objets sur le meuble.

L'inspection du PNG sud montre des livres déjà peints dans l'image. Inspection
de l'Assembly-CSharp.dll locale 1.6 : `Building_Bookcase.DrawAt` dessine normalement
des livres supplémentaires avec des décalages conçus pour l'art vanilla.
`Thing.SpawnSetup` n'enregistre pas les objets `MapMeshOnly` dans le gestionnaire
de rendu dynamique. Le patch conserve donc le graphisme statique et affiche
l'inventaire réel dans son onglet. Cette conclusion vient du code et de l'image,
**pas d'une observation en jeu**. Aucun C# ni assembly ajouté ; compilation non applicable.

Le conteneur, ses filtres, le retrait des livres, les bonus et la sérialisation
restent ceux de Core. Le changement de classe d'instances déjà sauvegardées n'est
pas migré : vider et déconstruire les anciennes bibliothèques avant activation ou
retrait du patch. Ne pas revendiquer une sécurité générale d'ajout en milieu de partie.

## Validation exécutée

- 68 assertions, 11 XML bien formés, gardes racines des six fichiers de patches.
- Replay limité des opérations sur la def finale RF : stockage, capacité, absence
  du propriétaire/Core, mauvaise taille, absence de building, idempotence et
  conservation des propriétés vérifiés. Ce replay n'est pas le moteur de RimWorld.
- Définition après patch : Check-XmlFields passe ; Check-DefRefs passe avec RF ;
  Check-XmlClasses résout les neuf types ; Check-ConfigErrors passe ses 26 règles.
- Pas d'assemblage dans PropsInUse. La compilation C# est non applicable.

Commandes reproductibles et limites : `Tests/README.md`. Scénarios de jeu :
`TEST_SCENARIOS.md`, tous **non exécutés**. Les contrôles portent sur cette
conversion ; les autres fonctionnalités historiques n'ont pas été rejouées en jeu.

La def finale RF était disponible et utilisée pour les tests croisés. Aucune
dépendance manquante pour cette conversion au moment du contrôle. Les reports
de porcelaine et de compatibilités d'autres meubles n'empêchent pas cette fonction.

Validation complémentaire : Check-DefInjected vérifie la description française (1 clé, 0 erreur). Les empreintes des 93 fichiers XML amont inspectés sont inchangées en fin d'audit.
