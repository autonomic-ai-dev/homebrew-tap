require_relative "autonomic_setup"

class Autonomic < Formula
  desc "Ecosystem manager (meta CLI) for Autonomic AI"
  homepage "https://github.com/autonomic-ai-dev/agent-body"
  version "1.0.0-rc1"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/autonomic-ai-dev/agent-body/releases/download/v1.0.0-rc1/agent-body-aarch64-apple-darwin"
    sha256 "13298a8bc484af76e334ff3c95c4fe5200c5ed2695eb098afa71e96e1cc531cc"
  end

  deprecate! date: "2026-10-26", because: "is out of scope. Autonomic AI now ships agent-brain and agent-spine only"

  def install
    odie "autonomic supports macOS Apple Silicon (arm64) only" if !OS.mac? || !Hardware::CPU.arm?

    bin.install "agent-body-aarch64-apple-darwin" => "agent-body"
    bin.install_symlink "agent-body" => "autonomic"
  end

  def caveats
    AutonomicSetup.shadow_warning + AutonomicSetup.finish_setup_caveats
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/autonomic --version")
  end
end
