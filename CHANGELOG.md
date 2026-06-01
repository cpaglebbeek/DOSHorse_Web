# CHANGELOG — DOSHorse_Web

## v0.0.3-Sutherland — 2026-06-01 ✅ VERIFIED

> **Status:** Verificatie compleet **na OEU** door auto-task `byw4tnpc5` (build attempt #2 met DOSHorse_Core@66927f6 v0.0.5-Roberts CFLAGS-hotfix). Smoke-test #4 toont DOSHorse-banner in WASM `--version` output via Node.js. Artefacten: `dist/doshorse-x.js` 212K + `dist/doshorse-x.wasm` 16M.

Sub-step 3 van Emscripten-pad — echte dosbox-x WASM-build via upstream's `build-emscripten-sdl2` script + branding-patch toegepast op WASM-binary.

### Toegevoegd
- **Submodule keten**: `git submodule add --depth 1` Core → `core/` + recursive init pakt dosbox-x@`4a95241b` mee (3-niveau keten zoals DOSHorse_X86 v0.0.4)
- **Makefile uitbreiding**: nieuwe targets `wasm-apply-patches`, `wasm-build`, `wasm-install`, `wasm-clean-patches`. Variabelen voor source-pad (`core/upstream/dosbox-x/src/dosbox-x{.js,.wasm}`) en dist-pad (`dist/doshorse-x{.js,.wasm}`)
- **BUILD.md** bijgewerkt: sub-step 3 markeert als DONE, sub-step 4+ (Quick/Full mode UI) als pending

### Build-procedure
```bash
# 1. Submodule init (eenmalig na clone)
git submodule update --init --recursive --depth 1

# 2. Patch + build + install
make wasm-apply-patches    # voegt DOSHorse-banner toe aan upstream source
make wasm-build            # ~15-30 min Emscripten compile via build-emscripten-sdl2
make wasm-install          # kopieert src/dosbox-x{.js,.wasm} → dist/doshorse-x{.js,.wasm}
```

### Emscripten-versie-noot
Upstream `build-emscripten-sdl2` was getest tegen Emscripten 3.1.28. Wij gebruiken **5.0.7** (gedeeld met AmigaHorse_Web). Script bevat alleen check op `$EMSDK` env-var, niet op exacte versie. Bewezen werkt: zie BUILD_LOG.md smoke-test #4 voor host-resultaten.

### Codenaam-rationale
**Sutherland** = Ivan Sutherland (Sketchpad, 1963) — **eerste interactieve computer-graphics**, gold standard voor "rendering inside a window". Past bij DOSHorse_Web's **eerste echte dosbox-x WASM-build**: we tonen DOS-graphics rendering in een browser-canvas — directe descendant van Sutherland's Sketchpad-interactiviteit.

### Bewezen lokaal (smoke-test #4, post-OEU)
```
$ make wasm-install
✓ Installed JS: dist/doshorse-x.js (212K)
✓ Installed WASM: dist/doshorse-x.wasm (16M)

$ ln -sf doshorse-x.wasm dist/dosbox-x.wasm   # alias voor hardcoded JS-loader-pad
$ source tools/emscripten-env.sh && node dist/doshorse-x.js --version
DOSHorse version 0.0.3-Canion (forked from upstream below)
DOSBox-X version 2026.05.02 SDL2, copyright 2011-2026 The DOSBox-X Team.
```

### Known drift (v0.0.4 follow-up)
- **Branding-string-mismatch**: patch 0001 hardcoded `0.0.3-Canion` (van toen Core Canion was). Bij Core/Web version-bumps moet patch 0001 mee-updated. Fix-route: build-time substitution via Makefile, of patch-template. v0.0.4 polish.
- **WASM-loader filename**: JS-loader hardcoded `dosbox-x.wasm`-zoekpad. Tijdelijk via symlink in `dist/`; structureel: patches voor `Module.locateFile` of build-script-flag.

### Niet uitgevoerd (sub-step 4+ in v0.0.4)
- JS/HTML frontend (Quick mode: drag-and-drop .exe/.img / Full mode: ROM-library + settings) — beslispunt W2
- IndexedDB save-states (P-DSH-04)
- Web Audio + Canvas/WebGL bindings
- Touch-overlay voor mobile browsers
- Linking met `libdoshorse_core.a` (Core's Public API stub-impl) → dosbox-x' internal state
- Branding-patch dynamic versioning (zie Known drift hierboven)

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
