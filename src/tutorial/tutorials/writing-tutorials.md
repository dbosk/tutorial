---
id: writing-tutorials
title: Writing Tutorials
summary: Create a tutorial file, add step metadata, and load it.
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

Because this step has no `edit_file`, the tutorial runner will open a
shell for it.

# Load the tutorial from disk

```tutorial-step
required_patterns:
  - tutorial list --tutorial-path my-tutorials
  - greeting
hint: Point the standalone CLI at `my-tutorials`.
```

Run `tutorial list --tutorial-path my-tutorials`.

If the file parses, `greeting` should appear in the list.

# Add shell-step metadata

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

This keeps the tutorial file invariant while contrasting a shell step with
an editor-backed step. In this format, `edit_file` is the switch: without
it the runner starts a shell, and with it the runner opens an editor.

# Inspect the finished tutorial

```tutorial-step
required_patterns:
  - tutorial list --tutorial-path my-tutorials
  - greeting
  - cat my-tutorials/greeting.md
  - "edit_file: hello.txt"
hint: List the tutorials, then display the file you wrote.
```

Run `tutorial list --tutorial-path my-tutorials` and
`cat my-tutorials/greeting.md`.

After this lesson ends, try `tutorial run --tutorial-path my-tutorials
greeting` from your normal shell to run the tutorial you just wrote.
