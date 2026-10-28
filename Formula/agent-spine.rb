class AgentSpine < Formula
  desc "Workflow DAG engine and execution controller for Autonomic AI"
  homepage "https://github.com/autonomic-ai-dev/agent-spine"
  version "1.0.0-rc3"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/autonomic-ai-dev/agent-spine/releases/download/v1.0.0-rc3/agent-spine-aarch64-apple-darwin"
    sha256 "fe565a206fce30921f21a4096a329d3970c65cecf2b58c300b3ee83540c7cbba"
  end

  def install
    odie "agent-spine supports macOS Apple Silicon (arm64) only" if !OS.mac? || !Hardware::CPU.arm?

    bin.install "agent-spine-aarch64-apple-darwin" => "agent-spine"
  end

  test do
    assert_match "agent-spine", shell_output("#{bin}/agent-spine --version")
  end
end
