require_relative "autonomic_setup"

class AutonomicStack < Formula
  desc "Autonomic AI: agent-brain and agent-spine"
  homepage "https://github.com/autonomic-ai-dev/agent-brain"
  url "https://github.com/autonomic-ai-dev/agent-brain/releases/download/v1.0.0-rc6/agent-brain-aarch64-apple-darwin"
  version "1.0.0-rc6"
  sha256 "d2c8b938c6ad1fd369daf92f8994e0b02ad0c256dfcb9965cfcdebe0906127c1"
  license "MIT"

  depends_on "autonomic-ai-dev/tap/agent-brain"
  depends_on "autonomic-ai-dev/tap/agent-spine"

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
