---
id: writing-tutorials
title: Writing Tutorials
summary: Create a tutorial file, add shell, editor, and question steps, and load it.
---

# Create a tutorial directory

```tutorial-step
required_patterns:
  - mkdir my-tutorials
  - ls
  - my-tutorials
hint: Create `my-tutorials`, then list the workspace.
```

Create a directory named `my-tutorials`, then run `ls`.

This lesson keeps the path `my-tutorials/greeting.md` invariant while you
add one tutorial feature at a time.

# Draft the smallest tutorial

```tutorial-step
edit_file: my-tutorials/greeting.md
required_patterns:
  - "id: greeting"
  - "title: Greeting Tutorial"
  - "summary: A tiny tutorial for saying hello."
  - "# Say hello"
  - echo hello
```

Open `my-tutorials/greeting.md` and write this tutorial:

```md
---
id: greeting
title: Greeting Tutorial
summary: A tiny tutorial for saying hello.
---

# Say hello

Run `echo hello`.
```

This is the smallest useful tutorial: front matter plus one top-level
step.

Because this step has no `kind`, no `edit_file`, and no metadata fence,
the tutorial runner will open a shell for it.

# Load the tutorial from disk

```tutorial-step
required_patterns:
  - tutorial list --tutorial-path my-tutorials
  - greeting
hint: Point the standalone CLI at `my-tutorials`.
```

Run `tutorial list --tutorial-path my-tutorials`.

If the file parses, `greeting` should appear in the list.

# Add a contains match

```tutorial-step
edit_file: my-tutorials/greeting.md
required_patterns:
  - "```tutorial-step"
  - "required_patterns:"
  - "  - echo hello"
```

Keep the same tutorial and the same step, but add a metadata fence before
the instructions:

````md
# Say hello

```tutorial-step
required_patterns:
  - echo hello
```

Run `echo hello`.
````

Only one aspect changed: the step now has an explicit validation rule.
It is still a shell step, because the metadata fence adds
`required_patterns` but still does not add `kind` or `edit_file`.

A bare string uses the default `contains` mode. That mode is the best
default because the runner strips ANSI control noise and collapses
whitespace before matching. Small differences such as trailing spaces
from shell completion do not force authors to write regexes.

# Contrast it with a regex match

```tutorial-step
edit_file: my-tutorials/greeting.md
required_patterns:
  - "required_patterns:"
  - "  - mode: regex"
  - '    pattern: (?m)echo hello(?:\\s+)?$'
```

Keep the same tutorial, the same step title, and the same command, but
replace the string rule with an explicit regex rule:

````md
# Say hello

```tutorial-step
required_patterns:
  - mode: regex
    pattern: (?m)echo hello(?:\s+)?$
```

Run `echo hello`.
````

Only one critical aspect changed: the matching mode. The command
`echo hello` stays invariant, while the authored rule changes from a
short normalized contains check to a regex that says more precisely what
part of the transcript should match.

Use regex when you need that extra control. Otherwise, keep the shorter
string form.

# Match shell output with a regex

```tutorial-step
edit_file: my-tutorials/greeting.md
required_patterns:
  - "required_patterns:"
  - "  - mode: regex"
  - "    pattern: (?m)^hello$"
```

Keep the same tutorial file, the same step title, and the same
`echo hello` command, but change the regex so it matches the output line
instead of the command line:

````md
# Say hello

```tutorial-step
required_patterns:
  - mode: regex
    pattern: (?m)^hello$
```

Run `echo hello`.
````

`(?m)` lets `^` and `$` mean line boundaries inside the recorded shell
transcript. That is where regex starts to earn its keep: `contains` can
only say that `hello` appears somewhere, while this rule matches one whole
line of shell output.

# Add an editor-backed step

```tutorial-step
edit_file: my-tutorials/greeting.md
required_patterns:
  - "# Edit a note"
  - "edit_file: hello.txt"
  - hello from the editor
```

Add this second step to the same file:

````md
# Edit a note

```tutorial-step
edit_file: hello.txt
required_patterns:
  - hello from the editor
```

Open `hello.txt` and add `hello from the editor`.
````

This now contrasts two different step backends in the same tutorial: a
shell step with explicit matching metadata and an editor-backed step with
`edit_file`. `edit_file` still selects the editor backend, while question
steps use `kind`. `edit_file` and `kind` are mutually exclusive, so
combining them is a parse-time error.

# Add an input question

```tutorial-step
edit_file: my-tutorials/greeting.md
required_patterns:
  - "# Type the greeting"
  - "kind: input"
  - "answers:"
  - "  - mode: regex"
  - "    pattern: (?i)hello(?:\\s+)?$"
```

Add this third step to the same file:

````md
# Type the greeting

```tutorial-step
kind: input
answers:
  - mode: regex
    pattern: (?i)hello(?:\s+)?$
```

Type `hello`.
````

Input questions reuse the same string-or-regex answer format as
`required_patterns`. Only the interaction kind changes: the runner now
prompts for one line of text instead of opening a shell or editor.

# Add a single-select question

```tutorial-step
edit_file: my-tutorials/greeting.md
required_patterns:
  - "# Pick the shell command"
  - "kind: single_select"
  - "options:"
  - "  - echo hello"
  - "  - pwd"
  - "  - ls"
  - "answers:"
  - "  - echo hello"
