---
date: 2026-05-31
repo: DOSHorse_Web
status: done
resume: ""
session: newp DOS Emulator — cross-repo verwijzing
agent: Claude Opus 4.7 (1M context)
---

# Newp DOS Emulator — DOSHorse_Web cross-repo verwijzing

Dit is een **pointer-stub** voor het cross-repo prompt-protocol (Meta_Master/CLAUDE.md §Prompt Sessie Documentatie §Wanneer §4).

## Master sessie-MD

**Volledige sessie:** [`Meta_DOSHorse/prompts/2026-05-31_newp_dos_emulator.md`](https://github.com/cpaglebbeek/Meta_DOSHorse/blob/main/prompts/2026-05-31_newp_dos_emulator.md)

## Wat is hier vastgelegd (DOSHorse_Web-specifiek)

- v0.0.1-Faggin (Federico Faggin, 8080/Z80 chip-designer) — past bij chip-emulatie-port naar WASM-instruction-set
- Rol: Variant 2 — WASM (Emscripten) + JS/HTML/CSS frontend; dosbox-x heeft géén officiële Emscripten-port → echt port-werk
- Bootstrap-keuze open: js-dos/em-dosbox shortcut vs pure eigen Emscripten van DOSHorse_Core
- Skeleton-fase: README + CLAUDE + ARCHITECTURE + CHANGELOG + LICENSE (AGPL-3.0) + VERSION + .gitignore — géén code-import
- Open beslispunten in `ARCHITECTURE.md`: W1 (bootstrap), W2 (TS-framework), W3 (save-state opslag IndexedDB/WebDAV)

## Volgende sessie

v0.0.4 of later — Emscripten-toolchain-install + eerste WASM-build (volgt op X86-runnable in v0.0.2-3).
