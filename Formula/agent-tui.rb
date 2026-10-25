class AgentTui < Formula
  desc "Terminal user interface dashboard for Autonomic AI"
  homepage "https://github.com/autonomic-ai-dev/agent-tui"
  version "1.0.0-rc1"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/autonomic-ai-dev/agent-tui/releases/download/v1.0.0-rc1/agent-tui-aarch64-apple-darwin"
    sha256 "4a4ffb7933acb6208a6d73398776ebc935a4eb376662e613a1529a3308c0af12"
  end

  def install
    odie "agent-tui supports macOS Apple Silicon (arm64) only" if !OS.mac? || !Hardware::CPU.arm?

    bin.install "agent-tui-aarch64-apple-darwin" => "agent-tui"
  end

  test do
    assert_match "agent-tui", shell_output("#{bin}/agent-tui --version")
  end
end
