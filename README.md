# tutorial

A Python library for interactive command-line tutorials.

The project is organised as a literate programming codebase. The committed
sources live in `src/tutorial/*.nw`, and `make` tangles them into generated
Python modules and woven documentation.

## Commands

- `make` builds the generated Python, package, tests, and PDF documentation.
- `poetry run tutorial list` lists the built-in tutorials.
- `poetry run tutorial run shell-basics` runs the example tutorial.
- `poetry run tutorial review shell-basics` reviews saved transcripts.

## Layout

- `src/tutorial/`: literate source files and generated package modules
- `tests/`: tangled test files generated from the literate sources
- `doc/`: woven project documentation
- `makefiles/`: shared noweb and LaTeX build rules as a git submodule

Run `git submodule update --init --recursive` after cloning so the shared
build rules are available.
