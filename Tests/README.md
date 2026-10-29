# Tests locaux

Deux scripts, PowerShell 7, sans lancer le jeu. Tous deux lisent les defs réelles des mods sources
(Workshop et dossier du jeu) et écrivent seulement dans `Build/` (ignoré par git).

## Props des mods sources : `Tests/Test-Patches.ps1`

Instruments, loisirs, fontaines, haies, auges. Applique les cinq patchs sur les defs de Miniature Props and Decor,
Alpha Props (dossiers `1.6`, `Mods/Royalty`, `Mods/Ideology`), Musical Instruments et Royalty, puis vérifie : gardes à la
racine de chaque patch, aucun patch ne change rien sans sa source, aucune DLL ni texture embarquées, composants et champs
ajoutés sur chaque def (9 instruments, 2 loisirs et leurs jobs, 7 fontaines, 2 haies et 4 cibles, 5 auges). 175 assertions
le 2026-10-29. Chaque patch s'applique une seule fois par chargement dans le jeu : une deuxième passe n'est pas testée.

```powershell
./Tests/Test-Patches.ps1
```

## Intégration chinoise : `Tests/Test-ChineseBookcase.ps1`

RimWorld 1.6 et RepossessedFurniture requis. Depuis PropsInUse :

```powershell
./Tests/Test-ChineseBookcase.ps1
```

Le test parse tous les XML du mod, vérifie les gardes racines, applique les quatre
types d'opération utilisés par le nouveau patch sur une copie de la def RF,
teste ses effets et son absence d'effet, puis écrit uniquement dans `Build/`.
Il ne charge ni Unity ni RimWorld. Il ne simule pas l'ensemble des patches des mods.
Il échoue si RF ne fournit pas exactement un `SZ_ZhuangShiShuJia`.
Le propriétaire est lu, jamais modifié. Le snapshot post-patch conserve les
parents et l'extension RF pour les validations croisées suivantes.

Depuis PropsInUse, avec les scripts partagés dans le dossier parent :

```powershell
$effective = "$PWD/Build/ChineseEffective"
$owner = "$PWD/../RepossessedFurniture/Mod"
../scripts/Check-XmlFields.ps1 -ModPath $effective -ExtraAssemblies "$owner/Assemblies/RepossessedFurniture.dll"
../scripts/Check-DefRefs.ps1 -ModPath $effective -AlsoScan $owner -Brief
../scripts/Check-XmlClasses.ps1 -ModPath $effective -TypeLists "$PWD/../rw16_types.txt" -SourceDirs "$PWD/../RepossessedFurniture/Source" -Brief
../scripts/Check-ConfigErrors.ps1 -ModPath $effective -AlsoScan $owner
```

Le manifeste des defs sources se lit dans `Docs/CHINESE_MANIFEST.json` (ignoré par git).

Les checkers XML partagés ne rejouent pas les patches : c'est pourquoi ils sont
exécutés sur le snapshot et non seulement sur `Mod/Patches`. Le checker de classes
utilise la liste locale et les sources RF ; le checker de champs charge l'assemblage
RF pour son extension. Aucune compilation de PropsInUse : aucun code C# ajouté.
Les scripts partagés ne sont pas copiés dans ce projet.

Résultat du 2026-10-29 : 69 assertions, 11 XML, 739 defs concrètes indexées,
neuf types résolus, 26 règles de configuration sans erreur. Le JSON de résultat
reproductible est `Build/Chinese-test-result.json` (intermédiaire ignoré par Git).
Les tests de rendu, hauling, filtres en jeu, effets de salle et sauvegarde restent
les scénarios non exécutés de `TESTING.md`.

La copie de test contient aussi la nouvelle injection française. Validation exécutée :

```powershell
../scripts/Check-DefInjected.ps1 -TransMod $effective
```

Résultat : une clé vérifiée, zéro erreur. Les 93 XML amont référencés par le manifeste sont restés inchangés.