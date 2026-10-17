class AgentTui < Formula
  desc "Terminal user interface dashboard for Autonomic AI"
  homepage "https://github.com/autonomic-ai-dev/agent-tui"
  version "1.0.0-beta.3.1"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/autonomic-ai-dev/agent-tui/releases/download/v1.0.0-beta.3.1/agent-tui-aarch64-apple-darwin"
    sha256 "89305d0ce248e633061aebe2093782992cc24d1f3a549e9a113438041d2ca483"
  end

  def install
    odie "agent-tui supports macOS Apple Silicon (arm64) only" if !OS.mac? || !Hardware::CPU.arm?

    bin.install "agent-tui-aarch64-apple-darwin" => "agent-tui"
  end

  test do
    assert_match "agent-tui", shell_output("#{bin}/agent-tui --version")
  end
end
