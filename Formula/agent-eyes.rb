class AgentEyes < Formula
  desc "Visual perception, screen capture, and DOM inspector for Autonomic AI"
  homepage "https://github.com/autonomic-ai-dev/agent-eyes"
  version "1.0.0-rc1"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/autonomic-ai-dev/agent-eyes/releases/download/v1.0.0-rc1/agent-eyes-aarch64-apple-darwin"
    sha256 "ffdc4111a8cd8d88edffda0b7c8176f57ccd7007da6774f6c6d3816158569272"
  end

  def install
    odie "agent-eyes supports macOS Apple Silicon (arm64) only" if !OS.mac? || !Hardware::CPU.arm?

    bin.install "agent-eyes-aarch64-apple-darwin" => "agent-eyes"
  end

  test do
    assert_match "agent-eyes", shell_output("#{bin}/agent-eyes --version")
  end
end
