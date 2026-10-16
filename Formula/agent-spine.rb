class AgentSpine < Formula
  desc "Workflow DAG engine and execution controller for Autonomic AI"
  homepage "https://github.com/autonomic-ai-dev/agent-spine"
  version "1.0.0-beta.1"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/autonomic-ai-dev/agent-spine/releases/download/v1.0.0-beta.1/agent-spine-aarch64-apple-darwin"
    sha256 "3259f65a070507960534828dac6acfff7629e02b19a6259ee93f83aae2522080"
  end

  def install
    odie "agent-spine supports macOS Apple Silicon (arm64) only" if !OS.mac? || !Hardware::CPU.arm?

    bin.install "agent-spine-aarch64-apple-darwin" => "agent-spine"
  end

  test do
    assert_match "agent-spine", shell_output("#{bin}/agent-spine --version")
  end
end
