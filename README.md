# autonomic-ai-dev/homebrew-tap

Official Homebrew tap for Autonomic AI on macOS (Apple Silicon arm64). The tap ships two components: tekmor and agent-spine.

## Quick start

```bash
brew tap autonomic-ai-dev/tap
brew install tekmor agent-spine
```

Each formula installs on its own. Install only the one you need.

Update with:

```bash
brew upgrade tekmor agent-spine
```

## Formulas

| Formula | Description | Provides |
|---------|-------------|----------|
| `tekmor` | Proof eval for coding agents: allowlisted checks, receipts and gates | `tekmor` |
| `agent-spine` | Deterministic YAML workflow runner | `agent-spine` |

## Maintenance

`scripts/update-formulas.sh` reads the latest tekmor and agent-spine releases and updates their version and sha256. The `bump-formula` workflow runs it hourly and on `release` dispatches, then commits changes to `Formula/`.
