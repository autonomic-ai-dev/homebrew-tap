class AgentBrain < Formula
  desc "Local cognitive graph, MCP server, and long-term memory engine"
  homepage "https://github.com/autonomic-ai-dev/agent-brain"
  version "1.0.0-rc7"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/autonomic-ai-dev/agent-brain/releases/download/v1.0.0-rc7/agent-brain-aarch64-apple-darwin"
    sha256 "b3e76564d130359469f44ebfe06c52aa43fed367ab71ce7eb5a731930929b588"
  end

  def install
    odie "agent-brain supports macOS Apple Silicon (arm64) only" if !OS.mac? || !Hardware::CPU.arm?

    bin.install "agent-brain-aarch64-apple-darwin" => "agent-brain"
  end

  test do
    assert_match "agent-brain", shell_output("#{bin}/agent-brain --version")
  end
end
