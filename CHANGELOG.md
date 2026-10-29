# Changelog

Format inspired by [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).
This file serves the repository and the Steam release notes; RimWorld does not show it in game.

## [Unreleased]

First version. No code, no def, no file from another author: every change is a guarded patch.

### Instruments: 9 props

The nine instruments of Miniature Props and Decor become playable through the Musical
Instruments (Continued) framework. A colonist walks up, sits down and plays on the spot.

Two components are mandatory, checked by decompiling `MusicalInstruments.dll`:
`CompProperties_MusicalInstrument` and `CompProperties_MusicSpot`. No prior research is added,
unlike Mlie's marimba: these props are already unlocked.

The metronome is left alone.

### Recreation: 2 props

The handheld game console and the ham radio finally get a recreation type. Both already lived in
a file named `Buildings_Recreation.xml`, with no `joyKind` attached.

### Fountains: 7 props

The seven fountains of Alpha Props become **natural** meditation foci, not artistic ones: it is the
only type the game ties to water, plants and calm, and the one used by tribal psycasters, the most
furniture-free path in the base game.

Strength follows size, the only objective scale available. For reference, the vanilla natural
shrine is worth 0.22 and the animus stone 0.34. The zen fountain gets one notch more than its
same-size siblings: that is literally its purpose.

They also stop counting as artificial construction near other foci.

### Hedges: anima and gauranlen

They now strengthen the neighbouring natural foci (anima tree, animus stone, shrines) instead of
each becoming a standalone focus. A hedge is placed by the dozen: making each one an independent
focus would have created a forest of identical meditation points.

They also stop counting as artificial construction.

### Troughs: 5 props

The five troughs of Alpha Props become animal feeders. The game has no drinking trough or feeder:
hay is put on the floor and rots there. This is the one place in this mod where the missing
function and the unused prop overlap exactly.

They become storage buildings for two reasons: the filter, without which a "feeder" would fill up
with steel, and above all `preventDeteriorationOnTop`: hay no longer rots in the rain there, so
the trough can stand in the pasture instead of under a roof.

**This is the only entry in this mod that changes a price.** `thingClass` is a single field, and
these props already carried `VFEProps.Building_SubstractsSilver`, the class that takes silver at
build time instead of a `costList`. Taking `Building_Storage` gives that up, and the troughs would
have become free: they get 25 wood and 400 work instead.

The three flowered troughs are converted like the other two. Leaving them decorative would have
left three pure props standing, which this mod exists precisely to refuse.

All five also get a French label and description, which the original mod lacks.

### Optional Chinese bookcase integration

One guarded function patch for the RepossessedFurniture-owned `SZ_ZhuangShiShuJia`: a decorative
bookcase that holds ten real books, with its original static artwork. No source def, asset or
assembly is imported, and the patch does nothing without RepossessedFurniture. Added a source
manifest, an ownership audit and a test protocol. Saved instances must be emptied and deconstructed
before changing the runtime class. In-game scenarios remain unexecuted.
