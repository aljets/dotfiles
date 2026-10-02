---
name: keep
description: Bookmark the current session by appending its ID, date, directory, and a one-line description to ~/notes/sessions.md.
argument-hint: "[description]"
disable-model-invocation: true
---

Append one line for this session to `~/notes/sessions.md`, creating the file with a `# Sessions` heading if it doesn't exist.

Line format:

```
- YYYY-MM-DD · <description> · <cwd with $HOME as ~> · `claude --resume ${CLAUDE_SESSION_ID}`
```

Description: use `$ARGUMENTS` if given. Otherwise write a terse phrase (under 10 words) naming what this session worked on, including a Jira ticket if one came up.

Use a single Bash append (`>>`). Don't rewrite or reorder existing lines. Reply with only the line you added.
