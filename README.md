# claude-picker

A session picker for [Claude Code](https://claude.ai/code) that intercepts the `claude` command and lets you resume a previous session or start a new one — across all your projects.

```
  Proyectos de Claude

  #   Última sesión   Ses.  Nombre                        Directorio
  ────────────────────────────────────────────────────────────────────────
  n   nuevo proyecto                                      ~/my-new-app
  ────────────────────────────────────────────────────────────────────────
  1   17 May 10:14    3     claude-picker                 ~/claude-picker
  2   16 May 18:41    5     Setup Ubuntu timon            ~/
  3   16 May 12:23    9     Trip planner Next.js          ~/tripplanner
  ──────────────────────────────────────────────
  r   Renombrar proyecto   q   Cancelar

  Elige proyecto [1-3/r/q/n]:
```

## Features

- **Two-level picker**: choose project first, then session
- **Smart current directory**: if you run `claude` in a directory with no prior sessions, it appears at the top as a quick-start entry (`n`)
- **AI-generated summaries** for each session (cached, generated via `claude -p --model haiku`)
- **AI-generated project names** (on demand, cached)
- **Rename** projects and sessions — pick from AI suggestions or type manually
- **Move** sessions between projects
- **Stale project filtering**: projects whose directories no longer exist are automatically hidden
- No extra dependencies — pure Python 3.10+, uses your existing `claude` CLI

## Requirements

- Python 3.10+
- [Claude Code CLI](https://docs.anthropic.com/claude-code) installed and authenticated
- zsh

## Installation

```bash
git clone https://github.com/yourusername/claude-picker.git
cd claude-picker
bash install.sh
source ~/.zshrc
```

The installer copies `claude-picker` to `~/.local/bin/` and adds the shell wrapper to `~/.zshrc`.

## Usage

Just type `claude` with no arguments. The picker appears automatically.

```
claude          # shows the picker
claude -p ...   # passes through directly, no picker
```

### Session picker keys

| Key | Action |
|-----|--------|
| `1`–`5` | Resume that session |
| `n` | New session in this project |
| `m` | Move a session — prompted for which one, then pick target project |
| `r` | Rename a session — prompted for which one, then choose AI suggestion or type manually |
| `b` | Back to project picker |
| `q` | Cancel |

### Project picker keys

| Key | Action |
|-----|--------|
| `1`–`9` | Open that project |
| `n` | Start a new session in the current directory (shown when it has no prior sessions) |
| `r` | Rename a project |
| `q` | Cancel |

## Cache

AI-generated names are cached in `~/.cache/claude-picker/`. Delete files there to regenerate them.

## Project names

Project names are not generated at startup to keep it fast. They are generated on demand when you use `r` (rename) in the project picker — you can accept one of the AI suggestions or type your own.

## License

MIT
