---
id: writing-tutorials
title: Writing Tutorials
summary: Create a tutorial file, contrast contains and regex matches, and load it.
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

Because this step has no `edit_file` and no metadata fence, the tutorial
runner will open a shell for it.

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
`required_patterns` but still does not add `edit_file`.

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
`edit_file`. In this format, `edit_file` is the switch: without it the
runner starts a shell, and with it the runner opens an editor.

# Test the tutorial you wrote

```tutorial-step
required_patterns:
  - tutorial run --tutorial-path my-tutorials greeting
  - "greeting $"
  - "Step not complete yet: Say hello"
hint: Start `greeting`, then leave its first shell with `exit`.
```

Run `tutorial run --tutorial-path my-tutorials greeting`.

This tests a different aspect from `tutorial list --tutorial-path
my-tutorials`. Listing only proves that the file parses and the tutorial is
discoverable. Running it proves that the authored step actually starts and
uses the expected shell backend.

Keep the tutorial file itself invariant here. Only the command changes: you
now move from inspecting tutorial metadata to exercising the authored
behaviour.

For this step:

1. Run `tutorial run --tutorial-path my-tutorials greeting`.
2. When the nested shell opens with the `greeting $ ` prompt, type `exit`.
3. The nested run should report `Step not complete yet: Say hello`.
4. Exit this lesson's shell too so the transcript is recorded.

# Inspect the finished tutorial

```tutorial-step
required_patterns:
  - tutorial list --tutorial-path my-tutorials
  - greeting
  - cat my-tutorials/greeting.md
  - "  - mode: regex"
  - '    pattern: (?m)echo hello(?:\\s+)?$'
  - "edit_file: hello.txt"
hint: List the tutorials, then display the file you wrote.
```

Run `tutorial list --tutorial-path my-tutorials` and
`cat my-tutorials/greeting.md`.

At this point you have checked the same tutorial in three different ways:

- `tutorial list --tutorial-path my-tutorials` shows that it loads
- `tutorial run --tutorial-path my-tutorials greeting` shows that it runs
- `cat my-tutorials/greeting.md` lets you inspect the final source directly
