---
name: pokeplatinum-data-layout
description: How to find and edit trainer, encounter, species, and shop data in the pokeplatinum decomp. Emphasizes discovery-by-search over fixed paths — always grep/glob to confirm where data really lives before editing. Use when you need to locate or modify any of these data categories.
---

# pokeplatinum data layout — find it, then edit it

The cardinal rule of this repo: **discover by search, do not trust remembered paths.** DS-decomp
internals shift and are obscure. The pointers below are verified starting points — but always
confirm with a quick `grep`/`glob` before editing, because the repo evolves.

## Discovery recipes

**Find a specific trainer/species/area's data file first:**
```bash
ls res/trainers/data/ | grep -i <name>          # trainers (one JSON each)
ls res/pokemon/ | grep -i <species>             # species folders
ls res/field/encounters/ | grep -i <area>       # wild encounter tables
```

**Confirm a constant exists before using it** (typos break the build):
```bash
grep -rn 'SPECIES_CRANIDOS' generated/ include/  # also MOVE_*, ITEM_*, ABILITY_*, AI_FLAG_*, TM##
cat generated/items.txt | grep -i <item>
```

**Trace scripted content** (legendaries, gift mons, story battles) — never guess the trigger:
field script → scrcmd macro → C handler.
```bash
grep -rln -i '<legendary>' res/field/scripts/ src/
```

## Verified locations (confirm before editing)

| Category | Location | Format |
|----------|----------|--------|
| Trainers | `res/trainers/data/*.json` | one JSON per trainer; `party[]` with species/level/item/`moves[]`/`iv_scale`/`ai_flags[]` |
| Species  | `res/pokemon/<species>/data.json` | `base_stats`, `types[]`, `abilities[]`, `learnset.by_level` (`[lvl,"MOVE_*"]`), `learnset.by_tm` |
| Wild encounters | `res/field/encounters/encounters_<area>.json` | per-area slot tables (grass/surf/fish) |
| Static/legendary | `res/field/scripts/*.s` + `src/` | scripted — trace the trigger first |
| Shop inventory | `include/data/mart_items.h` | C: `PokeMartCommonItems[]` (`{ITEM_*, badges}`) + `<City>MartSpecialties[]` (ends `SHOP_ITEM_END`) |
| Shop → city wiring | `res/field/scripts/scripts_<city>_mart.s` | calls `PokeMartSpecialtiesWithGreeting MART_SPECIALTIES_ID_<CITY>` |

## Editing discipline

- **JSON data** (trainers/species/encounters): preserve exact JSON — no trailing commas, correct
  types. Validate: `python3 -m json.tool <file>`.
- **C tables** (`mart_items.h`): valid C array syntax; specialty arrays terminate with `SHOP_ITEM_END`.
  Validation here is the build itself.
- After any edit, rebuild with `make` (build-doctor) to prove it still compiles. One feature = one
  diff. The original ROM is never committed.
