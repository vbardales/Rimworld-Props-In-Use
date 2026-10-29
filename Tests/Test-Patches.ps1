param(
  [string]$Project = (Split-Path $PSScriptRoot -Parent),
  [string]$Workshop = 'C:\Program Files (x86)\Steam\steamapps\workshop\content\294100',
  [string]$GameData = 'C:\Program Files (x86)\Steam\steamapps\common\RimWorld\Data'
)
# Offline test of the five patches of Mod/Patches that touch props mods (instruments, recreation, fountains,
# hedges, troughs). The Chinese bookcase has its own script (Test-ChineseBookcase.ps1). No game is started:
# the patches are applied to the real source defs, read from the Workshop folders, and the result is asserted.
# Only the four operation types the patches use are replayed (Conditional, Sequence, Add, Replace).
$ErrorActionPreference = 'Stop'
$script:assertions = 0
function Assert($condition, [string]$message) { if (!$condition) { throw "FAILED: $message" }; $script:assertions++ }
function Load-Xml([string]$path) { $doc = [xml]::new(); $doc.Load($path); return , $doc }
function Apply-Operation([xml]$doc, $op) {
  switch ([string]$op.Class) {
    'PatchOperationConditional' {
      $branch = if ($doc.SelectSingleNode([string]$op.xpath)) { $op.match } else { $op.nomatch }
      if ($branch) { Apply-Operation $doc $branch }
    }
    'PatchOperationSequence' { foreach ($child in $op.operations.li) { Apply-Operation $doc $child } }
    'PatchOperationAdd' {
      $nodes = @($doc.SelectNodes([string]$op.xpath)); if (!$nodes.Count) { throw "Missing add target $($op.xpath)" }
      foreach ($node in $nodes) { foreach ($child in $op.value.ChildNodes) { if ($child.NodeType -eq 'Element') { $null = $node.AppendChild($doc.ImportNode($child, $true)) } } }
    }
    'PatchOperationReplace' {
      $nodes = @($doc.SelectNodes([string]$op.xpath)); if (!$nodes.Count) { throw "Missing replace target $($op.xpath)" }
      foreach ($node in $nodes) { $null = $node.ParentNode.ReplaceChild($doc.ImportNode($op.value.FirstChild, $true), $node) }
    }
    default { throw "Unsupported test operation: $($op.Class)" }
  }
}
function Apply-PatchFile([xml]$doc, [string]$file) {
  $p = Load-Xml $file
  foreach ($op in $p.Patch.Operation) { Apply-Operation $doc $op }
}
# Copies the top-level defs of every XML under $dir into $doc; $names limits it to those defNames / abstract Names.
function Import-Defs([xml]$doc, [string]$dir, [string[]]$names) {
  foreach ($file in (Get-ChildItem $dir -Recurse -Filter *.xml)) {
    $x = Load-Xml $file.FullName
    if ($x.DocumentElement.Name -ne 'Defs') { continue }
    foreach ($d in $x.DocumentElement.ChildNodes) {
      if ($d.NodeType -ne 'Element') { continue }
      $id = if ($d.defName) { [string]$d.defName } else { [string]$d.GetAttribute('Name') }
      if (!$names -or $names -contains $id) { $null = $doc.DocumentElement.AppendChild($doc.ImportNode($d, $true)) }
    }
  }
}
function Def($doc, $name) { return $doc.SelectSingleNode("/Defs/*[defName='$name']") }
function CompCount($def, $class) { return @($def.SelectNodes("comps/li[@Class='$class']")).Count }

$mod = Join-Path $Project 'Mod'
$patches = Join-Path $mod 'Patches'
$leo = Join-Path $Workshop '3579351912\Defs'
$alpha = Join-Path $Workshop '3146268928\1.6\Defs'
$mlie = Join-Path $Workshop '2274558815\1.6\Defs'
$royalty = Join-Path $GameData 'Royalty\Defs'
foreach ($p in @($leo, $alpha, $mlie, $royalty)) { Assert (Test-Path $p) "Source folder present: $p" }

