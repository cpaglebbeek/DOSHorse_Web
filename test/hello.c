/* SPDX-License-Identifier: AGPL-3.0-or-later
 *
 * DOSHorse_Web — Emscripten smoke-test (v0.0.2-Allen sub-step 2)
 * Copyright (C) 2026 cpaglebbeek
 *
 * Bewijst dat de Emscripten-toolchain werkt op DOSHorse_Web's host-Mac
 * door een minimaal C-program te compileren naar WASM + JS-loader.
 *
 * Géén dosbox-x koppeling — dat is sub-step 3+ via upstream's
 * ./build-emscripten-sdl2 script.
 */

#include <stdio.h>

int main(void) {
    printf("DOSHorse_Web Emscripten smoke-test\n");
    printf("Build target: WASM via Emscripten\n");
    printf("Version: 0.0.2-Allen (sub-step 2)\n");
    return 0;
}
