# DOSHorse_Web — Emscripten WASM build-wrapper
# v0.0.2-Allen (sub-step 1+2) — toolchain-config + skeleton WASM smoke-test
#
# Sub-steps (analoog aan AmigaHorse_Web v0.0.2.x):
#   sub-step 1 — tools/emscripten-env.sh (toolchain-config) [DONE in v0.0.2]
#   sub-step 2 — skeleton WASM smoke-test (test/hello.c → build/hello.html) [DONE in v0.0.2]
#   sub-step 3 — echte dosbox-x WASM-build via upstream's build-emscripten-sdl2 [PENDING v0.0.3+]
#
# Géén automatische `source` van tools/emscripten-env.sh in dit Makefile —
# user moet zelf sourcen omdat Make geen environment-mutaties naar parent shell
# doorgeeft. Workaround per target: subshell + source + cmd.

ENV_SCRIPT := tools/emscripten-env.sh
BUILD_DIR := build
SMOKE_SRC := test/hello.c
SMOKE_OUT := $(BUILD_DIR)/hello.html

# Forceer bash (zsh kent geen `source` van .sh-files in dezelfde syntax)
SHELL := /usr/bin/env bash

.PHONY: all help env-check build smoke clean version

all: build smoke

help:
	@echo "DOSHorse_Web v0.0.2-Allen build-wrapper"
	@echo ""
	@echo "Targets:"
	@echo "  make env-check  Source tools/emscripten-env.sh en print emcc-versie"
	@echo "  make build      Compile test/hello.c naar WASM via emcc"
	@echo "  make smoke      Run build/hello.js via Node.js (no-browser smoke)"
	@echo "  make clean      Remove build/"
	@echo "  make version    Show DOSHorse_Web version"
	@echo ""
	@echo "Manual workflow (alternative to make):"
	@echo "  source tools/emscripten-env.sh"
	@echo "  emcc test/hello.c -o build/hello.html"
	@echo "  node build/hello.js   # of: open build/hello.html in browser"

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

clean:
	rm -rf $(BUILD_DIR)
