class AgentEyes < Formula
  desc "Visual perception, screen capture, and DOM inspector for Autonomic AI"
  homepage "https://github.com/autonomic-ai-dev/agent-eyes"
  version "1.0.0-beta.3.1"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/autonomic-ai-dev/agent-eyes/releases/download/v1.0.0-beta.3.1/agent-eyes-aarch64-apple-darwin"
    sha256 "72c1f290290f829c9a0c7680ddba4a7aaaa09f55b166838da427c3094e8a2053"
  end

  def install
    odie "agent-eyes supports macOS Apple Silicon (arm64) only" if !OS.mac? || !Hardware::CPU.arm?

    bin.install "agent-eyes-aarch64-apple-darwin" => "agent-eyes"
  end

  test do
    assert_match "agent-eyes", shell_output("#{bin}/agent-eyes --version")
  end
end
