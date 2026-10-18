# Shared setup notes for autonomic Homebrew formulas.
require "pathname"

module AutonomicSetup
  def self.shadow_warning
    local = Pathname.new(Dir.home)/".local/bin"
    return "" unless (local/"autonomic").exist? || (local/"agent-body").exist?

    <<~EOS

      ⚠  PATH shadow: #{local}/autonomic exists from a prior curl install.
         Your shell will use that copy instead of Homebrew until you remove it:
           rm -f #{local}/{autonomic,agent-body,agent-brain,agent-spine,agent-heart,agent-nerves,agent-muscle,agent-immune,agent-eyes,agent-mouth,agent-tui}
         Or put #{HOMEBREW_PREFIX}/bin before ~/.local/bin in PATH.
    EOS
  end

  def self.finish_setup_caveats(meta_only: false)
    stack = unless meta_only
      <<~EOS

        Stack includes: all organ binaries + nats-server (dependency).
      EOS
    else
      ""
    end

    <<~EOS
      #{stack}
      To finish setup:
        1. Ensure `which autonomic` → #{HOMEBREW_PREFIX}/bin/autonomic (see shadow note above)
        2. autonomic init                 (initialize ~/.autonomic workspace)
        3. agent-brain install --global   (MCP + hooks; copies signed binary to ~/.local/bin on macOS)
        4. Paste ~/.agent_brain/cursor-user-rules.mdc into Cursor Settings → User Rules
        5. Optional: ~/.agent_brain/cursor-agent-brain-mode.mdc (same place) or `agent-brain mode install --global`
        6. autonomic doctor               (verify organs + workspace)
        7. autonomic start                (nerves + heart daemons)

      Meta CLI only: brew install autonomic-ai-dev/tap/autonomic
    EOS
  end
end
