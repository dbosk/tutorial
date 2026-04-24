---
id: shell-basics
title: Shell Basics
summary: Use directories, files, paths, and an editor in the workspace.
---

# Inspect the workspace

```tutorial-step
required_patterns:
  - pwd
  - ls
hint: The shell starts in the tutorial workspace.
```

Run `pwd` and `ls`.

Each tutorial run gets its own workspace. These commands show where your
files for this run will live.

# Create a directory

```tutorial-step
required_patterns:
  - mkdir notes
  - ls
  - notes
hint: Create a directory called `notes`, then list the workspace again.
```

Create a directory named `notes`, then run `ls` again.

The contrast here is between the workspace before and after one directory
is added.

# Create a file in that directory

```tutorial-step
required_patterns:
  - touch notes/todo.md
  - ls notes
  - todo.md
hint: Use `touch` with the nested path `notes/todo.md`.
```

Create `notes/todo.md`, then run `ls notes`.

Keep the same path stem `notes` while changing only what you create:
first a directory, then a file inside it.

# Edit the file

```tutorial-step
edit_file: notes/todo.md
required_patterns:
  - tutorial authoring
  - remember this path
```

Open `notes/todo.md` in your editor and add two short lines:

- `tutorial authoring`
- `remember this path`

Save the file and quit the editor.

The path stays the same, but the interaction changes from shell commands
to an editor-backed step.

# Review the directory and the file

```tutorial-step
required_patterns:
  - ls notes
  - todo.md
  - cat notes/todo.md
  - tutorial authoring
hint: First list the directory, then display the file.
```

Run `ls notes` and `cat notes/todo.md`.

This contrasts two related views: listing a directory tells you which
files exist, while `cat` shows what one file contains.

# Generalise the pattern for tutorial files

```tutorial-step
required_patterns:
  - mkdir my-tutorials
  - touch my-tutorials/demo.md
  - ls my-tutorials
  - demo.md
hint: Repeat the same directory-and-file pattern with new names.
```

Create a directory named `my-tutorials`, create
`my-tutorials/demo.md`, then run `ls my-tutorials`.

Now the names vary, but the path pattern `directory/file.md` stays the
same. That is the pattern the tutorial-authoring lesson will build on.
