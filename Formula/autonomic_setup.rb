# Shared setup notes for autonomic Homebrew formulas.

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

  def self.finish_setup_caveats
    <<~EOS

      To finish setup:
        1. agent-brain install --global   (MCP + hooks for supported editors)
        2. agent-brain doctor             (verify the install)
        3. agent-spine init               (set up agent-spine)
        4. Optional: export AUTONOMIC_NATS_URL to publish agent-spine events to NATS
    EOS
  end
end
