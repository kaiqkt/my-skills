# Skill: claude-init

Generates a `CLAUDE.md` file at the project root with structured context for AI-assisted development.

## Usage

```
/claude-init
```

## Behavior

Read the project (source files, build files, folder structure) to infer everything possible before asking the user anything. Only ask for information that cannot be derived from the codebase.

### 1. Collect information

Infer from the codebase:
- Project name (from `build.gradle`, `pom.xml`, `package.json`, `pyproject.toml`, etc.)
- Language and version
- Framework and version
- Database, messaging, infra (from dependencies and docker/compose files)
- Project structure (actual folder layout)
- Architecture conventions (package names, base classes, naming patterns)

Ask the user only for:
- A one-liner describing what the project does (if not in any README or config)
- Key decisions or quirks that are not visible in the code
- Key conventions that are not derivable from the code (e.g., ID strategy, error handling pattern, security approach)

### 2. Check for existing backlog

Check if `docs/backlog/index.md` exists in the project root.

- If it exists: set **Current Focus** to reference it.
- If it does not exist: leave the section with a placeholder.

### 3. Generate CLAUDE.md

Write the file to the project root using the template below. Fill every section with real values — never leave placeholder text for information that was already inferred or collected.

---

## Template

```markdown
# [Project Name]

## What Is This

[One-liner: what this project does]

## Tech Stack

| Layer | Technology |
|---|---|
| Language | [e.g., Java 17] |
| Framework | [e.g., Spring Boot 3] |
| Database | [e.g., PostgreSQL] |
| Messaging | [e.g., Kafka / none] |
| Infra | [e.g., Docker + docker-compose] |

## How to Run

# Install dependencies
[command]

# Run locally
[command]

# Run tests
[command]

# Build
[command]

## Project Structure

[Actual folder tree — inferred from the codebase]

### Architecture

| Layer | Responsibility | May depend on |
|---|---|---|
| `domain` | Pure business rules — entities, interfaces, exceptions | nothing |
| `application` | Orchestrates use cases — controllers, security, config | `domain` only |
| `resources` | Infrastructure — DB, external APIs, file access | `domain` only |

`application` and `resources` never depend on each other. `domain` is completely isolated.

Current package layout:

\```
[fill in actual package layout]
\```

## Key Decisions / Quirks

- [e.g., "We use UUID v7 for all entity IDs"]
- [e.g., "Auth is handled by an external gateway, no auth logic in this service"]
- [e.g., "Legacy /api/v1 endpoints exist — don't modify them"]

## Key Conventions

[List the non-obvious conventions that apply project-wide. Examples:]

- **Entity IDs** — all use ULID (`UlidCreator.getMonotonicUlid().toString()`), stored as `VARCHAR(26)`. Never use UUID.
- **Error handling** — throw `DomainException(ErrorType.SOME_TYPE)`. `ErrorType.message` is auto-derived from the enum name (`EMAIL_ALREADY_EXISTS` → `"email already exists"`). `ErrorHandler` maps each `ErrorType` to an HTTP status.
- **Security** — `AuthenticationFilter` validates Bearer JWT tokens (HS256, nimbus-jose-jwt). Public routes are declared in `AuthenticationFilter.publicRoutes`. Use `SecurityContext.getUserId()` to retrieve the authenticated user's ID inside services. Password hashing uses Argon2 (`PasswordEncrypt.encoder`).
- **Metrics** — inject `MetricsUtils` and call `metricsUtils.counter(name, "status", value)` in services for Prometheus counters.
- **Request tracing** — `WebInterceptor` reads `X-Request-Id` header (or generates a UUID) and puts it in MDC for structured logging.

## Current Focus

> Managed via the `/backlog` skill. See [docs/backlog/index.md](docs/backlog/index.md) for the full task list.

[Summary of what is actively being worked on — update as priorities change]
```

---

### 4. Rules

- Never overwrite an existing `CLAUDE.md` without asking the user first.
- All content must be in English.
- Do not leave unfilled placeholders — if something is unknown, omit the field rather than writing `[fill in]`.
- The **Current Focus** section must always reference `docs/backlog/index.md` if the file exists; otherwise use a plain placeholder.
- After writing the file, confirm to the user what was inferred vs. what was provided manually.
