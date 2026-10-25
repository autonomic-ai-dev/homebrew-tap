class AgentSpine < Formula
  desc "Workflow DAG engine and execution controller for Autonomic AI"
  homepage "https://github.com/autonomic-ai-dev/agent-spine"
  version "1.0.0-rc1"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/autonomic-ai-dev/agent-spine/releases/download/v1.0.0-rc1/agent-spine-aarch64-apple-darwin"
    sha256 "8cf4c8cd91de09bc1c7df1ac1ab9b3a346ffbb779ac17b50d6ce681d3551b95f"
  end

  def install
    odie "agent-spine supports macOS Apple Silicon (arm64) only" if !OS.mac? || !Hardware::CPU.arm?

    bin.install "agent-spine-aarch64-apple-darwin" => "agent-spine"
  end

  test do
    assert_match "agent-spine", shell_output("#{bin}/agent-spine --version")
  end
end
