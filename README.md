# tutorial

A Python library for interactive command-line tutorials.

## Install

```
pipx install pytorial
# or
uv tool install pytorial
```

To run from a clone instead of an installed copy, see
[`CONTRIBUTING.md`](CONTRIBUTING.md).

## Usage

The package ships with three built-in tutorials. The first one is a
self-guided tour of the tool itself:

```
tutorial run using-tutorials
```

Companion tours: `tutorial run shell-basics` (shell and editor skills)
and `tutorial run writing-tutorials` (authoring tutorials of your own).

### Discover what's available

```
tutorial list
```

Pipe the same command into a script to get tab-separated rows instead
of the rich table.

### Run or resume

```
tutorial run <id>              # start or resume saved progress
tutorial run --restart <id>    # discard saved progress and start over
```

### Review past runs

```
tutorial review <id>
tutorial review <id> --step 2
tutorial review <id> --run-id <run-id>
```

### Trust author-supplied shell checks

```
tutorial run --allow-shell-checks <id>
```

A tutorial step may declare a `check_command` that runs in your shell
to validate the step. This validation is opt-in: pass
`--allow-shell-checks` only when you trust the tutorial author.

## Writing tutorials

Take the interactive walkthrough first:

```
tutorial run writing-tutorials
```

### File format

A tutorial is a single Markdown file beginning with YAML front matter:

````markdown
---
id: my-tutorial
title: My Tutorial
summary: One-line description shown by `tutorial list`.
---

# First step

```tutorial-step
required_patterns:
  - some-command
hint: Try running `some-command`.
```

Step body in Markdown.
````

- Required front-matter fields: `id`, `title`, `summary`.
- Each top-level `# Heading` becomes one step.
- A step may begin with a fenced `tutorial-step` YAML block. Recognised
  fields are `required_patterns`, `check_command`, `hint`, `edit_file`,
  `kind`, `options`, and `answers`.
- Without `kind` or `edit_file`, a step opens an interactive shell.
- `edit_file` opens a workspace-relative file in `$EDITOR`, falling
  back to `vim`, `vi`, or `nano` when `$EDITOR` is unset.
- `kind: input`, `kind: single_select`, and `kind: multi_select` prompt
  directly in the CLI instead of opening a shell or editor. `input`
  answers use the same string-or-`{mode, pattern}` format as
  `required_patterns`; select questions use literal option text in
  `options` and `answers`.
- `check_command` only runs when the reader passes
  `--allow-shell-checks`.

### Share and install

Install a tutorial Markdown file or URL into the user's tutorial
directory:

```
tutorial install path/to/tutorial.md
tutorial install https://example.com/tutorial.md
tutorial install --force path/to/tutorial.md
```

Use `--force` to overwrite an installed tutorial with the same `id`.
The standalone CLI auto-loads installed tutorials alongside the
built-ins.

### Load ad hoc

To use a tutorial without installing it, point at the file or directory
on the command line:

```
tutorial list --tutorial-path some/dir
tutorial run --tutorial-path some/dir <id>
```

`--tutorial-path` may be repeated and is appended after the built-ins.

## Embedding the CLI

The package can be mounted as a subcommand inside another Typer or
argparse application via `add_typer_subcommand` and
`add_argparse_subcommand` in `src/pytorial/cli.py`. Embedded hosts
prepend the `using-tutorials` lesson before host-specific tutorials, do
not load the user's installed tutorial directory, and hide the
standalone-only `install` command.

## Contributing

For the literate sources, the `make` build, and the repo layout, see
[`CONTRIBUTING.md`](CONTRIBUTING.md).