# --- every patch file is guarded at the root, and nothing is bundled ------------------------------------
foreach ($file in (Get-ChildItem $patches -Filter *.xml)) {
  $x = Load-Xml $file.FullName
  foreach ($op in $x.Patch.Operation) { Assert ($op.Class -eq 'PatchOperationConditional') "Guarded root operation in $($file.Name)" }
}
Assert (@(Get-ChildItem $mod -Recurse -Filter *.dll).Count -eq 0) 'No assembly bundled'
Assert (@(Get-ChildItem $mod -Recurse -Include *.png, *.dds -Exclude ModIcon.png, Preview.png | Where-Object { $_.FullName -notmatch '\\About\\' }).Count -eq 0) 'No texture bundled'

# --- inert without the source mods ---------------------------------------------------------------------
$files = 'MiniatureInstruments', 'MiniatureRecreation', 'AlphaFountains', 'AlphaHedges', 'AlphaTroughs'
foreach ($f in $files) {
  $empty = [xml]'<Defs />'
  $before = $empty.OuterXml
  Apply-PatchFile $empty (Join-Path $patches "$f.xml")
  Assert ($empty.OuterXml -ceq $before) "$f changes nothing when its source is absent"
}

# --- build the merged def set the patches see ------------------------------------------------------------
$doc = [xml]'<Defs />'
Import-Defs $doc $leo $null
Import-Defs $doc $alpha $null
# the hedges live in the DLC subfolders of the source mod (loaded only with Royalty and Ideology)
Import-Defs $doc (Join-Path $Workshop '3146268928\1.6\Mods\Royalty\Defs') $null
Import-Defs $doc (Join-Path $Workshop '3146268928\1.6\Mods\Ideology\Defs') $null
Import-Defs $doc $mlie @('MusicalInstrumentBuildingBase')
Import-Defs $doc $royalty @('Plant_TreeAnima', 'AnimusStone', 'NatureShrine_Small', 'NatureShrine_Large')
$snapshot = $doc.OuterXml
foreach ($f in $files) { Apply-PatchFile $doc (Join-Path $patches "$f.xml") }
Assert ($doc.OuterXml -cne $snapshot) 'Patches change the merged defs'
# The game applies each patch once per load, so a second pass is not tested (it would add a second comp).

# --- instruments -----------------------------------------------------------------------------------------
$instruments = 'Prop_Accordion', 'Prop_Guzheng', 'Prop_Oboe', 'Prop_Snare_Drum', 'Prop_Trombone', 'Prop_Trumpet', 'Prop_Violin', 'Prop_Cello', 'Prop_Guitar'
foreach ($n in $instruments) {
  $d = Def $doc $n
  Assert ($null -ne $d) "Source def present: $n"
  Assert ((CompCount $d 'MusicalInstruments.CompProperties_MusicalInstrument') -eq 1) "One instrument comp on $n"
  Assert ((CompCount $d 'MusicalInstruments.CompProperties_MusicSpot') -eq 1) "One music spot comp on $n"
  Assert ($d.building.joyKind -eq 'Music') "Music joyKind on $n"
  Assert ($d.hasInteractionCell -eq 'True') "Interaction cell on $n"
}
Assert ($null -eq (Def $doc 'Prop_Metronome') -or (CompCount (Def $doc 'Prop_Metronome') 'MusicalInstruments.CompProperties_MusicalInstrument') -eq 0) 'Metronome left alone'

# --- recreation --------------------------------------------------------------------------------------------
foreach ($n in 'Prop_GameConsole', 'Props_Ham_Radio') {
  $d = Def $doc $n
  Assert ($null -ne $d -and -not [string]::IsNullOrEmpty($d.building.joyKind)) "joyKind set on $n"
}
foreach ($j in 'PIU_PlayGameConsole', 'PIU_ListenHamRadio') {
  $job = $doc.SelectSingleNode("/Defs/JobDef[defName='$j']")
  Assert ($null -ne $job -and $job.reportString.Length -gt 0) "JobDef with a report string: $j"
  $giver = $doc.SelectSingleNode("/Defs/JoyGiverDef[defName='$j']")
  Assert ($null -ne $giver -and $giver.jobDef -eq $j) "JoyGiverDef serves $j"
}

