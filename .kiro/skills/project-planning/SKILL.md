---
name: project-planning
description: Planning methodology for new projects — from problem statement to spec to implementation plan, layering general principles with ecosystem-specific conventions
---

# Project Planning Guide

## Workflow

1. **Problem Statement** — understand the pain point and current manual process
2. **Approach Options** — identify viable approaches, present trade-offs, ask for preference
3. **Spec** — define what the system does, not how
4. **Implementation Plan** — step-by-step build order, grounded in the target ecosystem

## Approach Options

Before writing the spec, identify decision points where multiple valid approaches exist. Present them to the user with trade-offs and ask for a preference.

Examples of decision points:
- Communication model (webhook vs WebSocket vs polling)
- Framework choice (FastAPI vs Slack Bolt vs plain asyncio)
- Storage (database vs file vs in-memory)
- Deployment model (container vs serverless vs systemd)
- Monitoring strategy (push vs pull, polling interval)

### Format

For each decision point:
1. State the problem briefly
2. List 2–3 options with pros/cons
3. Recommend one with reasoning
4. Ask the user before proceeding

Do NOT silently pick an approach when there are meaningful trade-offs. Ask.

## Spec (`spec/SPEC.md`)

### Required Sections

| Section | Content |
|---------|---------|
| Overview | One-line description of what the system does |
| Background | Current pain points and why automation is needed |
| Requirements | Trigger, conditions, actions — the "what" |
| External APIs | curl examples, request/response shapes |
| Tech Stack | Language, frameworks, key libraries |
| Current Scope | What's in scope NOW vs future — be explicit about mocks |
| Project Structure | File tree with one-line descriptions |
| Module Details | Per-module responsibilities and key method signatures |
| Flow | ASCII flow diagram showing the happy path |
| Future Work | Known extensions, explicitly deferred |

### Rules

- Spec describes behavior, not implementation details
- Include curl examples for any external API
- Call out what is mocked vs real in current scope
- Keep the flow diagram simple — happy path only, note error handling in prose

## Implementation Plan (`spec/IMPLEMENTATION_PLAN.md`)

Structured as numbered steps in dependency order. Must reference the target ecosystem's conventions (e.g. the `python-dev` or `nodejs-dev` skill) and build on top of them.

### Required Sections

| Section | Content |
|---------|---------|
| Design Principles | General + ecosystem-specific principles (see below) |
| Steps | Ordered by dependency — each step is one file or logical unit |
| Per-Step Detail | Constants, models, class signatures, key method pseudocode |
| Linting | How to run linters, referencing ecosystem skill config |
| Comment Convention | English by default; bilingual only when explicitly requested |
| Project Structure | Final file tree with descriptions |
| Implementation Order | Table: order, file, dependencies |

### Step Structure

Each step should include:

- **File name** and purpose
- **Constants** — named values with types and descriptions
- **Models** — structured data definitions (ecosystem-appropriate)
- **Interface/Contract** — method signatures for abstractions (ecosystem-appropriate)
- **Implementation sketch** — pseudocode or key logic, not full code
- **Mock implementation** — if the real integration isn't available yet

### Rules

- Order steps by dependency — no forward references
- Every magic value gets a named constant
- Abstract every external integration — always provide a mock
- Include a table mapping step order → file → dependencies
- Design for testability: CLI mode with mock clients, no external services required

## Design Principles

### General (all ecosystems)

- **Interface + Mock pattern** — every external dependency gets an abstraction and a mock, so the system is testable without real services
- **Async by default** — non-blocking I/O to keep event loops responsive
- **Granular control** — prefer per-resource operations over global kill switches
- **No magic values** — extract into named constants or config
- **Incremental delivery** — mock first, wire up real integrations one at a time
- **English comments and output** — code comments, user-facing messages, CLI output, and logs all in English unless bilingual is explicitly requested

### Python Ecosystem

- **Protocol classes** for interfaces — not ABC
- **Pydantic BaseModel** for config, request/response models, and structured data
- **`async/await`** with `asyncio` — `asyncio.gather` for parallel work, `asyncio.create_task` for background work
- **`httpx.AsyncClient`** for HTTP calls
- **Named loggers** via `logging.getLogger("name")` with `%s` formatting
- **`pyproject.toml`** for project metadata, deps, and pyright config
- **`.pylintrc`** per the `python-dev` skill
- **Typing** — `Optional[X]`, lowercase generics, no `Any` without `#FIXME`

### Node.js/TypeScript Ecosystem

- **`interface`** for contracts, `class` for implementations
- **Strict TypeScript** — `strict: true`, `noUncheckedIndexedAccess`, `verbatimModuleSyntax`
- **ESM** — `"type": "module"`, `.ts` extensions in imports
- **Dependency injection** via singleton lazy getter pattern
- **`fetch`** or framework-appropriate HTTP client
- **Structured JSON logging** with metadata objects
- **`package.json`** for metadata, `tsconfig.json` for compiler config
- **ESLint flat config** per the `nodejs-dev` skill
