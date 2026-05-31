# ARCHITECTURE — DOSHorse_Web

> Skeleton-fase.

## Doel

DOS-emulatie in de browser via WASM-compile van DOSHorse_Core.

## Geplande structuur (v0.0.2+)

```
DOSHorse_Web/
├── core/                  # git submodule -> DOSHorse_Core
├── src/
│   ├── index.html         # entry (Quick mode op /)
│   ├── full.html          # Full mode op /full
│   ├── ts/                # TypeScript glue
│   └── css/
├── build/                 # Emscripten output (gitignored)
├── deploy/                # rsync script naar HC55
└── package.json
```

## Open beslispunten

| # | Vraag | Wanneer |
|---|-------|---------|
| W1 | Bootstrap: eigen Emscripten of js-dos/em-dosbox shortcut? | v0.0.2 |
| W2 | TS framework: vanilla, Lit, Preact, of Svelte? | v0.0.3 |
| W3 | Save-state opslag: IndexedDB lokaal of WebDAV naar HC55? | v0.0.4 |
