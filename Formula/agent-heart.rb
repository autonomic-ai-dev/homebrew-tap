class AgentHeart < Formula
  desc "Scheduled GC, token budget gate, and heartbeat monitor for Autonomic AI"
  homepage "https://github.com/autonomic-ai-dev/agent-heart"
  version "1.0.0-beta.3"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/autonomic-ai-dev/agent-heart/releases/download/v1.0.0-beta.3/agent-heart-aarch64-apple-darwin"
    sha256 "418385141429ed4ba8c678a5810513165fb0bb2e6cf05c6c187b2015fbe32bfe"
  end

  def install
    odie "agent-heart supports macOS Apple Silicon (arm64) only" if !OS.mac? || !Hardware::CPU.arm?

    bin.install "agent-heart-aarch64-apple-darwin" => "agent-heart"
  end

  test do
    assert_match "agent-heart", shell_output("#{bin}/agent-heart --version")
  end
end
