# Tests locaux — intégration chinoise

PowerShell 7, installation locale de RimWorld 1.6 et RepossessedFurniture requis.
Depuis PropsInUse :

```powershell
./Tests/Test-ChineseBookcase.ps1
```

Le test parse tous les XML du mod, vérifie les gardes racines, applique les quatre
types d'opération utilisés par le nouveau patch sur une copie de la def RF,
teste ses effets et son absence d'effet, puis écrit uniquement dans `.build/`.
Il ne charge ni Unity ni RimWorld. Il ne simule pas l'ensemble des patches des mods.
Il échoue si RF ne fournit pas exactement un `SZ_ZhuangShiShuJia`.
Le propriétaire est lu, jamais modifié. Le snapshot post-patch conserve les
parents et l'extension RF pour les validations croisées suivantes.

Depuis PropsInUse, avec les scripts partagés dans le dossier parent :

```powershell
$effective = "$PWD/.build/ChineseEffective"
$owner = "$PWD/../RepossessedFurniture/Mod"
../scripts/Check-XmlFields.ps1 -ModPath $effective -ExtraAssemblies "$owner/Assemblies/RepossessedFurniture.dll"
../scripts/Check-DefRefs.ps1 -ModPath $effective -AlsoScan $owner -Brief
../scripts/Check-XmlClasses.ps1 -ModPath $effective -TypeLists "$PWD/../rw16_types.txt" -SourceDirs "$PWD/../RepossessedFurniture/Source" -Brief
../scripts/Check-ConfigErrors.ps1 -ModPath $effective -AlsoScan $owner
```

Les checkers XML partagés ne rejouent pas les patches : c'est pourquoi ils sont
exécutés sur le snapshot et non seulement sur `Mod/Patches`. Le checker de classes
utilise la liste locale et les sources RF ; le checker de champs charge l'assemblage
RF pour son extension. Aucune compilation de PropsInUse : aucun code C# ajouté.
Les scripts partagés ne sont pas copiés dans ce projet.

Résultat du 2026-09-12 : 68 assertions, 11 XML, 739 defs concrètes indexées,
neuf types résolus, 26 règles de configuration sans erreur. Le JSON de résultat
reproductible est `.build/Chinese-test-result.json` (intermédiaire ignoré par Git).
Les tests de rendu, hauling, filtres en jeu, effets de salle et sauvegarde restent
les scénarios non exécutés de `TEST_SCENARIOS.md`.

La copie de test contient aussi la nouvelle injection française. Validation exécutée :

```powershell
../scripts/Check-DefInjected.ps1 -TransMod $effective
```

Résultat : une clé vérifiée, zéro erreur. Les 93 XML amont référencés par le manifeste sont restés inchangés.