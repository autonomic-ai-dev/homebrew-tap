class AgentHeart < Formula
  desc "Scheduled GC, token budget gate, and heartbeat monitor for Autonomic AI"
  homepage "https://github.com/autonomic-ai-dev/agent-heart"
  version "1.0.0-beta.3.1"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/autonomic-ai-dev/agent-heart/releases/download/v1.0.0-beta.3.1/agent-heart-aarch64-apple-darwin"
    sha256 "c2d16a89839837df3bfd7ec386473dafa0736575303de8a22b4859cc0be0cc49"
  end

  def install
    odie "agent-heart supports macOS Apple Silicon (arm64) only" if !OS.mac? || !Hardware::CPU.arm?

    bin.install "agent-heart-aarch64-apple-darwin" => "agent-heart"
  end

  test do
    assert_match "agent-heart", shell_output("#{bin}/agent-heart --version")
  end
end
