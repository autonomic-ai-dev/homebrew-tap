class AgentMouth < Formula
  desc "AST command validator, Slack notifier, and approval gate for Autonomic AI"
  homepage "https://github.com/autonomic-ai-dev/agent-mouth"
  version "1.0.0-beta.3.9"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/autonomic-ai-dev/agent-mouth/releases/download/v1.0.0-beta.3.9/agent-mouth-aarch64-apple-darwin"
    sha256 "e53958670db290e70493e2d821a96b564d74790c3c7ed09bd37e74efaf4a1004"
  end

  def install
    odie "agent-mouth supports macOS Apple Silicon (arm64) only" if !OS.mac? || !Hardware::CPU.arm?

    bin.install "agent-mouth-aarch64-apple-darwin" => "agent-mouth"
  end

  test do
    assert_match "agent-mouth", shell_output("#{bin}/agent-mouth --version")
  end
end
