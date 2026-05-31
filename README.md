# DOSHorse_Web

> **Status:** v0.0.1-Faggin skeleton. Géén code-import in deze fase. Prio 2.

Browser-variant van DOSHorse. WASM-compile van `DOSHorse_Core` (via Emscripten) + eigen JS/HTML/CSS frontend.

## Doel

DOS draaien in elke moderne browser, zonder install. Drop een `.exe` of `.img` en spelen.

## Strategie

dosbox-x heeft géén officiële Emscripten-port. Twee routes (beslispunt O3):

- **A. Pure eigen Emscripten van DOSHorse_Core** — echt port-werk, maximale controle, langste pad naar runnable
- **B. Bestaande WASM shortcut** — `js-dos` (DOSBox 0.74-based) of `em-dosbox` als bootstrap, later vervangen door eigen Core-build

Default-aanbeveling: B als bootstrap voor v0.0.2-3, A als doel voor v0.1.0+.

## Codenaam

v0.0.1 = **Faggin** (Federico Faggin, 8080/Z80 chip-designer) — past bij chip-emulatie-in-nieuwe-context (WASM = nieuwe instruction-set-omgeving).

Pool-bron: `Meta_DOSHorse/CLAUDE.md`.

## Routes (te kiezen v0.0.2)

Analoog aan AmigaHorse_Web:
- **Quick** — drag-and-drop `.exe`/`.img`, auto-run
- **Full** — ROM-library, settings, compat-presets per game

## Status

| Component | Status |
|-----------|--------|
| Skeleton | ✓ |
| Emscripten build-config | open (v0.0.2) |
| Bootstrap-keuze (eigen vs js-dos) | open beslispunt O3 |
| JS/HTML/CSS frontend | open |
| IndexedDB save-state + library | open |
| Web Audio | open |
| Gamepad API | open |

## Deploy

`horsecloud55.ddns.net/DOSHorse/` (statisch). Geen Hostinger.
