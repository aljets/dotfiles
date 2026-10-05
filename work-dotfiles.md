Work dotfiles
=============

Per-employer config lives in a private repo at `~/repos/dotfiles`, pushed
somewhere private at the employer. It holds internal hosts, endpoints, tokens,
and tool names. Anything not specific to the employer belongs in this repo.

Personal config reads these paths; each is optional:

| File | Read by |
|---|---|
| `.gitconfig_work` | `includeIf "gitdir:~/repos/"` in `.gitconfig` |
| `.work_fish_config` | `fish/config.fish` |
| `ansible/AGENTS.work.md` | import in `agents/AGENTS.md` |
| `ansible/vars.yml` | `claude_extra_vars` in dev-machine-tools |

`.private_fish_config` is only read from `.work_fish_config`.

## `.gitignore`

```
.private_fish_config
```

## `.gitconfig_work`

```gitconfig
[user]
    email = <you>@<company>.com
```

## `.work_fish_config`

```fish
# Work env vars and functions
source ~/repos/dotfiles/.private_fish_config
```

## `.private_fish_config`

Tokens. Gitignored, so create it by hand on each machine.

```fish
set -x <SERVICE>_TOKEN <token>
```

## `ansible/AGENTS.work.md`

```markdown
# Tools

* Jira tickets look like `<PROJ>-1234`
```

## `ansible/vars.yml`

Every key is optional.

```yaml
# Claude Code permissions merged into ~/.claude/settings.json
private_allowed_tools: []

# Symlinked like dotfiles_files; `file` is an absolute path
private_dotfiles_files: []
#  - {file: '~/repos/dotfiles/ansible/.aws_config', dest: ~/.aws/config}
#  - {file: '~/repos/dotfiles/ansible/.databrickscfg', dest: ~/.databrickscfg}
#  - {file: '~/repos/dotfiles/ansible/.ssh_config', dest: ~/.ssh/config}


# Arguments to `claude mcp add --transport http --scope user`
private_mcp_servers: []
#  - <name> https://<host>/mcp

private_claude_plugin_marketplaces: []
private_claude_plugins: []

# Work notes vault cloned to ~/notes, overriding the personal one
#notes_repo: git@<host>:<you>/notes.git
```