```

Add this fourth step to the same file:

````md
# Pick the shell command

```tutorial-step
kind: single_select
options:
  - echo hello
  - pwd
  - ls
answers:
  - echo hello
```

Choose the command that prints the greeting.
````

Single-select questions use literal option text. The learner may answer by
number or by the full option, but the authored answer stays the option
text itself.

# Add a multi-select question

```tutorial-step
edit_file: my-tutorials/greeting.md
required_patterns:
  - "# Pick every inspection command"
  - "kind: multi_select"
  - "options:"
  - "  - pwd"
  - "  - ls"
  - "  - echo hello"
  - "answers:"
  - "  - pwd"
  - "  - ls"
```

Add this fifth step to the same file:

````md
# Pick every inspection command

```tutorial-step
kind: multi_select
options:
  - pwd
  - ls
  - echo hello
answers:
  - pwd
  - ls
```

Choose every command that inspects the workspace.
````

Multi-select questions also use literal YAML lists. The learner may choose
the correct options in any order, but authors still list the correct
option texts explicitly under `answers`.

# Add a shell check to the editor step

```tutorial-step
edit_file: my-tutorials/greeting.md
required_patterns:
  - "check_command:"
  - 'test "$(cat hello.txt)" = "hello from the editor"'
```

Keep the same `# Edit a note` step, but add a filesystem-based shell check:

````md
# Edit a note

```tutorial-step
edit_file: hello.txt
required_patterns:
  - hello from the editor
check_command: test "$(cat hello.txt)" = "hello from the editor"
```

Open `hello.txt` and add `hello from the editor`.
````

`check_command` is opt-in. The runner refuses to execute it unless the
reader passes `--allow-shell-checks`. It runs in a separate
`/bin/bash -lc` process with the tutorial workspace as its current
directory, so it can inspect files there but it does not inherit shell
variables or other session state from the interactive step. It is also
AND-ed with `required_patterns`: both checks must pass before the step
completes.

# Test the tutorial you wrote

```tutorial-step
required_patterns:
  - tutorial run --tutorial-path my-tutorials greeting
  - "greeting $"
  - "Step not complete yet: Say hello"
hint: Start `greeting`, then leave its first shell with `exit`.
```

Run `tutorial run --tutorial-path my-tutorials greeting`.

This still tests a different aspect from `tutorial list --tutorial-path
my-tutorials`. Listing only proves that the file parses and the tutorial is
discoverable. Running it proves that the authored tutorial still starts
with the expected shell backend even after you add editor and question
steps later in the file.

Keep the tutorial file itself invariant here. Only the command changes: you
now move from inspecting tutorial metadata to exercising the authored
behaviour.

For this step:

1. Run `tutorial run --tutorial-path my-tutorials greeting`.
2. When the nested shell opens with the `greeting $ ` prompt, type `exit`.
3. The nested run should report `Step not complete yet: Say hello`.
4. Exit this lesson's shell too so the transcript is recorded.

# Iterate on one step with `tutorial develop`

```tutorial-step
required_patterns:
  - tutorial develop --tutorial-path my-tutorials greeting 1
  - "greeting $"
  - "Verdict: FAIL"
hint: Start develop for step 1, exit immediately, then keep the FAIL verdict and stop.
```

Run `tutorial develop --tutorial-path my-tutorials greeting 1`.

For this step:

1. Run `tutorial develop --tutorial-path my-tutorials greeting 1`.
2. When the temporary `greeting $ ` shell opens, type `exit` immediately.
3. Answer yes when `tutorial develop` asks whether the `FAIL` verdict is
   correct.
4. Answer no when it asks whether to run the step again.

`tutorial develop` exercises one authored step in a temporary workspace,
prints `PASS` or `FAIL`, and lets you edit and re-run that step without
restarting the whole tutorial. We point at step `1` by number here, but the
same command also accepts a regex that matches the step title. Develop also
enables shell checks by default; pass `--deny-shell-checks` to turn them
off for one session.

# Inspect the finished tutorial

```tutorial-step
required_patterns:
  - tutorial list --tutorial-path my-tutorials
  - greeting
  - cat my-tutorials/greeting.md
  - "    pattern: (?m)^hello$"
  - "kind: input"
  - "kind: single_select"
  - "kind: multi_select"
  - "edit_file: hello.txt"
  - 'check_command: test "$(cat hello.txt)" = "hello from the editor"'
  - "    pattern: (?i)hello(?:\\s+)?$"
hint: List the tutorials, then display the file you wrote.
```

Run `tutorial list --tutorial-path my-tutorials` and
`cat my-tutorials/greeting.md`.

At this point you have checked the same tutorial in three different ways:

- `tutorial list --tutorial-path my-tutorials` shows that it loads
- `tutorial run --tutorial-path my-tutorials greeting` shows that it runs
- `cat my-tutorials/greeting.md` lets you inspect the final shell, editor,
  shell-check, and question metadata directly
