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

Formulas download GitHub **release binaries**, not source builds. Bump `version` in both `.rb` files when cutting a new stack release.
