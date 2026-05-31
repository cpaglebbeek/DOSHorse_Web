# CLAUDE.md — DOSHorse_Web

> Sub-repo. Globale regels: `Meta_Master/CLAUDE.md`. Ecosysteem-regels: `Meta_DOSHorse/CLAUDE.md`. Hier alleen Web-specifiek.

## Rol

WASM-variant (browser). Prio 2.

## Codename

v0.0.1 = Faggin. Pool: `Meta_DOSHorse/CLAUDE.md`.

## Regels

- WASM-binary NIET committen — alleen bron + build-scripts.
- Bestanden onder `dist/` zijn build-output (gitignore).
- Deploy via rsync naar `horsecloud55.ddns.net/DOSHorse/web/` (script in `deploy/`).
- Geen Hostinger/icthorse.nl voor deze variant (afwijking van standaard, bewust gekozen in newp beslispunt 5).
