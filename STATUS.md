---
localization: complete
translation_en: complete
translation_fr: complete
mod:          Props in Use
packageId:    nelim.propsinuse
repo:         Rimworld-Props-In-Use
remote:       https://github.com/vbardales/Rimworld-Props-In-Use.git
visibility:   public
detached:     no
workflow_stage: playTests[1.0.0]
licence:      original
licence_at:   "2026-10-29: patches only, every source mod is an optional dependency (props mods, RepossessedFurniture); no source file, texture or def shipped; the Chinese source restriction (2877536640) binds RF, not this mod; owner confirmed, visibility public"
upstream_mod_remotes: N/A
settings_audit: partial
published:    yes
dependencies: declared (none hard; six optional sources in loadAfter, 2026-10-29, rev a2f3ae5)
showcase:     complete
tested_on:
workshop:     3811402847
remaining:
  - note: 1.a duplicate check done 2026-10-29 (Search-Workshop, About.xml refs to sarg.alphapropsparks|Leo.PropsDecor, 9416 folders): no duplicate; only ours (Props as Style, Props as Deco), Better Architect Menu, Decor into Props (ferny, unrelated)
  - note: Workshop item 3811402847 published as 0.1.0, hidden (owner, 2026-10-29)
  - note: GitHub repo vbardales/Rimworld-Props-In-Use public, pushed e1b7f58 on 2026-10-28
  - note: 2.a Art/ModIcon-source.png and 2.e Art/Preview-source.png delivered by owner (ModIcon 1254x1254; Preview replaced 2026-10-29 by a flat-sprite scene, Measure-Palette: 2 families, Vmean 0.392 >= 0.30, no face); none created by session
  - note: 4.a/4.g dependencies 2026-10-29 (rev a2f3ae5), all optional, none in modDependencies, every patch is a PatchOperationConditional on the target def, inert and silent without its source: Leo.PropsDecor (3579351912, Miniature Props and Decor: MiniatureInstruments, MiniatureRecreation); sarg.alphapropsparks (3146268928, Alpha Props - Parks and Gardens: AlphaFountains, AlphaHedges, AlphaTroughs); Mlie.MusicalInstruments (2274558815, framework for the instruments); VanillaExpanded.VFEPropsandDecor (2102143149, loadAfter only: the troughs carry its Building_SubstractsSilver class); Dajian.ChiTeaditional.Expanded (2877536640, ChineseBookcase source, owned via RF); nelim.repossessedfurniture (3811382245, owns the bookcase def)
  - note: 4.c DLC 2026-10-29: Royalty and Ideology only in loadAfter; hedges patch targets the Royalty natural foci, guarded; no LoadFolders (4.e n/a)
  - note: 4.d 2026-10-29: loadAfter only, no hard dependency, no cycle possible (no source lists this mod; RF loadAfter Dajian only); sort-load-order.py not run, it needs a Pickle staging
  - unverified: settings_audit in-game check at playTests: Mod options lists no Props in Use page and no MainButtons shortcut exists
  - unverified: in-game text check (raw keys, fallback, clipping) at playTests
  - unverified: 7.c Check-XmlClasses on the bookcase snapshot cannot conclude: the type list ../rw16_types.txt no longer exists (ITab_Storage reported unknown, it is vanilla)
  - unverified: Pickle suite Tests/Pickle (10 features, 3 passes) written, never played; ticket to file at playTests
  - feature: needs NPT step (to ask via TM): count of things held by a storage building (ten-book limit, refused eleventh book), item hit points or a stat compared to a remembered value (hay not deteriorating in rain); AI behaviours (animals choosing the trough, two colonists on the console) and save then removal of the mod stay manual or unwritten
  - unverified: never seen running
session:      01a09721-3c91-72a3-8e78-5d2c507deb63
updated:      2026-10-29, playTests[1.0.0], writeTests done (nothing played in game yet)
protocols_read_sha: af740f581512fb2b0d8180812d83916db48bf0c1
---

# Props in Use — status

Read by a sweep across every mod, rather than by asking each thread in turn. It lives at the
root, never inside `Mod/`, so Steam never receives it.

The fields above were read off the disk on 2026-09-12. Four cannot be, and wait for whoever
holds this mod:

- **`stage`** — one of `port`, `showcase`, `preTest`, `done`, `tested`, `published`. Filled in
  from the session group where one exists; confirm it.
- **`tested_on`** — the date of the last run in game. Empty means never.
- **`dependencies`** — `declared` when every mod this one needs is named in the About's
  `modDependencies`, `to check` when a non-vanilla `loadAfter` suggests a dependency that is not
  declared, `none` when the mod needs nothing. An undeclared dependency is not cosmetic: on
  2026-09-11 Reequilibrage animaux took 47 vanilla animals down with it, Muffalo included, because
  the class it injects belongs to a mod that was not declared and not loaded.
- **`remaining`** — what is left, in three kinds: `feature` for something missing from a first
  release, `defect` for a known fault left unfixed, `unverified` for what could not be checked.
  The line already there is true of nearly the whole repository; replace it once it stops being.

`licence` vocabulary: `open` an explicit licence, `silent` no licence and a dead source,
`alive` no licence but a living source, `forbidden` a written refusal, `original` owing nothing
to anyone — not a name, not an idea traceable to one mod, not a value derived from its assets.


## Chinese Traditional Cultural Things Expanded — optional function patch (2026-09-12)

One optional conversion: `SZ_ZhuangShiShuJia`, a 2x1 decorative bookcase, stores ten
real books using Core 1.6 `Building_Bookcase`. RepossessedFurniture owns its original
ThingDef and artwork. PropsInUse declares neither and copies no source assembly.
The original artwork already contains books; `MapMeshOnly` keeps it static and the
Contents tab shows the actual inventory. Costs, quality, art, research and graphics
remain the owner's. Books retain vanilla reading, room and research behavior.

