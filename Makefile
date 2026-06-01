# DOSHorse_Web — Emscripten WASM build-wrapper
# v0.0.3-Sutherland (sub-step 3) — echte dosbox-x WASM-build via upstream
#
# Sub-steps (analoog aan AmigaHorse_Web v0.0.2.x):
#   sub-step 1 — tools/emscripten-env.sh (toolchain-config) [DONE v0.0.2]
#   sub-step 2 — skeleton WASM smoke-test (test/hello.c → build/hello.html) [DONE v0.0.2]
#   sub-step 3 — echte dosbox-x WASM-build via build-emscripten-sdl2 [DONE v0.0.3]
#   sub-step 4 — JS/HTML frontend (Quick mode + Full mode) [PENDING v0.0.4+]
#   sub-step 5 — IndexedDB save-states (P-DSH-04) [PENDING v0.0.5+]

ENV_SCRIPT := tools/emscripten-env.sh
BUILD_DIR := build
DIST_DIR := dist
SMOKE_SRC := test/hello.c
SMOKE_OUT := $(BUILD_DIR)/hello.html

CORE_DIR := core
DOSBOX_DIR := $(CORE_DIR)/upstream/dosbox-x
PATCH_SCRIPT := $(CORE_DIR)/tools/apply-patches.sh
WASM_BUILD_SCRIPT := build-emscripten-sdl2
WASM_BIN_JS := $(DOSBOX_DIR)/src/dosbox-x
WASM_BIN_WASM := $(DOSBOX_DIR)/src/dosbox-x.wasm
WASM_DIST_JS := $(DIST_DIR)/doshorse-x.js
WASM_DIST_WASM := $(DIST_DIR)/doshorse-x.wasm

# Forceer bash (zsh kent geen `source` van .sh-files in dezelfde syntax)
SHELL := /usr/bin/env bash

.PHONY: all help env-check build smoke wasm-apply-patches wasm-build wasm-install wasm-clean-patches clean version

help:
	@echo "DOSHorse_Web v0.0.3-Sutherland build-wrapper"
	@echo ""
	@echo "Skeleton WASM-targets (v0.0.2-Allen heritage):"
	@echo "  make env-check          Source emscripten-env.sh + emcc-versie"
	@echo "  make build              Compile test/hello.c naar WASM (skeleton-smoke)"
	@echo "  make smoke              Run build/hello.js via Node.js"
	@echo ""
	@echo "Echte dosbox-x WASM-targets (v0.0.3-Sutherland nieuw):"
	@echo "  make wasm-apply-patches Apply core/patches/* op upstream/dosbox-x"
	@echo "  make wasm-build         build-emscripten-sdl2 → src/dosbox-x{.js,.wasm}"
	@echo "  make wasm-install       Kopieer naar dist/doshorse-x{.js,.wasm}"
	@echo "  make wasm-clean-patches Revert patches (git checkout in submodule)"
	@echo ""
	@echo "Common:"
	@echo "  make clean       Remove build/ en dist/"
	@echo "  make version     Show DOSHorse_Web version"
	@echo ""
	@echo "Default 'make all' runs skeleton + dosbox-x WASM keten."

version:
	@cat VERSION

env-check:
	@source $(ENV_SCRIPT) && emcc --version | head -3

build: $(SMOKE_OUT)

$(SMOKE_OUT): $(SMOKE_SRC)
	@mkdir -p $(BUILD_DIR)
	@source $(ENV_SCRIPT) && emcc $(SMOKE_SRC) -o $(SMOKE_OUT)
	@test -f $(SMOKE_OUT) && echo "✓ WASM build OK: $(SMOKE_OUT) + $(BUILD_DIR)/hello.js + $(BUILD_DIR)/hello.wasm" || (echo "✗ Build failed" && exit 1)

smoke: build
	@echo "Running $(BUILD_DIR)/hello.js via Node.js..."
	@source $(ENV_SCRIPT) && node $(BUILD_DIR)/hello.js

wasm-apply-patches:
	@test -x $(PATCH_SCRIPT) || (echo "ERROR: $(PATCH_SCRIPT) not found. Run 'git submodule update --init --recursive'." && exit 1)
	@$(PATCH_SCRIPT)

wasm-build:
	@test -d $(DOSBOX_DIR) || (echo "ERROR: $(DOSBOX_DIR) not found." && exit 1)
	@test -x $(DOSBOX_DIR)/$(WASM_BUILD_SCRIPT) || (echo "ERROR: $(DOSBOX_DIR)/$(WASM_BUILD_SCRIPT) not found." && exit 1)
	@echo "Building dosbox-x → WASM via $(DOSBOX_DIR)/$(WASM_BUILD_SCRIPT)..."
	@cd $(DOSBOX_DIR) && source $(CURDIR)/$(ENV_SCRIPT) && ./$(WASM_BUILD_SCRIPT)
	@test -f $(WASM_BIN_JS) && test -f $(WASM_BIN_WASM) && echo "✓ WASM build OK: $(WASM_BIN_JS) + $(WASM_BIN_WASM)" || (echo "✗ Build failed" && exit 1)

wasm-install: $(WASM_DIST_JS) $(WASM_DIST_WASM)

$(WASM_DIST_JS): $(WASM_BIN_JS)
	@mkdir -p $(DIST_DIR)
	@cp $(WASM_BIN_JS) $(WASM_DIST_JS)
	@echo "✓ Installed JS: $(WASM_DIST_JS) ($$(du -h $(WASM_DIST_JS) | cut -f1))"

$(WASM_DIST_WASM): $(WASM_BIN_WASM)
	@mkdir -p $(DIST_DIR)
	@cp $(WASM_BIN_WASM) $(WASM_DIST_WASM)
	@echo "✓ Installed WASM: $(WASM_DIST_WASM) ($$(du -h $(WASM_DIST_WASM) | cut -f1))"

wasm-clean-patches:
	@test -d $(DOSBOX_DIR) && cd $(DOSBOX_DIR) && git checkout . && echo "✓ All patches reverted" || true

clean:
	rm -rf $(BUILD_DIR) $(DIST_DIR)
