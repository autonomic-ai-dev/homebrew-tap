class AgentTui < Formula
  desc "Terminal user interface dashboard for Autonomic AI"
  homepage "https://github.com/autonomic-ai-dev/agent-tui"
  version "1.0.0-beta.3.4"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/autonomic-ai-dev/agent-tui/releases/download/v1.0.0-beta.3.4/agent-tui-aarch64-apple-darwin"
    sha256 "d93489e015f7f9a1c3bef4d506a1ec3bfef3ea3ca9d65e1c21eeb83d591fa452"
  end

  def install
    odie "agent-tui supports macOS Apple Silicon (arm64) only" if !OS.mac? || !Hardware::CPU.arm?

    bin.install "agent-tui-aarch64-apple-darwin" => "agent-tui"
  end

  test do
    assert_match "agent-tui", shell_output("#{bin}/agent-tui --version")
  end
end