This integration is a public optional dependency (owner decision, 2026-10-28): the patch ships no source file and does nothing without RepossessedFurniture. The CHINESE_MANIFEST.json index of source defs stays out of the repo (.gitignore). Source edition 2877536640 (owned via RF, not shipped here) carries a restriction:
About/About.xml lines 17–24 object to unauthorized republication; this mod republishes nothing.
An invitation to submit patches does not grant redistribution rights. Credits:
Diamond.J, DaJian (has exited), Frolg, TangWan, XF and other credited contributors;
the source notice also names GLONASS, Naiya and JARON. No publication or push occurred.

Optional load order: Core, RepossessedFurniture, PropsInUse. No new mandatory
dependency: without the exact 2x1 bookcase and Core Bookcase, the patch is inert.
Do not combine duplicate source owners. Only the RF-owned 1.6 integration is supported.
Empty and deconstruct existing copies before enabling or disabling the conversion:
changing `thingClass` on saved instances is not claimed migration-safe.

See `Docs/CHINESE_AUDIT.md`, `Docs/SOURCES.json` and `TESTING.md` for selection, provenance, coverage and unplayed scenarios.

Chinese validation: 68 assertions, 11 XML, 739 concrete source defs indexed; post-patch field/reference/class checks pass, 9 types resolved, 26 config rules pass. Tested against the final RF-owned bookcase. No C# compilation applies; no game scenario executed. Licence of this mod: original (owner, 2026-10-29). Remote visibility was not rechecked or changed.

Validation complémentaire : Check-DefInjected vérifie la description française (1 clé, 0 erreur). Les empreintes des 93 fichiers XML amont inspectés sont inchangées en fin d'audit.


## Settings audit (2026-10-29, rev a2f3ae5)

Result: no settings, justified (`partial` until the in-game check at `playTests`).

Inventory. The mod is patches only (six XML files under `Mod/Patches/`, two language folders, About): no assembly, no `Source/`, no ModSettings class, no MainButtonDef, no stored value. Behaviours that could be configurable, and why none is exposed: instruments, recreation, fountain and hedge meditation strengths, trough feeders, ten-book bookcase are fixed values chosen to match the vanilla scale (see CHANGELOG); each source patch is already switched off by not loading its source mod, so an option would duplicate that; the only changed price (troughs, 25 wood and 400 work) is explained in the description and replaces a class the game cannot keep. An option would need C# and an assembly, against the decision of a mod that ships no code. No player need was raised, none invented.

Access contract. Without an assembly there is no Mod options page, and no MainButtons shortcut can exist: confirmed by `git ls-files Mod` (no dll, no def outside patches). In-game confirmation (Mod options does not list the mod, no button) is `unverified` until `playTests`.

Tests. `Check-Status.ps1`: 0 error. No game scenario executed.


## Translation audit (2026-10-29, rev 5596ca9)

Where the French lives: `Mod/Languages/French/Keyed/PropsInUse.xml` (4 keys, hedge focus lines), `DefInjected/ThingDef/AlphaTroughs.xml` (5 troughs, label and description: the source mod has no French), `DefInjected/ThingDef/ChineseBookcase.xml` (1 description, MayRequire RF), `DefInjected/JobDef/Recreation.xml` (2 reportString). English: `Languages/English/Keyed/PropsInUse.xml` and the English text of the patches; no C# text, so no `.Translate()` call.

Checks 2026-10-29: `Check-Translations.ps1 -ModRoot Mod` PASS (6 source texts + 2 nested, coverage, stale, duplicates, tokens); `Check-DefInjected.ps1` 0 error; 5 warnings (trough labels outside the inventory, they come from the source mod defs and resolve). A `Duplicate French DefInjected key` finding seen with `-ModRoot .` is false: the script walks the git-ignored `Build/ChineseEffective/Languages`; `-ModRoot Mod` is clean. Fixed: reportString of the two recreation jobs had no French; the bookcase text addressed the player (consultez, videz), now infinitive. No pawn-agreeing text, so no gendered forms. French review of Virginie: done 2026-10-29, rev 3694f50, no correction requested (review line filled in `FRENCH_REVIEW.md`).

ChatGPT review (2026-10-29, page 1 of 1, read-only): two suggestions, "haie d anima" and "haie de gauranlen". Not applied as such: the base game French says "arbre anima" and "herbe anima" (no d), so "haie anima" stays; "Gauranlen" capitalised like "arbre Gauranlen" (applied). Virginie review done 2026-10-29 (rev 3694f50), no correction; "haie Gauranlen" kept.


## Tests written (2026-10-29, Mod/ last changed in 981bc72)

- 7.a TESTING.md: I01 to I09 (Chinese bookcase) and P01 to P11 (props), all not executed.
- 7.b/7.c offline, rerun 2026-10-29: Tests/Test-Patches.ps1 175 assertions, Tests/Test-ChineseBookcase.ps1 69 assertions, Check-XmlFields and Check-DefRefs on the bookcase snapshot clean, Check-ModBasics PASS. Both scripts declared in scripts/LOCAL_SCRIPTS.md.
- 7.d Tests/Pickle: 10 features (loading, minimal pass, patches applied, instruments, recreation, fountains, hedges, troughs, bookcase, translations), 3 passes (minimal, sources EN, sources FR), no local step, Check-Steps 233 steps resolved, never played. Needs NPT: see remaining.
- 7.e not applicable: no C# so no unit test project (Run-UnitTests has nothing to run), no settings page to test (settings_audit partial).
- 7.f tested revision: Mod/ unchanged since 981bc72; any later commit to Mod/ reopens 7.b and 7.c.
