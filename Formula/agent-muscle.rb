class AgentMuscle < Formula
  desc "Sandboxed command execution and training backend for Autonomic AI"
  homepage "https://github.com/autonomic-ai-dev/agent-muscle"
  version "1.0.0-beta.3.1"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/autonomic-ai-dev/agent-muscle/releases/download/v1.0.0-beta.3.1/agent-muscle-aarch64-apple-darwin"
    sha256 "f32b172d3e3943224b50135743b8a1cdd7ce207a0819bfff7d730edb14e25655"
  end

  def install
    odie "agent-muscle supports macOS Apple Silicon (arm64) only" if !OS.mac? || !Hardware::CPU.arm?

    bin.install "agent-muscle-aarch64-apple-darwin" => "agent-muscle"
  end

  test do
    assert_match "agent-muscle", shell_output("#{bin}/agent-muscle --version")
  end
end
