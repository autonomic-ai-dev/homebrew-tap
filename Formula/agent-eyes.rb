class AgentEyes < Formula
  desc "Visual perception, screen capture, and DOM inspector for Autonomic AI"
  homepage "https://github.com/autonomic-ai-dev/agent-eyes"
  version "1.0.0-beta.3.9"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/autonomic-ai-dev/agent-eyes/releases/download/v1.0.0-beta.3.9/agent-eyes-aarch64-apple-darwin"
    sha256 "8429769b7c42bff7c9a474c1b6f556aecb862283b87c2f4876657688d84d8f40"
  end

  def install
    odie "agent-eyes supports macOS Apple Silicon (arm64) only" if !OS.mac? || !Hardware::CPU.arm?

    bin.install "agent-eyes-aarch64-apple-darwin" => "agent-eyes"
  end

  test do
    assert_match "agent-eyes", shell_output("#{bin}/agent-eyes --version")
  end
end
