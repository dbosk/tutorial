# tutorial

A Python library for interactive command-line tutorials.

The project is organised as a literate programming codebase. The committed
sources live in `src/tutorial/*.nw`, and `make` tangles them into generated
Python modules and woven documentation.

Tutorial content itself now lives in Markdown files with YAML front matter.
The example tutorial is in `tutorials/shell-basics.md`.

## Commands

- `make` builds the generated Python, package, tests, and PDF documentation.
- `poetry run tutorial list --tutorial-path tutorials/` lists tutorials from an explicit path.
- `poetry run tutorial run --tutorial-path tutorials/ shell-basics` runs the example tutorial.
- `poetry run tutorial run --tutorial-path tutorials/ --allow-shell-checks shell-basics` enables tutorial-authored shell validation commands.
- `poetry run tutorial review shell-basics` reviews saved transcripts.

## Tutorial Files

- One tutorial lives in one Markdown file.
- The file must start with YAML front matter delimited by `---`.
- Required top-level fields are `id`, `title`, and `summary`.
- Each top-level `# Heading` becomes one tutorial step.
- A step may start with a fenced `tutorial-step` YAML block for `required_patterns`, `check_command`, and `hint`.
- The standalone CLI only loads tutorials from explicit `--tutorial-path` arguments.
- Tutorial-authored `check_command` validation is disabled by default and only runs when `--allow-shell-checks` is passed.

## Layout

- `src/tutorial/`: literate source files and generated package modules
- `tutorials/`: example Markdown tutorials with YAML front matter
- `tests/`: tangled test files generated from the literate sources
- `doc/`: woven project documentation
- `makefiles/`: shared noweb and LaTeX build rules as a git submodule

Run `git submodule update --init --recursive` after cloning so the shared
build rules are available.
