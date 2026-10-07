---
name: keep
description: Bookmark the current session by appending its date, description, directory, and a resume command to ~/notes/sessions.md.
argument-hint: "[description]"
disable-model-invocation: true
---

Append an entry for this session to `~/notes/sessions.md`, creating the file with a `# Sessions` heading if it doesn't exist.

Entries are grouped under one `## YYYY-MM-DD` heading per day. If the last `## ` heading in the file isn't today's date, write today's heading first.

Entry format (blank line before the heading and before the entry):

````
## YYYY-MM-DD

### <description>
<cwd with $HOME as ~>

```sh
cd <cwd with $HOME as ~> && claude --resume ${CLAUDE_SESSION_ID}
```
````

The fenced block gets a copy button in Obsidian, so the restore command can be pasted as is.

Description: use `$ARGUMENTS` if given. Otherwise write a terse phrase (under 10 words) naming what this session worked on, including a Jira ticket if one came up.

Use Bash appends (`>>`). Don't rewrite or reorder existing entries. Reply with only the description and the restore command.
