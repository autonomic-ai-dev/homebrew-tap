require_relative "autonomic_setup"

class Autonomic < Formula
  desc "Ecosystem manager (meta CLI) for Autonomic AI"
  homepage "https://github.com/autonomic-ai-dev/agent-body"
  version "1.0.0-beta.3.1"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/autonomic-ai-dev/agent-body/releases/download/v1.0.0-beta.3.1/agent-body-aarch64-apple-darwin"
    sha256 "4f068d07d5003bd399806b3e802b51aae2392903d7e7b64afe8ba1123a5a8813"
  end

  def install
    odie "autonomic supports macOS Apple Silicon (arm64) only" if !OS.mac? || !Hardware::CPU.arm?

    bin.install "agent-body-aarch64-apple-darwin" => "agent-body"
    bin.install_symlink "agent-body" => "autonomic"
  end

  def post_install
    AutonomicSetup.run_workspace_init(self)
  end

  def caveats
    AutonomicSetup.shadow_warning + AutonomicSetup.finish_setup_caveats(meta_only: true)
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/autonomic --version")
  end
end
