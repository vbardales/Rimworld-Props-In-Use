# Attribution

This mod contains **no file belonging to anyone else**: no texture, no sound, no def. Only xpath
operations and text written for it.

It replaces nothing and removes nothing: every prop keeps its texture, its cost and its place in
the build menu. It is useless without its sources — it brings them players rather than competing
with them.

## How the patches guard themselves

Neither `LoadFolders` nor `PatchOperationFindMod`. Every root operation is a
**`PatchOperationConditional` tested on the existence of a def from the source mod**. If the
source is absent, the def does not exist, the `match` branch never runs, and nothing is reported.

This is finer than guarding on a mod name: it tests exactly what is needed, not an identifier
that can be renamed.

The instruments are a special case: the guard is on **`MusicalInstrumentBuildingBase`**, Mlie's
abstract base. If that base is loaded, so is the assembly defining
`MusicalInstruments.CompMusicalInstrument` — and an unresolved `<li Class="...">` would fail the
whole def, not just the component.

---

## Miniature Props and Decor

- **Author:** Leo39994
- **Steam Workshop:** [3579351912](https://steamcommunity.com/sharedfiles/filedetails/?id=3579351912)
- **Taken:** nothing.
- **Patched in place:** nine instrument props — accordion, guzheng, oboe, snare drum, trombone,
  trumpet, violin, cello, guitar — plus the game console and the ham radio.
- **Left alone:** the metronome, which is not an instrument you play.

The defs are patched in place rather than redeclared, precisely because the mod is alive:
redeclaring them would create duplicates in the menu.

## Alpha Props — Parks and Gardens

- **Author:** Sarg Bjornson
- **Steam Workshop:** [3146268928](https://steamcommunity.com/sharedfiles/filedetails/?id=3146268928)
- **Taken:** nothing.
- **Patched in place:** the seven ornamental fountains, the anima and gauranlen hedges, and the
  five troughs. The troughs are the only defs whose `thingClass` is replaced: they lose
  `VFEProps.Building_SubstractsSilver` in exchange for `Building_Storage`, and are given a wood
  cost in place of the silver charge that class applied.

## Musical Instruments (Continued)

- **Author:** Mlie, after the original
- **Taken:** nothing. Its framework is **used**, not copied: the props receive
  `MusicalInstruments.CompProperties_MusicalInstrument` and
  `MusicalInstruments.CompProperties_MusicSpot`.
- The `isBuilding` behaviour this mod relies on is the one Mlie wrote for the marimba and the
  organ: the pawn comes and plays in place instead of carrying the instrument away. No overlap
  with the carried instruments.

## Royalty

The hedge focus offsets target `Plant_TreeAnima`, `AnimusStone`, `NatureShrine_Small` and
`NatureShrine_Large`. Without Royalty those defs do not exist and the guards never fire.
