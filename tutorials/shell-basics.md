---
id: shell-basics
title: Shell Basics
summary: Inspect the workspace, create a file, and review what you did.
---

# Inspect the workspace

```tutorial-step
required_patterns:
  - pwd
  - ls
hint: The shell starts in the tutorial workspace.
```

Run `pwd` and `ls`.

This shows where the tutorial stores its work for this run.

# Create a note

```tutorial-step
check_command: test -f notes.txt && grep -q tutorial notes.txt
hint: Any command sequence is fine if `notes.txt` exists afterwards.
```

Create `notes.txt` containing the word `tutorial`.

One way is:

`printf 'tutorial\n' > notes.txt`

# Review the note

```tutorial-step
required_patterns:
  - cat notes.txt
  - tutorial
check_command: grep -q tutorial notes.txt
```

Display the file with `cat notes.txt`.

The transcript should show both the command and the file contents.
