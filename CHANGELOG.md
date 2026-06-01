# CHANGELOG — DOSHorse_Web

## v0.0.2-Allen — 2026-06-01

Sub-steps 1+2 van Emscripten-pad — toolchain-config + skeleton WASM smoke-test.

### Toegevoegd
- **`tools/emscripten-env.sh`** — sourceable helper (geen `.zshrc`-mod). Pinned emsdk 5.0.7 + commit `263db4cf`, gedeeld met AmigaHorse_Web v0.0.2.2 toolchain in `~/Documents/Gemini_Projects/emsdk` (~1.8 GB, niet vendored binnen elk Web-repo). Default-silent; verbose-output via `DOSHORSE_VERBOSE_EMSDK=1`
- **`test/hello.c`** — minimaal C-program voor WASM smoke-test (geen dosbox-x koppeling; sub-step 3+)
- **`Makefile`** — targets: `env-check` (emcc-versie), `build` (emcc compile naar `build/hello.html`), `smoke` (run `build/hello.js` via Node.js), `clean`, `version`, `help`. `SHELL := bash` om `source` te ondersteunen.

### Bewezen lokaal (2026-06-01)
```
$ make env-check
emcc (Emscripten gcc/clang-like replacement) 5.0.7 (263db4cff...)

$ make build
✓ WASM build OK: build/hello.html + build/hello.js + build/hello.wasm

$ make smoke
DOSHorse_Web Emscripten smoke-test
Build target: WASM via Emscripten
Version: 0.0.2-Allen (sub-step 2)
```

Artefacten:
- `build/hello.html` 21,935 B (Emscripten HTML shell)
- `build/hello.js` 77,970 B (JS-glue + runtime)
- `build/hello.wasm` 14,960 B (compiled WASM)

### Codenaam-rationale
**Allen** = Paul Allen (Microsoft co-founder, 1975) — pionier in **software-porting naar nieuwe platforms**: Microsoft BASIC werd vanuit Harvard-mainframe geport naar de Altair 8800 (eerste persoonlijke computer), de eerste echte multi-platform-port-prestatie van Microsoft. Past bij DOSHorse_Web's **eerste WASM-port** — we porten naar een fundamenteel nieuwe runtime (browser sandboxed VM).

### Sub-step 3 (volgende release v0.0.3+)
- WASM-build van echte dosbox-x via upstream's `core/upstream/dosbox-x/build-emscripten-sdl2` script (bestaat al!)
- `--depth 1` submodule add van Core in DOSHorse_Web (zelfde patroon als X86)
- Resulterende WASM `dosbox-x.wasm` + JS-loader + minimale HTML-host
- v0.0.3 trigger-name uit IBM-PC pool

### Niet uitgevoerd in deze release (v0.0.3+)
- Submodule add van Core (komt v0.0.3 — vereist voor dosbox-x source)
- Echte dosbox-x WASM-build (vereist sub-step 3 met `build-emscripten-sdl2`)
- JS/HTML frontend (Quick mode / Full mode — beslispunt W2 v0.0.4+)
- IndexedDB save-states
- Web Audio + Canvas/WebGL bindings
- Branding-patch toepassing op WASM-build (v0.0.3+)

## v0.0.1-Faggin — 2026-05-31

Skeleton via `newp "DOS Emulator"`.

- README + CLAUDE + ARCHITECTURE + LICENSE (AGPL-3.0) + VERSION + prompts/

Vernoemd naar Federico Faggin (8080/Z80 chip-designer) — port van x86-chipemulatie naar WASM-instruction-set.
