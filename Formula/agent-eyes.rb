class AgentEyes < Formula
  desc "Visual perception, screen capture, and DOM inspector for Autonomic AI"
  homepage "https://github.com/autonomic-ai-dev/agent-eyes"
  version "1.0.0-beta.3"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/autonomic-ai-dev/agent-eyes/releases/download/v1.0.0-beta.3/agent-eyes-aarch64-apple-darwin"
    sha256 "abe57ed1b584b51e9d832394ec6f51efd2327d8ba5b6b8689d6c1114945128da"
  end

  def install
    odie "agent-eyes supports macOS Apple Silicon (arm64) only" if !OS.mac? || !Hardware::CPU.arm?

    bin.install "agent-eyes-aarch64-apple-darwin" => "agent-eyes"
  end

  test do
    assert_match "agent-eyes", shell_output("#{bin}/agent-eyes --version")
  end
end
