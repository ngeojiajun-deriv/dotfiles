---
name: common-dev
description: Shared conventions across all languages — Dockerfile best practices, no magic values, and other cross-cutting rules
---

# Common Development Guide

## File Handling
- Never read or display `.env` files or any files containing secrets/credentials
- When scanning or tidying up a project, ignore gitignored files and directories (e.g. `dist/`, `node_modules/`, `coverage/`, `__pycache__/`, `.env`)

## Magic Values
- No inline magic values — extract into named constants, config parameters, or constructor arguments
- Thresholds, TTLs, limits, etc. should be named and centralized

## Dockerfile

### General
- Use Alpine base images
- Non-root user in production (`USER 1001:1001`)
- Minimize image size — no caches, no unnecessary files

### Node.js
- Multi-stage build: `builder` stage for compilation, `runner` stage for production
- `npm ci` for deterministic installs
- `npm ci --omit=dev` in runner stage
- Aggressive node_modules cleanup in production: strip `.md`, `.txt`, `LICENSE*`, `CHANGELOG*`, non-`.d.ts` `.ts` files, `.map` files, and test/docs directories
- Clean npm cache (`npm cache clean --force`)

### Python
- `pip install --no-cache-dir`
- `COPY requirements.txt` before source for layer caching
- `--chown=1001:1001` on COPY instructions
