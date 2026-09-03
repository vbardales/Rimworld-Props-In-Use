# Props in Use

*Decorative props that already look like something useful, made to actually be that thing.*

Prop mods are full of objects that stop at the picture. A guitar on a table is scenery; a
fountain in a garden is scenery; a hedge grown from anima bark is scenery. This mod plugs a
handful of them into the systems they were clearly drawn for, and changes nothing else about
them: same texture, same cost, same place in the build menu.

## What it does

| Source | Props | Becomes |
|---|---|---|
| Miniature Props and Decor | 9 instruments | playable, through Musical Instruments (Continued) |
| Miniature Props and Decor | game console, ham radio | recreation sources — dexterity play and solitary relaxation |
| Alpha Props — Parks and Gardens | 7 fountains | natural meditation foci, scaled by size |
| Alpha Props — Parks and Gardens | anima and gauranlen hedges | focus offsets feeding the natural foci nearby |

## Two findings that justify the mod

**The hedges already carried the stat.** `<MeditationFocusStrength>0.22</MeditationFocusStrength>`
sits in their `statBases`, with no `CompProperties_MeditationFocus` anywhere — and that stat is
read by nothing else. It was inert, exactly like a `joyKind` on a building that no `JoyGiverDef`
ever serves. The author's intent was there; the game never knew.

**The console lives in a file called `Buildings_Recreation.xml`,** under a recreation menu, with
no recreation type declared on it at all.

## Why offsets and not foci, for the hedges

A hedge is a linear wall you lay down by the dozen. Giving each cell its own
`CompProperties_MeditationFocus` would have turned a garden border into a forest of identical
meditation spots. The offset mechanism exists for precisely this case: an object you do not
meditate on, but which strengthens what you meditate on beside it. It is what vanilla does with
the animus stone and the nature shrines around the anima tree.

## Why Natural and not Artistic, for the fountains

Both were defensible. `Natural` was chosen because it is the only type the game ties to water,
plants and quiet — the type of the nature shrines and the anima tree — and because it is the
focus of tribal psycasters, the path with the least furniture in the base game. `Artistic` is
already well served by sculptures.

Strength follows size, the only objective scale available. For reference, the vanilla nature
shrine is worth 0.22 and the animus stone 0.34.

## How it guards itself

Every root operation is a `PatchOperationConditional` tested on the existence of a def from the
source mod. No `LoadFolders`, no `PatchOperationFindMod`: it tests exactly what it needs. Source
absent, def absent, nothing happens and nothing is reported.

For the instruments the guard is on `MusicalInstrumentBuildingBase`, Mlie's own abstract base: if
that base is loaded, so is the assembly that defines `MusicalInstruments.CompMusicalInstrument` —
and an unresolved `<li Class="...">` would fail the whole def, not just the component.

A CI job checks that this discipline holds: every patch file must have as many guarded operations
as root operations.

## License and attribution

MIT. The mod contains no file belonging to anyone else; see [ATTRIBUTION.md](ATTRIBUTION.md).
