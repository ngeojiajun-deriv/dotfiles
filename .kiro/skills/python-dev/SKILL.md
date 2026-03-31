---
name: python-dev
description: Style guide and conventions for Python development — Python 3.13, strict typing with Optional, pylint/pyright enforcement, NumPy docstrings, and logging patterns
---

# Python Development Guide

> Also follow the rules in `common-dev` skill.

## Environment
- Python 3.13
- pyright in `standard` mode (`pyproject.toml`)
- pylint with project-level `.pylintrc`

## Typing
- Use `Optional[X]` instead of `X | None` for nullable types
- Use lowercase generics: `dict[str, str]`, `list[int]`, `tuple[str, ...]`
- Avoid `Any`. If the type cannot be deduced, use `Any` temporarily but mark it with `#FIXME` explaining what needs clarification. Ask the user when possible
- Type all function parameters, return values, and non-trivial local variables
- Use `assert isinstance(...)` for runtime type enforcement when needed

## Linter Configuration

### pylint (`.pylintrc`)
```ini
[MASTER]
init-hook='import sys; sys.path.append("..")'

[MESSAGES CONTROL]
enable=all
disable=C0301,E0401,C0413,R0903

[REPORTS]
output-format=text
reports=no
score=no

[BASIC]
good-names=i,j,k,ex,_,id,q

[TYPECHECK]
ignored-modules=datadog_api_client
ignored-classes=datadog_api_client.*
```

Disabled rules:
- `C0301` — line too long (not enforced)
- `E0401` — import errors (some deps may not be locally installed)
- `C0413` — import ordering after `sys.path` manipulation
- `R0903` — too few public methods (common with Pydantic models)

### pyright (`pyproject.toml`)
```toml
[tool.pyright]
typeCheckingMode = "standard"
```

## Lint Suppression
- No serious pylint or pyright issues allowed
- Inline suppression (`# pylint: disable=`, `#nosec`, `#type: ignore`) is permitted but MUST include a justification comment explaining why
- Example:
  ```python
  except Exception as e:  # pylint: disable=broad-exception-caught
      logger.warning("Query failed: %s", e)
  ```
  ```python
  uvicorn.run(app, host="0.0.0.0", port=8001)  #nosec:hardcoded_bind_all_interfaces runs in docker
  ```

## Docstrings
- NumPy-style docstrings
- Module-level docstring on every file
- Single-line docstrings are fine for simple/self-explanatory methods

## Code Organization
- Section separators using `# ---` comment blocks to group related methods
- Module-level constants: `_UPPER_SNAKE` with leading underscore for private
- Use `@staticmethod` for pure functions that don't need instance state
- Private methods: `_method_name`

## Logging
- Use `logging.getLogger("name")` with named loggers
- Use `%s` formatting in log calls (not f-strings) for lazy evaluation

## Style
- f-strings for general string formatting
- Pydantic `BaseModel` for structured request/response models
- `ThreadPoolExecutor` / `concurrent.futures` for parallel I/O
