class AgentBrain < Formula
  desc "Local cognitive graph, MCP server, and long-term memory engine"
  homepage "https://github.com/autonomic-ai-dev/agent-brain"
  version "1.0.0-beta.3.2"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/autonomic-ai-dev/agent-brain/releases/download/v1.0.0-beta.3.2/agent-brain-aarch64-apple-darwin"
    sha256 "6de2c04e6925306420d9a92ba935dec4f6ee385adad85e18c23d10b6aac7091b"
  end

  def install
    odie "agent-brain supports macOS Apple Silicon (arm64) only" if !OS.mac? || !Hardware::CPU.arm?

    bin.install "agent-brain-aarch64-apple-darwin" => "agent-brain"
  end

  test do
    assert_match "agent-brain", shell_output("#{bin}/agent-brain --version")
  end
end
