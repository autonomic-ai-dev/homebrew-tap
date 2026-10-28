class AgentBrain < Formula
  desc "Local cognitive graph, MCP server, and long-term memory engine"
  homepage "https://github.com/autonomic-ai-dev/agent-brain"
  version "1.0.0-rc3"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/autonomic-ai-dev/agent-brain/releases/download/v1.0.0-rc3/agent-brain-aarch64-apple-darwin"
    sha256 "07bc4bf904544c99e64726866a1f5e779be2a38aba9ed96d3aa0362e0a10c0b0"
  end

  def install
    odie "agent-brain supports macOS Apple Silicon (arm64) only" if !OS.mac? || !Hardware::CPU.arm?

    bin.install "agent-brain-aarch64-apple-darwin" => "agent-brain"
  end

  test do
    assert_match "agent-brain", shell_output("#{bin}/agent-brain --version")
  end
end
