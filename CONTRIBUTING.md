# Contributing to `tutorial`

The project is organised as a literate-programming codebase. Committed
sources live in `src/tutorial/*.nw`; `make` tangles them into the Python
modules used at runtime and weaves them into LaTeX/PDF documentation.

## First-time setup

```
git submodule update --init --recursive
poetry install
```

The submodule provides the shared noweb and LaTeX build rules in
`makefiles/`.

## Build commands

```
make                    # tangle, build wheel, run tests, weave PDF
make compile            # tangle Python and build the wheel
make test               # run the tangled test suite
make doc/tutorial.pdf   # weave the documentation PDF
make distclean          # remove build/, dist/, and *.egg-info
```

To run the CLI from a clone without installing the wheel, use
`poetry run tutorial …` in place of the bare `tutorial` invocations
shown in [`README.md`](README.md).

## Repo layout

- `src/tutorial/`: literate source files and generated package modules
- `src/tutorial/tutorials/`: packaged built-in Markdown tutorials
- `tutorials/`: repo-local example Markdown tutorials with YAML front matter
- `tests/`: tangled test files generated from the literate sources
- `doc/`: woven project documentation
- `makefiles/`: shared noweb and LaTeX build rules as a git submodule
