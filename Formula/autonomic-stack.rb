require_relative "autonomic_setup"

class AutonomicStack < Formula
  desc "Full Autonomic AI organ stack (all peripheral binaries + NATS server)"
  homepage "https://github.com/autonomic-ai-dev/agent-body"
  version "1.0.0-beta.3.2"
  license "MIT"

  depends_on "nats-server"
  depends_on "autonomic-ai-dev/tap/autonomic"
  depends_on "autonomic-ai-dev/tap/agent-brain"
  depends_on "autonomic-ai-dev/tap/agent-spine"
  depends_on "autonomic-ai-dev/tap/agent-heart"
  depends_on "autonomic-ai-dev/tap/agent-nerves"
  depends_on "autonomic-ai-dev/tap/agent-muscle"
  depends_on "autonomic-ai-dev/tap/agent-immune"
  depends_on "autonomic-ai-dev/tap/agent-eyes"
  depends_on "autonomic-ai-dev/tap/agent-mouth"
  depends_on "autonomic-ai-dev/tap/agent-tui"

  # Minimal source payload for formula requirement
  url "https://github.com/autonomic-ai-dev/agent-body/releases/download/v1.0.0-beta.3.1/agent-body-aarch64-apple-darwin"
  sha256 "4f068d07d5003bd399806b3e802b51aae2392903d7e7b64afe8ba1123a5a8813"

  def install
    odie "autonomic-stack supports macOS Apple Silicon (arm64) only" if !OS.mac? || !Hardware::CPU.arm?

    (bin/"autonomic-stack").write <<~EOS
      #!/usr/bin/env bash
      exec "#{HOMEBREW_PREFIX}/bin/autonomic" status "$@"
    EOS
    chmod 0755, bin/"autonomic-stack"
  end

  def post_install
    AutonomicSetup.run_workspace_init(self)
  end

  def caveats
    AutonomicSetup.shadow_warning + AutonomicSetup.finish_setup_caveats(meta_only: false)
  end

  test do
    assert_predicate HOMEBREW_PREFIX/"bin/autonomic", :exist?
    assert_predicate HOMEBREW_PREFIX/"bin/agent-brain", :exist?
    assert_predicate HOMEBREW_PREFIX/"bin/agent-spine", :exist?
  end
end
