class AgentSpine < Formula
  desc "Workflow DAG engine and execution controller for Autonomic AI"
  homepage "https://github.com/autonomic-ai-dev/agent-spine"
  version "1.0.0-beta.3.1"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/autonomic-ai-dev/agent-spine/releases/download/v1.0.0-beta.3.1/agent-spine-aarch64-apple-darwin"
    sha256 "91517607d18dcffffe5e9f10567fa349ed520180093f9e87c40e6efc54fb3baa"
  end

  def install
    odie "agent-spine supports macOS Apple Silicon (arm64) only" if !OS.mac? || !Hardware::CPU.arm?

    bin.install "agent-spine-aarch64-apple-darwin" => "agent-spine"
  end

  test do
    assert_match "agent-spine", shell_output("#{bin}/agent-spine --version")
  end
end
