param(
  [string]$Project = (Split-Path $PSScriptRoot -Parent),
  [string]$OwnerMod = 'C:\Users\nelim\Documents\rimworld\RepossessedFurniture\Mod',
  [string]$GameData = 'C:\Program Files (x86)\Steam\steamapps\common\RimWorld\Data'
)
$ErrorActionPreference='Stop'
$script:assertions=0
function Assert($condition,[string]$message) { if (!$condition) { throw $message }; $script:assertions++ }
function Load-Xml([string]$path) { $doc=[xml]::new(); $doc.Load($path); return ,$doc }
function Apply-Operation([xml]$doc,$op) {
  switch ([string]$op.Class) {
    'PatchOperationConditional' {
      $branch=if ($doc.SelectSingleNode([string]$op.xpath)) { $op.match } else { $op.nomatch }
      if ($branch) { Apply-Operation $doc $branch }
    }
    'PatchOperationSequence' { foreach ($child in $op.operations.li) { Apply-Operation $doc $child } }
    'PatchOperationAdd' {
      $nodes=@($doc.SelectNodes([string]$op.xpath)); if (!$nodes.Count) { throw "Missing add target $($op.xpath)" }
      foreach ($node in $nodes) { foreach ($child in $op.value.ChildNodes) { if ($child.NodeType -eq 'Element') { $null=$node.AppendChild($doc.ImportNode($child,$true)) } } }
    }
    'PatchOperationReplace' {
      $nodes=@($doc.SelectNodes([string]$op.xpath)); if (!$nodes.Count) { throw "Missing replace target $($op.xpath)" }
      foreach ($node in $nodes) { $null=$node.ParentNode.ReplaceChild($doc.ImportNode($op.value.FirstChild,$true),$node) }
    }
    default { throw "Unsupported test operation: $($op.Class)" }
  }
}
function Apply-Patch([xml]$doc) { foreach ($op in $patch.Patch.Operation) { Apply-Operation $doc $op } }
$mod=Join-Path $Project 'Mod'
$patch=Load-Xml (Join-Path $mod 'Patches/ChineseBookcase.xml')
$xmlFiles=@(Get-ChildItem $mod -Recurse -Filter *.xml)
foreach ($file in $xmlFiles) { $x=Load-Xml $file.FullName; Assert ($null -ne $x.DocumentElement) "XML root $file" }
foreach ($file in (Get-ChildItem (Join-Path $mod 'Patches') -Filter *.xml)) {
  $x=Load-Xml $file.FullName
  foreach ($op in $x.Patch.Operation) { Assert ($op.Class -eq 'PatchOperationConditional') "Unguarded root $file" }
}
$ownerFiles=@(Get-ChildItem (Join-Path $OwnerMod 'Defs') -Recurse -Filter *.xml)
$targets=@(foreach ($file in $ownerFiles) { $x=Load-Xml $file.FullName; foreach ($d in $x.SelectNodes('/Defs/ThingDef[defName="SZ_ZhuangShiShuJia"]')) { [pscustomobject]@{node=$d;file=$file.FullName} } })
Assert ($targets.Count -eq 1) 'Exactly one RF owner definition required'
$ownerHash=(Get-FileHash $targets[0].file).Hash
$core=Load-Xml (Join-Path $GameData 'Core/Defs/ThingDefs_Buildings/Buildings_Furniture.xml')
$doc=[xml]'<Defs />'
$null=$doc.DocumentElement.AppendChild($doc.ImportNode($targets[0].node,$true))
$null=$doc.DocumentElement.AppendChild($doc.ImportNode($core.SelectSingleNode('/Defs/ThingDef[defName="Bookcase"]'),$true))
$original=$doc.SelectSingleNode('/Defs/ThingDef[defName="SZ_ZhuangShiShuJia"]').CloneNode($true)
Apply-Patch $doc
$out=$doc.SelectSingleNode('/Defs/ThingDef[defName="SZ_ZhuangShiShuJia"]')
Assert ($out.thingClass -eq 'Building_Bookcase') 'Vanilla book container class'
Assert ($out.drawerType -eq 'MapMeshOnly') 'Original art without dynamic book overlay'
Assert ($out.size -eq '(2,1)' -and [int]$out.building.maxItemsInCell -eq 5) 'Ten-book capacity'
Assert ($out.surfaceType -eq 'None' -and $out.preventDroppingThingsOn -eq 'true') 'No loose items dropped on cabinet'
Assert ($out.building.storageGroupTag -eq $core.SelectSingleNode('/Defs/ThingDef[@Name="BookcaseBase"]/building/storageGroupTag').InnerText) 'Native storage group'
foreach ($key in @('fixedStorageSettings','defaultStorageSettings')) {
  $categories=$out.SelectNodes("building/$key/filter/categories/li")
  Assert ($categories.Count -eq 1 -and $categories[0].InnerText -eq 'Books') "Books-only $key"
}
Assert ($out.building.defaultStorageSettings.priority -eq 'Important') 'Native bookcase hauling priority'
foreach ($key in @('defName','label','ParentName','graphicData','costStuffCount','costList','statBases','comps','researchPrerequisites','modExtensions','designationCategory','size','stuffCategories')) {
  if ($key -eq 'ParentName') { Assert ($out.ParentName -eq $original.ParentName) 'Original parent'; continue }
  Assert ($out.SelectSingleNode($key).OuterXml -ceq $original.SelectSingleNode($key).OuterXml) "Preserved owner $key"
}
Assert (($out.inspectorTabs.li -join ',') -eq 'ITab_Art,ITab_Storage,ITab_ContentsBooks') 'Art retained alongside storage and contents tabs'
$once=$doc.OuterXml; Apply-Patch $doc; Assert ($doc.OuterXml -ceq $once) 'Idempotent patch, no duplicate fields'
foreach ($case in @('absent-owner','absent-core-bookcase','wrong-footprint','absent-building')) {
  $negative=[xml]$once
  switch($case) {
    'absent-owner' { $n=$negative.SelectSingleNode('/Defs/ThingDef[defName="SZ_ZhuangShiShuJia"]'); $null=$n.ParentNode.RemoveChild($n) }
    'absent-core-bookcase' { $n=$negative.SelectSingleNode('/Defs/ThingDef[defName="Bookcase"]'); $null=$n.ParentNode.RemoveChild($n) }
    'wrong-footprint' { $negative.SelectSingleNode('/Defs/ThingDef[defName="SZ_ZhuangShiShuJia"]/size').InnerText='(1,1)' }
    'absent-building' { $n=$negative.SelectSingleNode('/Defs/ThingDef[defName="SZ_ZhuangShiShuJia"]/building'); $null=$n.ParentNode.RemoveChild($n) }
  }
  $before=$negative.OuterXml; Apply-Patch $negative; Assert ($negative.OuterXml -ceq $before) "No-op $case"
}
$manifest=Get-Content (Join-Path $Project 'Docs/CHINESE_MANIFEST.json') -Raw | ConvertFrom-Json
Assert ($manifest.retainedDefs.Count -eq 0 -and $manifest.importedAssets.Count -eq 0 -and $manifest.importedAssemblies.Count -eq 0) 'No upstream import'
Assert (@($manifest.definitions | Where-Object decision -eq 'retained-function-only').Count -eq 1) 'Exactly one selected function'
Assert (@($manifest.definitions | Group-Object type,defName | Where-Object Count -gt 1).Count -eq 0) 'Unique source manifest keys'
Assert (@(Get-ChildItem $mod -Recurse -Filter *.dll).Count -eq 0) 'No assembly bundled'
$about=Load-Xml (Join-Path $mod 'About/About.xml')
Assert ($about.ModMetaData.loadAfter.li -contains 'nelim.repossessedfurniture') 'Owner loads before function patch'
Assert (-not $about.ModMetaData.description.StartsWith('PRIVATE LOCAL PACK')) 'No private-pack notice on a public mod'
Assert ((Get-FileHash $targets[0].file).Hash -eq $ownerHash) 'Owner unchanged by tests'
$snapshot=[xml]'<Defs />'; $null=$snapshot.DocumentElement.AppendChild($snapshot.ImportNode($out,$true))
$effective=Join-Path $Project 'Build/ChineseEffective/Defs'
$null=New-Item -ItemType Directory -Path $effective -Force
$snapshot.Save((Join-Path $effective 'Bookcase.xml'))
$translationDir=Join-Path $Project 'Build/ChineseEffective/Languages/French/DefInjected/ThingDef'
$null=New-Item -ItemType Directory -Path $translationDir -Force
Copy-Item -LiteralPath (Join-Path $mod 'Languages/French/DefInjected/ThingDef/ChineseBookcase.xml') -Destination (Join-Path $translationDir 'ChineseBookcase.xml')
$summary=[ordered]@{date=(Get-Date -Format o);assertions=$script:assertions;modXmlFiles=$xmlFiles.Count;sourceDefinitions=$manifest.definitions.Count;ownerFile=$targets[0].file;ownerSha256=$ownerHash;effectiveSnapshot=(Join-Path $effective 'Bookcase.xml');coverage='XML parser and limited patch replay, not RimWorld execution';inGame='not executed'}
$summary | ConvertTo-Json | Set-Content (Join-Path $Project 'Build/Chinese-test-result.json') -Encoding utf8
Write-Output ($summary | ConvertTo-Json)
