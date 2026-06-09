# Renegade-Style Platinum — ROM-Hack auf Basis pret/pokeplatinum

Dies ist ein **eigener Pokémon-Platinum-ROM-Hack**. Basis ist die WIP-Decompilation
[`pret/pokeplatinum`](https://github.com/pret/pokeplatinum), die eine byte-genaue
`pokeplatinum.us.nds` baut. Wir bauen **keine eigene Engine** — wir editieren den
bestehenden Decomp-Code und seine Datentabellen.

**Design-Blaupause:** Renegade Platinum (als Vorbild für Schwierigkeitsgrad/Balancing,
**KEIN Code-Merge**). HeartGold-Daten kommen aus `../pokeheartgold` (reine Referenz daneben,
nicht in diesem Repo) und werden im pokeplatinum-Format **nachgebaut**, nie blind kopiert.

## Ziel-Features (Roadmap)

1. **Renegade-Stil Hard-Mode:** deutlich höherer Schwierigkeitsgrad, faire Nuzlocke-Tauglichkeit,
   bessere Movesets/Level/AI bei Trainern.
2. **HeartGold-Bossfights:** HG-Gym-Leader-Teams als härtere Boss-Kämpfe in Platinum einbauen.
3. **Alle Legendären fangbar** machen (auch normal nicht verfügbare).
4. **Alle Items in jedem Shop** kaufbar machen.
5. **Erweiterte Pokémon-Verfügbarkeit** (mehr Linien früher fangbar).

> Diese großen Features kommen **NACH** dem ersten erfolgreichen Test (Roark bekommt ein
> HG-Leader-Team). Erst Pipeline beweisen (build grün → ein editierter Trainer baut sauber),
> dann skalieren.

## Goldene Regeln (immer beachten)

- **Niemals Dateipfade aus dem Gedächtnis erfinden.** DS-Decomp-Interna sind obskur. Vor jeder
  Edit erst mit Grep/Glob im Repo finden, wo die Daten wirklich liegen.
- **Build-Wahrheit steht in `INSTALL.md`.** Toolchain/Befehle nicht raten, dort nachlesen.
- **Original-Platinum-ROM wird NIE committet** (liegt lokal, in `.gitignore`). Gegen sie wird gebaut.
- **Kleine, überprüfbare Commits:** ein Feature = ein nachvollziehbarer Diff.
- Bei unsicheren DS-/Hardware-Details **nicht behaupten**, sondern im Code / pret-Doku verifizieren.

## Build (verifiziert aus INSTALL.md, macOS)

```bash
# Einmalig Dependencies (Homebrew):
brew install gcc@14 ninja libpng pkg-config arm-none-eabi-gcc xz
brew install --cask wine-stable

# Bauen:
make
# Ergebnis: build/pokeplatinum.us.nds
# Erwartete sha1 (Rev 1): 0862ec35b24de5c7e2dcb88c9eea0873110d755c
```

Tipp aus INSTALL.md: Persistenten Wine-Server (`wineserver -p`) im Hintergrund laufen lassen
beschleunigt Builds; ggf. erstes `make` mit Ctrl+C abbrechen und erneut `make`.

## Aufwands-Reihenfolge (leicht → schwer)

| Stufe | Was | Wo (verifiziert) |
|------|-----|------------------|
| 1 — am einfachsten | **Trainer-Teams** (Level, Movesets, Items, AI) | `res/trainers/data/*.json` (ein JSON je Trainer) |
| 1 | **Shop-Inventar** ("alle Items kaufbar") | `include/data/mart_items.h` (`PokeMartCommonItems[]` + `*MartSpecialties[]`) |
| 2 | **Base Stats / Learnsets / Abilities** | `res/pokemon/<species>/data.json` |
| 3 | **Wild-Encounter** | `res/field/encounters/encounters_*.json` |
| 3 | **Static/Legendäre Encounter** (oft scripted) | Trigger zuerst über decomp-navigator finden (`res/field/scripts/*.s`, `src/`) |
| 4 | **Sprites** | `res/pokemon/<species>/sprite_data.json`, `res/graphics/` |
| 5 | **Scripting** | `res/field/scripts/*.s` |
| 6 — am schwersten | **Maps** | `res/field/` map-/matrix-Daten |

## Datenformat-Notizen (verifiziert am Repo)

- **Platinum-Trainer** (`res/trainers/data/leader_roark.json`): Felder `name`, `class`,
  `items[]`, `ai_flags[]` (Liste von `AI_FLAG_*`-Namen), `double_battle`, `party[]` mit
  `species`/`form`/`level`/`item`/`moves[]`/`iv_scale`/`ball_seal`, sowie `messages[]`.
- **HeartGold-Trainer** (`../pokeheartgold/files/poketool/trainer/trainers.json`): Felder
  heißen anders — `ai_flags` ist ein **Integer-Bitfeld**, `iv_scale`→`difficulty`,
  `ball_seal`→`capsule`, zusätzlich `genderOverride`/`abilityOverride`, `type` (z.B.
  `TRTYPE_MON_ITEM_MOVES`). Beim Port also **Werte übernehmen, Format anpassen** — nicht 1:1 kopieren.

## Workflow / Subagents

- **decomp-navigator** — findet WO Dinge liegen, verifiziert DS-Details (read-only). Backbone gegen Halluzination.
- **build-doctor** — liest INSTALL.md, baut die ROM, diagnostiziert Fehler.
- **trainer-editor** — Trainer-/Party-Daten.
- **encounter-editor** — Wild- und Static-Encounter (inkl. Legendäre).
- **species-balancer** — Base Stats, Learnsets, Abilities.
- **shop-editor** — Mart-/Shop-Inventar.
- **hg-porter** — liest `../pokeheartgold` als Referenz, extrahiert HG-Daten zum Nachbau.

Skills: `pokeplatinum-data-layout` (Discovery-by-Search), `nuzlocke-balancing` (fairer Hard-Mode).
