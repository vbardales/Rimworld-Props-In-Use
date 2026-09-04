# Props in Use

*Decorative props that already look like something useful, made to actually be that thing.*

Prop mods are full of objects that stop at the picture. A guitar on a table is scenery; a
fountain in a garden is scenery; a hedge grown from anima bark is scenery. This mod plugs a
handful of them into the systems they were clearly drawn for, and changes as little else as it
can: same texture, same place in the build menu. Cost is left alone wherever the prop already
had one — the troughs are the single exception, and the section below says why.

## What it does

| Source | Props | Becomes |
|---|---|---|
| Miniature Props and Decor | 9 instruments | playable, through Musical Instruments (Continued) |
| Miniature Props and Decor | game console, ham radio | recreation sources — dexterity play and solitary relaxation |
| Alpha Props — Parks and Gardens | 7 fountains | natural meditation foci, scaled by size |
| Alpha Props — Parks and Gardens | anima and gauranlen hedges | focus offsets feeding the natural foci nearby |
| Alpha Props — Parks and Gardens | 5 troughs | animal feeders — storage buildings that keep feed from rotting |

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

## Why the troughs cost wood, when nothing else here changes a price

The game ships no feeder of any kind. Hay goes on the barn floor and rots there. So the five
props labelled *trough* were the one case where the missing feature and the idle prop matched
exactly — and the only case in this mod that could not be done by adding a comp.

A trough had to become a `Building_Storage` to carry a filter and, more importantly,
`preventDeteriorationOnTop`: feed in a trough no longer spoils in the rain, which is what lets
the trough stand outdoors in the pasture instead of inside a roofed barn. Animals reach it
because the props are `PassThroughOnly` — an animal walks onto the tile, and food-seeking
resolves through `ClosestTouch`. The storage class is irrelevant to that; passability is not.

`thingClass` is a single field, and these props already used one:
`VFEProps.Building_SubstractsSilver`, the class that charges silver at build time in place of a
`costList`. Taking `Building_Storage` gives that up, and the troughs would otherwise have
become free. They are given 25 wood and 400 work instead — cheaper than a shelf, which is 20
stuff and 500 work but sits behind research.

All five are converted, including the three filled with plastic flowers. Leaving those three as
scenery would have left three pure props standing, which is the one thing this mod exists to
refuse. One function, five looks; hay stored in a flower trough draws on top of the flowers.

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
