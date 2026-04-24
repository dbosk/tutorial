# tutorial

A Python library for interactive command-line tutorials.

The project is organised as a literate programming codebase. The committed
sources live in `src/tutorial/*.nw`, and `make` tangles them into generated
Python modules and woven documentation.

Tutorial content itself now lives in Markdown files with YAML front matter.
Packaged built-ins live in `src/tutorial/tutorials/`, and the repo also keeps
local example content in `tutorials/`.

## Commands

- `poetry run tutorial` shows the CLI help.
- `make` builds the generated Python, package, tests, and PDF documentation.
- `poetry run tutorial list` lists the packaged built-in tutorials.
- `poetry run tutorial install /path/to/tutorial.md` installs a tutorial in the user's tutorial directory.
- `poetry run tutorial install https://example.com/tutorial.md` installs a tutorial from a URL.
- `poetry run tutorial install --force /path/to/tutorial.md` overwrites an installed tutorial with the same tutorial ID.
- `poetry run tutorial run using-tutorials` runs the universal usage tutorial, including shell, editor, and question steps.
- `poetry run tutorial run shell-basics` runs the built-in shell and editor skills tutorial.
- `poetry run tutorial run writing-tutorials` runs the built-in authoring tutorial.
- `poetry run tutorial list --tutorial-path /path/to/more-tutorials` appends extra tutorials after the built-ins.
- `poetry run tutorial review using-tutorials` reviews saved transcripts.

## Tutorial Files

- One tutorial lives in one Markdown file.
- The file must start with YAML front matter delimited by `---`.
- Required top-level fields are `id`, `title`, and `summary`.
- Each top-level `# Heading` becomes one tutorial step.
- A step may start with a fenced `tutorial-step` YAML block for `required_patterns`, `check_command`, `hint`, `edit_file`, `kind`, `options`, and `answers`.
- Steps without `kind` or `edit_file` open a shell.
- `edit_file` opens a workspace-relative file in `$EDITOR`; if `$EDITOR` is unset, the runner falls back to `vim`, `vi`, or `nano` when available.
- `kind: input`, `kind: single_select`, and `kind: multi_select` prompt directly in the CLI instead of opening a shell or editor.
- `input` answers use the same string-or-`{mode, pattern}` format as `required_patterns`; select questions use literal option text in `options` and `answers`.
- The standalone CLI auto-loads the packaged built-ins.
- The standalone CLI also auto-loads tutorials installed in the user's tutorial directory.
- Extra `--tutorial-path` values are appended after the built-ins.
- Embedded hosts prepend the universal `using-tutorials` lesson before host-specific tutorials and do not load the user's installed tutorial directory.
- The standalone-only `install` command is not exposed when `tutorial` is mounted as a subcommand inside another Typer or argparse app.
- Tutorial-authored `check_command` validation is disabled by default and only runs when `--allow-shell-checks` is passed.

## Layout

- `src/tutorial/`: literate source files and generated package modules
- `src/tutorial/tutorials/`: packaged built-in Markdown tutorials
- `tutorials/`: repo-local example Markdown tutorials with YAML front matter
- `tests/`: tangled test files generated from the literate sources
- `doc/`: woven project documentation
- `makefiles/`: shared noweb and LaTeX build rules as a git submodule

Run `git submodule update --init --recursive` after cloning so the shared
build rules are available.
