class AgentBrain < Formula
  desc "Local cognitive graph, MCP server, and long-term memory engine"
  homepage "https://github.com/autonomic-ai-dev/agent-brain"
  version "1.0.0-beta.3.9"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/autonomic-ai-dev/agent-brain/releases/download/v1.0.0-beta.3.9/agent-brain-aarch64-apple-darwin"
    sha256 "5c2c1e31c634bf022d2ce15a7b579640781eec2b2e7d7175bfcbfd840a0e6874"
  end

  def install
    odie "agent-brain supports macOS Apple Silicon (arm64) only" if !OS.mac? || !Hardware::CPU.arm?

    bin.install "agent-brain-aarch64-apple-darwin" => "agent-brain"
  end

  test do
    assert_match "agent-brain", shell_output("#{bin}/agent-brain --version")
  end
end
