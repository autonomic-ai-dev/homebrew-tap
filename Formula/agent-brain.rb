class AgentBrain < Formula
  desc "Local cognitive graph, MCP server, and long-term memory engine"
  homepage "https://github.com/autonomic-ai-dev/agent-brain"
  version "1.0.0-rc2"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/autonomic-ai-dev/agent-brain/releases/download/v1.0.0-rc2/agent-brain-aarch64-apple-darwin"
    sha256 "a577a0da4646aa3cafef29e402541ca33c6f8a8da28a48d2ea871843e61c2767"
  end

  def install
    odie "agent-brain supports macOS Apple Silicon (arm64) only" if !OS.mac? || !Hardware::CPU.arm?

    bin.install "agent-brain-aarch64-apple-darwin" => "agent-brain"
  end

  test do
    assert_match "agent-brain", shell_output("#{bin}/agent-brain --version")
  end
end
