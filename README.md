# autonomic-ai-dev/homebrew-tap

Official Homebrew tap for the Autonomic AI ecosystem on macOS (Apple Silicon arm64).

## Quick Start

```bash
# Tap the repository
brew tap autonomic-ai-dev/tap

# Install the complete stack (all 10 organs + NATS server)
brew install autonomic-stack

# Or install individual utilities:
brew install autonomic      # Meta CLI & workspace manager
brew install agent-brain    # Cognitive graph, MCP server, durable memory
brew install agent-spine    # Workflow DAG engine & execution controller
brew install agent-heart    # Scheduled GC, token budget gate, heartbeat
brew install agent-nerves   # NATS / JetStream pub-sub event bridge
brew install agent-muscle   # Sandboxed command execution & training backend
brew install agent-immune   # Security scanner & policy enforcer
brew install agent-eyes     # Visual perception & DOM inspector
brew install agent-mouth    # AST command validator & Slack approvals
brew install agent-tui      # Terminal user interface dashboard
```

You can also install directly without tapping first:

```bash
brew install autonomic-ai-dev/tap/autonomic-stack
brew install autonomic-ai-dev/tap/autonomic
brew install autonomic-ai-dev/tap/agent-brain
```

## Available Formulas

| Formula | Description | Provides |
|---------|-------------|----------|
| `autonomic-stack` | Full organ stack + NATS server dependency | Meta-package pulling all 10 organ binaries + `nats-server` |
| `autonomic` | Autonomic ecosystem manager (meta CLI) | `autonomic`, `agent-body` |
| `agent-body` | Alias wrapper pointing to `autonomic` | `agent-body`, `autonomic` |
| `agent-brain` | Local cognitive graph, MCP server & durable memory | `agent-brain` |
| `agent-spine` | Workflow DAG engine & execution controller | `agent-spine` |
| `agent-heart` | Heartbeat monitor, budget gate & GC daemon | `agent-heart` |
| `agent-nerves` | NATS / JetStream pub-sub event bridge | `agent-nerves` |
| `agent-muscle` | Sandboxed execution & training daemon | `agent-muscle` |
| `agent-immune` | Security scanner & policy enforcement | `agent-immune` |
| `agent-eyes` | Visual perception, screen capture & DOM index | `agent-eyes` |
| `agent-mouth` | AST validation, Slack notifications & approvals | `agent-mouth` |
| `agent-tui` | Terminal user interface dashboard | `agent-tui` |

## Post-Install Setup

1. **Verify Homebrew PATH**:
   If you previously installed via `curl | bash`, binaries in `~/.local/bin` may shadow Homebrew:
   ```bash
   rm -f ~/.local/bin/{autonomic,agent-body,agent-brain,agent-spine,agent-heart,agent-nerves,agent-muscle,agent-immune,agent-eyes,agent-mouth,agent-tui}
   which autonomic   # Should point to /opt/homebrew/bin/autonomic
   ```

2. **Initialize Workspace & Daemons**:
   ```bash
   autonomic init               # Initialize ~/.autonomic workspace
   agent-brain install --global # Configure global MCP hooks and editor permissions
   autonomic start              # Launch NATS + nerves + heart daemons
   autonomic doctor             # Health check across organs
   ```