# --- fountains ---------------------------------------------------------------------------------------------
$fountains = 'AP_ArabicFountain', 'AP_ZenFountain', 'AP_ThreeTieredFountain', 'AP_RoundFountain', 'AP_HexagonalFountain', 'AP_SquareFountain', 'AP_ObeliskFountain'
$strength = @{}
foreach ($n in $fountains) {
  $d = Def $doc $n
  Assert ($null -ne $d) "Source def present: $n"
  Assert ((CompCount $d 'CompProperties_MeditationFocus') -eq 1) "One meditation focus on $n"
  Assert ($d.SelectSingleNode("comps/li[@Class='CompProperties_MeditationFocus']/focusTypes/li").InnerText -eq 'Natural') "Natural focus on $n"
  Assert ($d.building.artificialForMeditationPurposes -eq 'false') "Not artificial for meditation: $n"
  Assert ($d.placeWorkers.li -contains 'PlaceWorker_ArtificialBuildingsNear') "Artificial-buildings place worker on $n"
  $strength[$n] = [double]$d.statBases.MeditationFocusStrength
  Assert ($strength[$n] -gt 0 -and $strength[$n] -lt 1) "Focus strength in range on $n"
}
Assert ($strength['AP_ZenFountain'] -gt $strength['AP_SquareFountain']) 'Zen fountain stronger than a smaller sibling'

# --- hedges ------------------------------------------------------------------------------------------------
foreach ($n in 'AP_Hedge_Anima', 'AP_Hedge_Gau') {
  $d = Def $doc $n
  Assert ($null -ne $d -and $d.building.artificialForMeditationPurposes -eq 'false') "Hedge not artificial: $n"
  Assert ((CompCount $d 'CompProperties_MeditationFocus') -eq 0) "Hedge gets no standalone focus: $n"
}
foreach ($t in 'Plant_TreeAnima', 'AnimusStone', 'NatureShrine_Small', 'NatureShrine_Large') {
  $offsets = @((Def $doc $t).SelectNodes("comps/li[@Class='CompProperties_MeditationFocus']/offsets/li[@Class='FocusStrengthOffset_BuildingDefs']"))
  # the target already carries the base game's own building offset: only this mod's two (PIU_ keys) are counted
  $mine = @($offsets | Where-Object { $_.explanationKey -like 'PIU_FocusPer*' })
  Assert ($mine.Count -eq 2) "Two hedge offsets of this mod on $t (found $($mine.Count))"
  foreach ($o in $mine) {
    Assert ($o.explanationKey -like 'PIU_FocusPer*Hedge' -and $o.explanationKeyAbstract -like 'PIU_FocusPer*HedgeAbstract') "Explanation keys on $t"
  }
}

# --- troughs ---------------------------------------------------------------------------------------------
foreach ($n in 'AP_EmptyTrough', 'AP_TroughWithHay', 'AP_TroughWithFlowersA', 'AP_TroughWithFlowersB', 'AP_TroughWithFlowersC') {
  $d = Def $doc $n
  Assert ($null -ne $d) "Source def present: $n"
  Assert ($d.thingClass -eq 'Building_Storage') "Storage class on $n"
  Assert ($d.building.preventDeteriorationOnTop -eq 'true') "No deterioration on top: $n"
  Assert ($d.costList.WoodLog -eq '25' -and $d.statBases.WorkToBuild -eq '400') "Wood cost and work set on $n"
  Assert ($d.building.fixedStorageSettings.filter.categories.li -contains 'Foods') "Foods-only filter on $n"
  Assert ($d.building.defaultStorageSettings.filter.thingDefs.li -contains 'Hay') "Hay allowed by default on $n"
}

$out = Join-Path $Project 'Build'
$null = New-Item -ItemType Directory -Path $out -Force
$summary = [ordered]@{ date = (Get-Date -Format o); assertions = $script:assertions; patchFiles = $files.Count }
$summary | ConvertTo-Json | Set-Content (Join-Path $out 'Patches-test-result.json') -Encoding utf8
Write-Output ($summary | ConvertTo-Json)
