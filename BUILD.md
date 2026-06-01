# Building DOSHorse_Web

> **v0.0.2-Allen** — Emscripten-toolchain geconfigureerd + skeleton WASM smoke-test bewezen. Sub-step 3 (echte dosbox-x WASM-build via upstream's `build-emscripten-sdl2`) volgt v0.0.3+.

## Status (v0.0.2)

| Stap | Status | Notitie |
|---|---|---|
| Emscripten-toolchain | ✅ Geconfigureerd via `tools/emscripten-env.sh` | emsdk 5.0.7 in `~/Documents/Gemini_Projects/emsdk` (gedeeld met AmigaHorse_Web) |
| Skeleton WASM smoke-test | ✅ Bewezen v0.0.2 | `test/hello.c` → `build/hello.{html,js,wasm}` via emcc; runt via `node` |
| Submodule `core/` | ⏳ Sub-step 3 (v0.0.3+) | DOSHorse_Core voor dosbox-x source |
| dosbox-x WASM-build | ⏳ Sub-step 3 | `core/upstream/dosbox-x/build-emscripten-sdl2` bestaat al in upstream |
| JS/HTML frontend | ⏳ Sub-step 4 (v0.0.4+) | Quick mode + Full mode (beslispunt W2) |
| IndexedDB save-states | ⏳ Sub-step 5+ | P-DSH-04 portable `.dhs` |

## Eenmalige setup (host-machine)

emsdk wordt gedeeld met AmigaHorse_Web — als die al is geïnstalleerd, sla deze stap over.

```bash
cd ~/Documents/Gemini_Projects
git clone https://github.com/emscripten-core/emsdk.git
cd emsdk
./emsdk install 5.0.7
./emsdk activate 5.0.7
```

emsdk is ~1.8 GB. Wordt **niet vendored** binnen `DOSHorse_Web` (te groot voor git-track + redundant met AmigaHorse_Web).

## Quick-start (v0.0.2)

```bash
cd DOSHorse_Web

# Sanity: check dat emsdk bereikbaar is
make env-check
# → emcc 5.0.7 (263db4cf...)

# Build skeleton WASM + smoke-test
make
# → ✓ WASM build OK: build/hello.html + build/hello.js + build/hello.wasm
# → Running build/hello.js via Node.js...
# → DOSHorse_Web Emscripten smoke-test
# → Build target: WASM via Emscripten
# → Version: 0.0.2-Allen (sub-step 2)
```

## Makefile-targets

| Target | Wat |
|---|---|
| `make` of `make all` | build + smoke |
| `make env-check` | Source `emscripten-env.sh` + print `emcc --version` |
| `make build` | Compile `test/hello.c` naar `build/hello.{html,js,wasm}` |
| `make smoke` | Run `build/hello.js` via Node.js |
| `make clean` | Verwijder `build/` |
| `make version` | Toon DOSHorse_Web-versie |
| `make help` | Toon hulp |

## Handmatige workflow (zonder make)

```bash
source tools/emscripten-env.sh
emcc test/hello.c -o build/hello.html
node build/hello.js                   # of: open build/hello.html in browser
```

## Sub-step 3 (gepland v0.0.3+)

Echte WASM-build van dosbox-x via upstream's eigen `build-emscripten-sdl2` script:

```bash
# In DOSHorse_Web (na submodule add)
git submodule add --depth 1 https://github.com/cpaglebbeek/DOSHorse_Core.git core
git submodule update --init --recursive --depth 1

# Apply branding-patch (zelfde flow als X86)
core/tools/apply-patches.sh

# WASM-build (upstream script)
cd core/upstream/dosbox-x
source ../../../tools/emscripten-env.sh
./build-emscripten-sdl2
```

Verwacht resultaat: `core/upstream/dosbox-x/src/dosbox-x.wasm` (+ JS-glue) — branded versie zal "DOSHorse version 0.0.x-Codename" tonen.

## Bekende issues

Geen. Sub-step 1+2 werken end-to-end.

## Architectuur-noot

DOSHorse_Web hergebruikt de **gedeelde** emsdk-installatie (Apple Silicon + Intel beide werken met emsdk 5.0.7) om disk-space te besparen en versie-drift tussen AmigaHorse_Web en DOSHorse_Web te vermijden. Bij toekomstige emsdk-bump: cross-check eerst met AmigaHorse_Web's `tools/emscripten-env.sh` versie-pin.
