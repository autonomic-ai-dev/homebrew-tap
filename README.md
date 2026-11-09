# autonomic-ai-dev/homebrew-tap

Official Homebrew tap for Autonomic AI on macOS (Apple Silicon arm64). The tap ships two components: agent-brain and agent-spine.

## Quick start

```bash
brew tap autonomic-ai-dev/tap
brew install agent-brain agent-spine
```

Each formula installs on its own. Install only the one you need.

Update with:

```bash
brew upgrade agent-brain agent-spine
```

## Formulas

| Formula | Description | Provides |
|---------|-------------|----------|
| `agent-brain` | Skills, rules, and memory router for AI coding agents | `agent-brain` |
| `agent-spine` | Deterministic YAML workflow runner | `agent-spine` |

## Maintenance

`scripts/update-formulas.sh` reads the latest agent-brain and agent-spine releases and updates their version and sha256. The `bump-formula` workflow runs it hourly and on `release` dispatches, then commits changes to `Formula/`.
