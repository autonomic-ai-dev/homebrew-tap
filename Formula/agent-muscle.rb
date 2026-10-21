class AgentMuscle < Formula
  desc "Sandboxed command execution and training backend for Autonomic AI"
  homepage "https://github.com/autonomic-ai-dev/agent-muscle"
  version "1.0.0-beta.3.9"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/autonomic-ai-dev/agent-muscle/releases/download/v1.0.0-beta.3.9/agent-muscle-aarch64-apple-darwin"
    sha256 "918570f92e16ee63dddc6d3a5609f8a6c086b314a33b7cb7d7fce8530f9424dd"
  end

  def install
    odie "agent-muscle supports macOS Apple Silicon (arm64) only" if !OS.mac? || !Hardware::CPU.arm?

    bin.install "agent-muscle-aarch64-apple-darwin" => "agent-muscle"
  end

  test do
    assert_match "agent-muscle", shell_output("#{bin}/agent-muscle --version")
  end
end
