---
localization: unchecked
translation_en: unchecked
translation_fr: unchecked
mod:          Props in Use
packageId:    nelim.propsinuse
repo:         Rimworld-Props-In-Use
remote:       https://github.com/vbardales/Rimworld-Props-In-Use.git
visibility:   public
detached:     no
workflow_stage: makeSources
licence:      original
licence_at:   "2026-10-29: patches only, every source mod is an optional dependency (props mods, RepossessedFurniture); no source file, texture or def shipped; the Chinese source restriction (2877536640) binds RF, not this mod; owner confirmed, visibility public"
upstream_mod_remotes: N/A
settings_audit: unchecked
published:    yes
dependencies: optional source mods; Chinese bookcase owner nelim.repossessedfurniture
showcase:     complete
tested_on:
workshop:     3811402847
remaining:
  - note: 1.a duplicate check done 2026-10-29 (Search-Workshop, About.xml refs to sarg.alphapropsparks|Leo.PropsDecor, 9416 folders): no duplicate; only ours (Props as Style, Props as Deco), Better Architect Menu, Decor into Props (ferny, unrelated)
  - note: Workshop item 3811402847 published as 0.1.0, hidden (owner, 2026-10-29)
  - note: GitHub repo vbardales/Rimworld-Props-In-Use public, pushed e1b7f58 on 2026-10-28
  - note: 2.a Art/ModIcon-source.png and 2.e Art/Preview-source.png delivered by owner (ModIcon 1254x1254; Preview replaced 2026-10-29 by a flat-sprite scene, Measure-Palette: 2 families, Vmean 0.392 >= 0.30, no face); none created by session
  - unverified: never seen running
session:      01a09721-3c91-72a3-8e78-5d2c507deb63
updated:      2026-10-29, makeSources, waiting for owner art sources
protocols_read_sha: cc1f93006ee3756009054a0389731cff310d8784
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
