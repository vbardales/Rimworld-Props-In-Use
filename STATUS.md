---
localization: unchecked
translation_en: unchecked
translation_fr: unchecked
mod:          Props in Use
packageId:    nelim.propsinuse
repo:         Rimworld-Props-In-Use
visibility:   public
detached:     no
workflow_stage: setupRepo
licence:      forbidden
licence_at:   existing props alive; Chinese source forbidden (2877536640 About lines 17-24); optional patch on the RF-owned def, nothing of the source imported
dependencies: optional source mods; Chinese bookcase owner nelim.repossessedfurniture
showcase:     complete
tested_on:
workshop:
remaining:
  - open: 1.b licence/licence_at and visibility public to re-confirm (owner chose public 2026-10-28); history of the initial commit holds Docs/CHINESE_MANIFEST.json
  - open: 1.a duplicate check not done (Search-Workshop needs owner OK)
  - open: 1.h STATUS.md front matter incomplete (remote, settings_audit, upstream_mod_remotes): rebuild from templates/STATUS.template.md
  - open: 1.k record the move to makeSources once 1.a and 1.h are done
  - open: check Mod/About/PublishedFileId.txt (3811402847) against workshop field; LICENSE differs root vs Mod/
  - note: GitHub repo vbardales/Rimworld-Props-In-Use public, pushed e1b7f58 on 2026-10-28
  - unverified: never seen running
session:      01a09721-3c91-72a3-8e78-5d2c507deb63
updated:      2026-10-28, repo pushed, remaining refreshed
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

This integration is a public optional dependency (owner decision, 2026-10-28): the patch ships no source file and does nothing without RepossessedFurniture. The CHINESE_MANIFEST.json index of source defs stays out of the repo (.gitignore). Source edition 2877536640 is classified
`forbidden` because About/About.xml lines 17–24 objects to unauthorized republication.
An invitation to submit patches does not grant redistribution rights. Credits:
Diamond.J, DaJian (has exited), Frolg, TangWan, XF and other credited contributors;
the source notice also names GLONASS, Naiya and JARON. No publication or push occurred.

Optional load order: Core, RepossessedFurniture, PropsInUse. No new mandatory
dependency: without the exact 2x1 bookcase and Core Bookcase, the patch is inert.
Do not combine duplicate source owners. Only the RF-owned 1.6 integration is supported.
Empty and deconstruct existing copies before enabling or disabling the conversion:
changing `thingClass` on saved instances is not claimed migration-safe.

See `Docs/CHINESE_AUDIT.md`, `Docs/SOURCES.json` and `TESTING.md` for selection, provenance, coverage and unplayed scenarios.

Chinese validation: 68 assertions, 11 XML, 739 concrete source defs indexed; post-patch field/reference/class checks pass, 9 types resolved, 26 config rules pass. Tested against the final RF-owned bookcase. No C# compilation applies; no game scenario executed. The forbidden classification records the Chinese source restriction, not a relicensing of original MIT patch code. Remote visibility was not rechecked or changed.

Validation complémentaire : Check-DefInjected vérifie la description française (1 clé, 0 erreur). Les empreintes des 93 fichiers XML amont inspectés sont inchangées en fin d'audit.
