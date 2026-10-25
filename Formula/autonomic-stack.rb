require_relative "autonomic_setup"

class AutonomicStack < Formula
  desc "Autonomic AI: agent-brain and agent-spine"
  homepage "https://github.com/autonomic-ai-dev/agent-brain"
  url "https://github.com/autonomic-ai-dev/agent-body/releases/download/v1.0.0-rc1/agent-body-aarch64-apple-darwin"
  version "1.0.0-rc1"
  sha256 "13298a8bc484af76e334ff3c95c4fe5200c5ed2695eb098afa71e96e1cc531cc"
  license "MIT"

  depends_on "autonomic-ai-dev/tap/agent-brain"
  depends_on "autonomic-ai-dev/tap/agent-spine"

  # Minimal source payload for formula requirement

  def install
    odie "autonomic-stack supports macOS Apple Silicon (arm64) only" if !OS.mac? || !Hardware::CPU.arm?

    (bin/"autonomic-stack").write <<~EOS
      #!/usr/bin/env bash
      exec "#{HOMEBREW_PREFIX}/bin/agent-brain" doctor "$@"
    EOS
    chmod 0755, bin/"autonomic-stack"
  end

  def caveats
    AutonomicSetup.shadow_warning + AutonomicSetup.finish_setup_caveats
  end

  test do
    assert_path_exists HOMEBREW_PREFIX/"bin/agent-brain"
    assert_path_exists HOMEBREW_PREFIX/"bin/agent-spine"
  end
end
