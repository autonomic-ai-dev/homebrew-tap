# autonomic-ai-dev/homebrew-tap

Homebrew tap for the Autonomic AI stack on macOS.

## Tap naming (must match GitHub)

| What you type | GitHub repository required |
|---------------|----------------------------|
| `brew tap autonomic-ai-dev/tap` | **`autonomic-ai-dev/homebrew-tap`** |

Homebrew strips the `homebrew-` prefix: repo `homebrew-tap` → tap slug `autonomic-ai-dev/tap`.  
If the GitHub repo is named anything else (e.g. `homebrew-autonomic`), use:

```bash
brew tap autonomic-ai-dev/tap https://github.com/autonomic-ai-dev/homebrew-tap
```

## Install

```bash
brew tap autonomic-ai-dev/tap
brew install autonomic          # meta CLI only (agent-body + autonomic symlink)
brew install autonomic-stack    # all organ binaries + nats-server dependency
```

Fully qualified (without tapping first):

```bash
brew install autonomic-ai-dev/tap/autonomic
brew install autonomic-ai-dev/tap/autonomic-stack
```

## Formulas

| Formula | Installs |
|---------|----------|
| `autonomic` | `agent-body` + `autonomic` symlink |
| `autonomic-stack` | All nine organ release binaries + `depends_on nats-server` |

Release assets match `install-all-organs.sh`:

- **`autonomic`**: pinned `agent-body` tag `v{version}` → `{binary}-{arch}-apple-darwin`
- **`autonomic-stack`**: each organ from that repo's **`/releases/latest/download/`** (organs version independently)

Linux: use the [curl install script](https://github.com/autonomic-ai-dev/agent-body/blob/master/scripts/install-all-organs.sh).

## Migrating from curl

If you previously ran `install-all-organs.sh`, binaries live in `~/.local/bin` and **shadow** Homebrew on `PATH`. After `brew install autonomic-stack`:

```bash
rm -f ~/.local/bin/{autonomic,agent-body,agent-brain,agent-spine,agent-heart,agent-nerves,agent-muscle,agent-immune,agent-eyes,agent-mouth}
which autonomic   # expect /opt/homebrew/bin/autonomic
```

## What Homebrew sets up vs manual steps

| Step | Homebrew | You |
|------|----------|-----|
| Organ binaries | ✓ | |
| `nats-server` (stack formula) | ✓ | |
| `~/.autonomic` workspace (`autonomic init`) | ✓ if missing | |
| Cursor MCP + hooks | | `agent-brain install --global` |
| Daemon start | | `autonomic start` |
| Full health check | | `autonomic doctor` |

## Formula version bumps

The tap tracks **agent-body** release version in both formulas (`autonomic` pins that tag; `autonomic-stack` uses it for metadata but each organ binary still comes from `/releases/latest/download/`).

| Trigger | Workflow |
|---------|----------|
| Hourly poll | [bump-formula.yml](.github/workflows/bump-formula.yml) compares latest `agent-body` GitHub release |
| Manual | Actions → **Bump formula versions** → optional version input |
| On agent-body release | Optional: set `HOMEBREW_TAP_DISPATCH_TOKEN` in agent-body repo secrets (PAT with `repo` on this tap) |

Local bump:

```bash
./scripts/bump-version.sh 0.5.12
```

Formulas download GitHub **release binaries**, not source builds. Bump `version` in both `.rb` files when cutting a new stack release.
