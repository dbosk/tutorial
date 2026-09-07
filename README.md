# pytorial

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

The command is installed both as `pytorial` and as the alias
`tutorial`. The examples use `tutorial` because the same spelling also
works when the CLI is embedded as a `tutorial` subcommand inside a
host application.

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

### Trust author-supplied shell code

```
tutorial run --allow-shell <id>
```

A tutorial step may declare `pre_command`, `check_command`, or
`post_command`. Those fields run author-supplied shell code, so they are
opt-in: pass `--allow-shell` only when you trust the tutorial author.
A `workspace: cwd` tutorial combined with `--allow-shell` runs that
shell code in your real project directory rather than in a per-run
workspace, so pass both only for tutorials you wrote or trust completely.

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
- Optional front-matter field: `workspace`, either `fresh` (default) or
  `cwd`. See "Run in your project directory" below.
- Each top-level `# Heading` becomes one step.
- A step may begin with a fenced `tutorial-step` YAML block. Recognised
  fields are `required_patterns`, `pre_command`, `check_command`,
  `post_command`, `hint`, `edit_file`, `kind`, `options`, and `answers`.
- Without `kind` or `edit_file`, a step opens an interactive shell.
- `edit_file` opens a workspace-relative file in `$EDITOR`, falling
  back to `vim`, `vi`, or `nano` when `$EDITOR` is unset.
- `kind: input`, `kind: single_select`, and `kind: multi_select` prompt
  directly in the CLI instead of opening a shell or editor. `input`
  answers use the same string-or-`{mode, pattern}` format as
  `required_patterns`; select questions use literal option text in
  `options` and `answers`.
- `pre_command`, `check_command`, and `post_command` only run when the
  reader passes `--allow-shell`.
- Use one YAML string for each shell field. Multi-line shell scripts
  should use YAML `|` so one bash process sees the whole script and keeps
  `cd`, `export`, and shell options across lines.
- Do not use YAML `>` for shell fields: it folds newlines into spaces and
  can break shell syntax.

### Run in your project directory

A tutorial that scaffolds a workflow in a real project, such as cutting
a release or bootstrapping a repository, can ask to run where the reader
launched it instead of in a fresh per-run workspace:

```markdown
---
id: release-checklist
title: Release Checklist
summary: Walk through a release in this project.
workspace: cwd
---
```

- The CLI prints one line naming the directory before the first step.
- Progress is tracked per directory: `run`, `--restart`, and `list` act
  on the run recorded in the current directory, so the same tutorial in
  two projects keeps two independent runs. Re-enter the same directory
  to resume. `review` still shows the latest run overall; use `--run-id`
  to pick another.
- `--restart` does not clear the directory, so files left by an earlier
  run are still there. Prefer non-destructive `post_command` cleanup in
  these tutorials.
- `tutorial develop` always uses a temporary workspace. Test an in-place
  tutorial with `tutorial run --restart` inside a scratch copy of a
  project.

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
