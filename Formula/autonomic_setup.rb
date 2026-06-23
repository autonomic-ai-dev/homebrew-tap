# Shared setup notes for autonomic Homebrew formulas.
module AutonomicSetup
  def self.shadow_warning
    local = Dir.home/".local/bin"
    return "" unless (local/"autonomic").exist? || (local/"agent-body").exist?

    <<~EOS

      ⚠  PATH shadow: #{local}/autonomic exists from a prior curl install.
         Your shell will use that copy instead of Homebrew until you remove it:
           rm -f #{local}/{autonomic,agent-body,agent-brain,agent-spine,agent-heart,agent-nerves,agent-muscle,agent-immune,agent-eyes,agent-mouth}
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
      What Homebrew runs automatically:
        • `autonomic init` when ~/.autonomic does not exist

      Finish setup manually:
        1. Ensure `which autonomic` → #{HOMEBREW_PREFIX}/bin/autonomic (see shadow note above)
        2. agent-brain install --global   (MCP + hooks; copies signed binary to ~/.local/bin on macOS)
        3. Paste ~/.agent_brain/cursor-user-rules.mdc into Cursor Settings → User Rules
        4. Optional: ~/.agent_brain/cursor-agent-brain-mode.mdc (same place) or `agent-brain mode install --global`
        5. autonomic doctor               (verify organs + workspace)
        6. autonomic start                (nerves + heart daemons)

      Meta CLI only: brew install autonomic-ai-dev/tap/autonomic
    EOS
  end

  def self.run_workspace_init(bin)
    workspace = Dir.home/".autonomic"
    return if workspace.directory?

    cli = bin/"autonomic"
    unless cli.exist?
      opoo "autonomic binary missing; run `agent-body init` after install."
      return
    end

    ohai "Initializing Autonomic workspace at #{workspace}"
    if quiet_system(cli, "init")
      ohai "Workspace ready: #{workspace}"
    else
      opoo <<~EOS
        autonomic init exited non-zero (formula install succeeded).
        Finish setup manually: #{cli} init
      EOS
    end
  end
end
