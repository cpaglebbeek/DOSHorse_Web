#!/usr/bin/env bash
# DOSHorse_Web — Emscripten environment loader (v0.0.2-Allen)
#
# Source this file in each shell sessie waarin je een WASM-build doet.
# Géén permanente .zshrc-aanpassing: emsdk-env-vars worden alleen in de
# huidige shell gezet.
#
# Gebruik:
#     source tools/emscripten-env.sh
#     emcc --version
#     # ... build commando's ...
#
# Geïnstalleerde versie (gepind v0.0.2, gedeeld met AmigaHorse_Web):
#   emsdk     = 5.0.7  (commit 263db4cffa6f9fc2ec514a70abac81362ea41849)
#   node      = 22.16.0 (bundled)
#   python    = 3.13.3  (bundled)
#
# emsdk is gedeelde toolchain in ~/Documents/Gemini_Projects/emsdk — niet vendored
# binnen elk web-repo, omdat de SDK ~1.8 GB is.
#
# Update-protocol: bij emsdk-bump → cross-check tegen AmigaHorse_Web v0.0.2.2
# pin om versie-drift tussen beide Web-targets te voorkomen.

EMSDK_PATH="${HOME}/Documents/Gemini_Projects/emsdk"

if [[ ! -d "${EMSDK_PATH}" ]]; then
    echo "ERROR: emsdk niet gevonden op ${EMSDK_PATH}" >&2
    echo "Installeer met:" >&2
    echo "  cd ~/Documents/Gemini_Projects && git clone https://github.com/emscripten-core/emsdk.git" >&2
    echo "  cd emsdk && ./emsdk install 5.0.7 && ./emsdk activate 5.0.7" >&2
    return 1 2>/dev/null || exit 1
fi

# Source emsdk_env.sh silently tenzij DOSHORSE_VERBOSE_EMSDK=1.
if [[ -n "${DOSHORSE_VERBOSE_EMSDK:-}" ]]; then
    # shellcheck source=/dev/null
    source "${EMSDK_PATH}/emsdk_env.sh"
else
    # shellcheck source=/dev/null
    source "${EMSDK_PATH}/emsdk_env.sh" >/dev/null 2>&1
fi

if ! command -v emcc >/dev/null 2>&1; then
    echo "ERROR: emcc niet beschikbaar na sourcen ${EMSDK_PATH}/emsdk_env.sh" >&2
    return 1 2>/dev/null || exit 1
fi

if [[ -n "${DOSHORSE_VERBOSE_EMSDK:-}" ]]; then
    echo "✓ Emscripten environment loaded ($(emcc --version | head -1))"
fi
