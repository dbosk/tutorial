# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Literate programming — read before editing

Source of truth lives in `.nw` files. The `.py`, `.md`, and `.tex` files
under `src/pytorial/` (including `src/pytorial/tutorials/`) are
**generated** by `notangle` and will be overwritten by `make`. Edit the
matching `.nw` file and re-run `make compile`.

Mapping:

- `src/pytorial/<name>.py` ← `src/pytorial/<name>.nw` (chapters: `tutorial`, `model`, `catalog`, `state`, `shell`, `run`, `cli`)
- `src/pytorial/tutorials/<name>.md` ← `src/pytorial/tutorials/<name>.nw`
- `tests/unit/test_<name>.py` ← `<<test [[<name>.py]]>>` chunks inside `src/pytorial/*.nw` (tangled by `tests/Makefile`)
- `doc/tutorial.pdf` ← `doc/tutorial.nw` + each chapter's woven `.tex`

The `literate-programming` skill must be activated before editing any `.nw`
file.

## First-time setup

```
git submodule update --init --recursive   # pulls makefiles/ (shared noweb + LaTeX rules)
poetry install
```

The `makefiles/` submodule is required — without it the top-level
`Makefile` cannot resolve `noweb.mk` / `tex.mk` / `subdir.mk`.

## Common commands

```
make                      # tangle, build wheel, run tests, weave PDF (default goal)
make compile              # tangle Python + build the wheel only
make test                 # tangle test files, then poetry run pytest -v
make doc/tutorial.pdf     # weave the documentation PDF
make distclean            # remove build/, dist/, *.egg-info
```

Run a single test after `make compile` and `make -C tests all`:

```
poetry run pytest tests/unit/test_run.py -v
poetry run pytest tests/unit/test_run.py::test_runs_a_shell_step -v
```

`make test` re-tangles before invoking `pytest`, so editing a `.nw` test
chunk and running `make test` is the canonical loop.

Run the CLI from the clone (without installing the wheel):

```
poetry run tutorial run using-tutorials
```

## Architecture (big picture)

The package surface is intentionally narrow and re-exported from
`src/pytorial/__init__.py`. Layering, lowest to highest:

- `model.py` — frozen `@dataclass` definitions: `Tutorial`, `TutorialStep`,
  `TutorialRun`, `StepTranscript`, `TextMatch`. Pure data, no I/O.
- `catalog.py` — `TutorialCatalog` plus `get_tutorial` / `get_tutorials`.
  Loads Markdown tutorials with YAML front matter from the packaged
  `src/pytorial/tutorials/` and the user's installed tutorial directory.
- `state.py` — `StateStore` / `ProgressState`. Persists per-tutorial run
  progress and transcripts under `platformdirs` user state directory.
- `shell.py` — `run_interactive_shell` / `run_scripted_shell`. PTY-backed
  step execution; this is what makes the tutorials "interactive".
- `run.py` — `TutorialRunner`, `RunResult`. Orchestrates one tutorial:
  iterates steps, invokes the shell/editor/select/input handler for each
  `step_kind`, gates author-supplied `pre_command` / `check_command` /
  `post_command` behind `--allow-shell`, and writes transcripts via the
  state store. Standalone `tutorial run` defaults that flag off, while
  embedded CLI helpers default it on for trusted bundled tutorials.
- `cli.py` — Typer app exposing `tutorial list / run / review / install`,
  plus `create_app`, `add_typer_subcommand`, `add_argparse_subcommand` so
  the CLI can be embedded as a subcommand inside another Typer or
  argparse application.

Embedded hosts (`add_typer_subcommand` / `add_argparse_subcommand`)
prepend the `using-tutorials` lesson before host-specific tutorials, do
not load the user's installed tutorial directory, and hide the
standalone-only `install` command.

## Tutorial format (authoring)

A tutorial is a single Markdown file with YAML front matter
(`id`, `title`, `summary` required). Each top-level `# Heading` becomes
one step. A step may begin with a fenced ```` ```tutorial-step ```` YAML
block; recognised fields are `required_patterns`, `pre_command`,
`check_command`, `post_command`, `hint`, `edit_file`, `kind`, `options`,
`answers`. `pre_command` / `check_command` / `post_command` only execute
when the reader passes `--allow-shell`. Use YAML `|` (not `>`) for
multi-line shell so newlines survive into one bash process.

Built-in tutorials: `using-tutorials`, `shell-basics`, `writing-tutorials`.
Repo-local example: `tutorials/shell-basics.md`.

## Conventions

- Python ≥ 3.10 (uses `from __future__ import annotations`, `X | Y` types,
  PEP 604 unions). Poetry-managed; runtime deps are `platformdirs`,
  `PyYAML`, `rich`, `typer`.
- Black target version is `py310`.
- Bumping the package version: edit `version` in `pyproject.toml`; the
  top-level `Makefile` reads it for `gh release create`.
- `make publish` runs `poetry publish` and `gh release create` against
  the version string from `pyproject.toml`.
