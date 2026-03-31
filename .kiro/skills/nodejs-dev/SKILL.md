---
name: nodejs-dev
description: Style guide and conventions for Node.js/TypeScript development — strict typing, ESM, ESLint stylistic rules, Jest testing, and dependency management
---

# Node.js / TypeScript Development Guide

> Also follow the rules in `common-dev` skill.

## Environment
- Node.js with ESM (`"type": "module"` in package.json)
- TypeScript (strict mode) with `nodenext` module resolution
- Package manager: npm only

## TypeScript Configuration
- `strict: true` with additional strict flags:
  - `noUncheckedIndexedAccess` — indexed access returns `T | undefined`
  - `exactOptionalPropertyTypes` — distinguishes `undefined` from missing
  - `noUnusedLocals`, `noFallthroughCasesInSwitch`
  - `verbatimModuleSyntax` — use `import type` for type-only imports
  - `isolatedModules`
- Target: `esnext`
- Use `.ts` extensions in import paths (e.g. `import { Foo } from "./foo.ts"`)

## ESLint Configuration
Flat config (`eslint.config.mts`) with `@stylistic` plugin:
- 2-space indentation
- Double quotes
- Semicolons always
- Trailing commas (`always-multiline`)
- Object curly spacing, no trailing spaces
- Unused vars: error, but `_`-prefixed args are allowed

## Typing
- Strongly typed — avoid `any`. If the type cannot be deduced, use `any` temporarily with a `//FIXME` comment and ask the user when possible
- Use `interface` for object shapes and contracts
- Use discriminated unions for variant types
- Use `asserts` return types for assertion utilities
- Use generics on interfaces (e.g. `Cache.get<T>`)

## Code Patterns
- ESM imports with `import type` for type-only imports (enforced by `verbatimModuleSyntax`)
- Singleton pattern with lazy getter properties for DI containers
- `interface` for contracts, `class` for implementations
- Custom assertion utilities (e.g. `assertNotNull` with `asserts value is T`)
- Async/await throughout — interfaces return `Promise<T>`

## Logging
- Custom logger class with structured JSON output
- Log levels: debug, info, warn, error
- Include metadata as second argument: `logger.info("message", { key: value })`

## Dependencies
- All dependencies must be up to date — `npm outdated` should return nothing
- Use npm only (no yarn, pnpm, etc.)

## Testing
- Jest with `ts-jest` ESM preset
- Test files colocated: `foo.test.ts` next to `foo.ts`
- `NODE_OPTIONS=--experimental-vm-modules` for ESM support

## Documentation
- JSDoc comments on exported functions and classes
- Inline comments for non-obvious logic
