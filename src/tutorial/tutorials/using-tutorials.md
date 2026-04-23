---
id: using-tutorials
title: Using Tutorials
summary: Experience retries, editor-backed steps, and workspace review.
---

# Retry a shell step

```tutorial-step
required_patterns:
  - pwd
  - ls
hint: Run both commands before leaving the shell.
```

This step teaches the interaction model, not the commands themselves.

To feel the difference between an incomplete attempt and a complete one,
try it in two rounds:

1. First run only `pwd`, then exit the shell.
2. The tutorial should say the step is not complete yet.
3. Choose `try again`, run both `pwd` and `ls`, then exit again.

The workspace stays the same. The critical change is that the second
attempt contains all the evidence the step asked for.

# Complete an editor step

```tutorial-step
edit_file: retry-note.txt
required_patterns:
  - editor step
  - edited in the tutorial
```

Open `retry-note.txt` in your editor and add two short lines:

- `editor step`
- `edited in the tutorial`

Save the file and quit the editor.

This contrasts a shell step with an editor step while keeping the same
validation idea: the tutorial only checks what was recorded after you
finish the step.

# Review what changed

```tutorial-step
required_patterns:
  - ls
  - cat retry-note.txt
  - edited in the tutorial
hint: List the workspace, then display the file from the previous step.
```

Run `ls` and `cat retry-note.txt`.

You have now seen the two interaction modes side by side:

- shell steps validate what appears in the shell transcript
- editor steps validate what was saved to the edited file

If a future step is blocked, you can read it again, ask for a hint, try
again, or leave and resume later. Different programs may expose these
tutorials under different command names, but this step model stays the
same.
