---
id: using-tutorials
title: Using Tutorials
summary: Learn how list, run, question prompts, and review fit together.
---

# List the available tutorials

```tutorial-step
required_patterns:
  - tutorial list
  - using-tutorials
  - shell-basics
  - writing-tutorials
hint: Run `tutorial list`.
```

Run `tutorial list`.

In a terminal, `tutorial list` renders a readable table. When the same
command is piped into a script, it switches to tab-separated rows.

Its main job is to show which tutorials are available and how much
progress is already saved for each one.

# Start another tutorial

```tutorial-step
required_patterns:
  - tutorial run --restart shell-basics
  - "shell-basics $"
  - "Step not complete yet: Inspect the workspace"
hint: Start `shell-basics`, then leave its first shell with `exit`.
```

Run `tutorial run --restart shell-basics`.

The `run` command starts or resumes saved work. We use `--restart` here so
this step behaves the same way even if you have already finished
`shell-basics` before.

Because this lesson is already running, the nested shell prompt changes to
`shell-basics $ ` so you can tell which tutorial owns the current shell.

For this step:

1. Run `tutorial run --restart shell-basics`.
2. When the nested shell opens, type `exit`.
3. After the nested command reports that the step is not complete yet,
   exit this outer shell too.

# Retry a shell step

```tutorial-step
required_patterns:
  - "using-tutorials $"
  - pwd
  - ls
hint: First exit after `pwd`, then choose `try again` and run both commands.
```

Now return to this tutorial's own shell.

To feel how step validation works, try this step in two rounds:

1. First run only `pwd`, then exit the shell.
2. The tutorial should say the step is not complete yet.
3. Choose `try again`, run both `pwd` and `ls`, then exit again.

Only the latest recorded attempt counts. If you leave now and come back
later, `tutorial run using-tutorials` resumes from the first unfinished
step unless you restart it.

# Capture the workflow in a file

```tutorial-step
edit_file: tutorial-commands.txt
required_patterns:
  - tutorial list discovers tutorials
  - tutorial run starts or resumes one
  - tutorial review shows saved transcripts
```

Open `tutorial-commands.txt` in your editor and add these three lines:

- `tutorial list discovers tutorials`
- `tutorial run starts or resumes one`
- `tutorial review shows saved transcripts`

Save the file and quit the editor.

This contrasts a shell step with an editor step while keeping the same
validation idea: the tutorial only checks what was recorded after you
finish the step.

# Answer a one-line question

```tutorial-step
kind: input
answers:
  - mode: regex
    pattern: ^tutorial\s+review\s+using-tutorials(?:\s+)?$
hint: Type the full review command for this tutorial.
```

Type the exact command that reviews this tutorial:
`tutorial review using-tutorials`.

This is the smallest question step. The tutorial asks for one line of
text, records it immediately, and validates it without opening a shell.

# Pick the command that starts work

```tutorial-step
kind: single_select
options:
  - tutorial list
  - tutorial run
  - tutorial review
answers:
  - tutorial run
```

Choose the command that starts or resumes one tutorial.

Single-select questions show numbered options. You can answer with the
number or with the full option text.

# Pick every read-only tutorial command

```tutorial-step
kind: multi_select
options:
  - tutorial list
  - tutorial run
  - tutorial review
  - tutorial install
answers:
  - tutorial list
  - tutorial review
hint: Choose the commands that only read tutorial definitions or saved state.
```

Choose every tutorial command here that reads existing information without
starting a run or installing anything.

Multi-select questions also use literal option text. The learner may pick
the correct options in any order, but the tutorial still stores the
authored answer list.

# Review the saved run

```tutorial-step
required_patterns:
  - tutorial review using-tutorials
  - Using Tutorials
  - "Step 1: List the available tutorials"
  - "Step 4: Capture the workflow in a file"
  - "Step 7: Pick every read-only tutorial command"
  - tutorial review shows saved transcripts
hint: Review `using-tutorials` from inside this shell.
```

Run `tutorial review using-tutorials`.

Review reads the saved transcripts for the current run. Because this shell
session is still in progress, the review output can show the earlier saved
steps, but it cannot show this step until after you exit the shell and the
step is recorded.

At this point you have seen the tutorial workflow end to end:

- `tutorial list` discovers what you can run
- `tutorial run` starts or resumes one tutorial at a time
- question steps can ask for input, one choice, or several choices
- `tutorial review` inspects the saved record afterwards
