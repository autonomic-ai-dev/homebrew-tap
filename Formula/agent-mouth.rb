class AgentMouth < Formula
  desc "AST command validator, Slack notifier, and approval gate for Autonomic AI"
  homepage "https://github.com/autonomic-ai-dev/agent-mouth"
  version "1.0.0-beta.3"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/autonomic-ai-dev/agent-mouth/releases/download/v1.0.0-beta.3/agent-mouth-aarch64-apple-darwin"
    sha256 "681919913b8322896dac3e7acd0214795971269430be5d247733597410fe5ff5"
  end

  def install
    odie "agent-mouth supports macOS Apple Silicon (arm64) only" if !OS.mac? || !Hardware::CPU.arm?

    bin.install "agent-mouth-aarch64-apple-darwin" => "agent-mouth"
  end

  test do
    assert_match "agent-mouth", shell_output("#{bin}/agent-mouth --version")
  end
end
