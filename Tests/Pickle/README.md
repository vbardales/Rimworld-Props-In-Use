# Props in Use Pickle suite

Development-only companion (`Mod/`, "Props in Use - Pickle tests") holding the in-game scenarios of Props in Use.
Nothing under `Tests/` is part of the Workshop payload. **Written 2026-10-29, never played**: what has been
played is recorded in `docs/runs/`, not here. RimWorld is started only by the dispatcher's worker
(`Submit-PickleRun.ps1`), never by a session.

The offline suites (`Tests/Test-Patches.ps1`, `Tests/Test-ChineseBookcase.ps1`) own everything a script can prove: fields,
guards, costs, capacities, translation files. Pickle is limited to what needs the running game, and the suite has no step of
its own: every line comes from Pickle or from a PickleTools tool the pass map stages.

## Features

| Feature | Passes | What it shows |
| --- | --- | --- |
| `01-loading` | all | The mod loads with no error or warning of its own; the load audit, keyed texts included, is clean in the language of the pass |
| `02-minimal-pass` | minimal (`@minimal`) | With none of the six sources staged, the mod adds no def and logs nothing |
| `03-patches-applied` | sources | The real loader applied Props in Use to every source def (patch attribution), after the source |
| `04-instruments` | sources, English (`@functional`) | A colonist is handed the playing job of each of the nine miniature instruments and keeps it 300 ticks, no error |
| `05-recreation` | sources, English | The same for the game console and the ham radio (the two jobs the mod adds) |
| `06-fountains` | sources, English | Each fountain reads the focus strength its size earns; seven fountains around an anima tree do not lower it |
| `07-hedges` | sources, English | The anima tree reads 0.28, then +0.04 for four hedges of one kind, still +0.04 for eight, +0.08 for four of each |
| `08-troughs` | sources, English | A colonist builds each of the five troughs from wood; a hungry cow eats hay stored in one; stored hay survives a save and a reload |
| `09-bookcase` | sources, English | The Chinese bookcase opens its Contents and Storage tabs and survives a save and a reload |
| `10-translations` | sources, each language | Trough labels, the two report strings and the hedge lines of the anima tree stat, in the language of the pass (`@english` or `@french`) |

Scenarios are isolated: each loads `test-colony` again. Everything is built south of Jet on cells that the save leaves free
(`FIXTURES.md`: the ruins end at z 167, the stat scenarios sit at z 214 to 224). `07-hedges` first scenario is the control for
that assumption: if it does not read 0.28, an artificial building stands near the tree and the other values mean nothing.
Pickle's stat step tolerates 0.01, so each expected value in `06` and `07` sits at least 0.04 from the value it must not be.

## Pass matrix

| Pass | Map | Filter | Language |
| --- | --- | --- | --- |
| Minimal | `wsl-deps.sans-sources.map` | `Props in Use - Pickle tests,!@french` | English |
| Sources, English | `wsl-deps.avec-sources.map` | `Props in Use - Pickle tests,!@minimal,!@french` | English |
| Sources, French | `wsl-deps.avec-sources.map` | `Props in Use - Pickle tests,!@minimal,!@functional,!@english` | French |

The sources map stages the Vanilla Expanded Framework, VFE Props and Decor, Alpha Props, Miniature Props and Decor,
Musical Instruments and (from its own repository, `path:RepossessedFurniture/Mod`) RepossessedFurniture, then the tools
`loadaudit`, `deffields`, `stagedecor`, `inspecttabs`, `hoversteps`, `colonistrace`, `coatsteps`. Royalty and Ideology come with the game; the fixture
needs them. The French pass skips the functional features: they assert no text, and the French strings are read in `10`.
No pass for declared incompatibilities (the mod declares none). Each pass is one request:

```powershell
powershell.exe -ExecutionPolicy Bypass -File C:\Users\nelim\Documents\rimworld\Rimworld-Ticket-Dispatcher\scripts\Submit-PickleRun.ps1 `
  -Mod PropsInUse -Owner local_<id> -Label "sources English, <sha>" `
  -DepMap wsl-deps.avec-sources.map -Filter 'Props in Use - Pickle tests,!@minimal,!@french' `
  -EvidenceDir Tests/Pickle/Inbox/<run>
```

Add `-Language French` for the French pass. A request carries no SHA: write it in the label and keep `Mod/` and `Tests/Pickle/Mod`
still until `RUN_DONE`.

## Not written, and why

- The ten-book limit and the refused eleventh book of the Chinese bookcase, and a book read from it: no step counts what a
  storage building holds (needs a PickleTools step).
- Hay that does not deteriorate in the rain: no step reads the hit points of an item (needs a PickleTools step).
- Several animals choosing the trough by themselves, and two colonists on the console (joy participants): AI behaviour, not
  asserted; the forced jobs above cover the def side.
- Save then removal of Props in Use (TESTING.md P10, second half): a `-ThenWithout` pair, to write once the first passes are green.
- `@review` captures: none, the suite asserts values; the Contents tab capture of TESTING.md I06 stays manual.

## Offline validation

```powershell
powershell.exe -ExecutionPolicy Bypass -File C:\Users\nelim\Documents\rimworld\scripts\Check-Steps.ps1 -ModRoot C:\Users\nelim\Documents\rimworld\PropsInUse
```

Steps not played anywhere yet (compiled only, per the PickleTools catalogue): the joy giver, forced Ingest, deffields,
info card and hover steps. A red scenario may be one of those steps before it is a defect of the mod.

## Evidence

A run lands in `Tests/Pickle/Inbox/<run>`; a green proof is minified into `Tests/Pickle/Evidence/` by
`scripts/Prune-Evidence.ps1`, a failure is deleted or parked in `Tests/Pickle/Parked/`. All three folders are ignored by git.
