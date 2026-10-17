class AgentTui < Formula
  desc "Terminal user interface dashboard for Autonomic AI"
  homepage "https://github.com/autonomic-ai-dev/agent-tui"
  version "1.0.0-beta.3.2"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/autonomic-ai-dev/agent-tui/releases/download/v1.0.0-beta.3.2/agent-tui-aarch64-apple-darwin"
    sha256 "882b5e8c3274dafcee0436592e9bc439e9f116ba771a8b5f0ba51dcf7866e980"
  end

  def install
    odie "agent-tui supports macOS Apple Silicon (arm64) only" if !OS.mac? || !Hardware::CPU.arm?

    bin.install "agent-tui-aarch64-apple-darwin" => "agent-tui"
  end

  test do
    assert_match "agent-tui", shell_output("#{bin}/agent-tui --version")
  end
end
