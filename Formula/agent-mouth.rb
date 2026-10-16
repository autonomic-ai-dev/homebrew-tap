class AgentMouth < Formula
  desc "AST command validator, Slack notifier, and approval gate for Autonomic AI"
  homepage "https://github.com/autonomic-ai-dev/agent-mouth"
  version "1.0.0-beta.1"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/autonomic-ai-dev/agent-mouth/releases/download/v1.0.0-beta.1/agent-mouth-aarch64-apple-darwin"
    sha256 "50192d42d7985751ed97b053464dba1ac0a7abca3d86c5cb08a8d688d6944ff9"
  end

  def install
    odie "agent-mouth supports macOS Apple Silicon (arm64) only" if !OS.mac? || !Hardware::CPU.arm?

    bin.install "agent-mouth-aarch64-apple-darwin" => "agent-mouth"
  end

  test do
    assert_match "agent-mouth", shell_output("#{bin}/agent-mouth --version")
  end
end
