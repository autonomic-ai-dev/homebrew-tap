class AgentMuscle < Formula
  desc "Sandboxed command execution and training backend for Autonomic AI"
  homepage "https://github.com/autonomic-ai-dev/agent-muscle"
  version "1.0.0-beta.3"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/autonomic-ai-dev/agent-muscle/releases/download/v1.0.0-beta.3/agent-muscle-aarch64-apple-darwin"
    sha256 "145a745e7a441199a6c0bbd742264732d8eb9dca0483473afe7f16938667305f"
  end

  def install
    odie "agent-muscle supports macOS Apple Silicon (arm64) only" if !OS.mac? || !Hardware::CPU.arm?

    bin.install "agent-muscle-aarch64-apple-darwin" => "agent-muscle"
  end

  test do
    assert_match "agent-muscle", shell_output("#{bin}/agent-muscle --version")
  end
end
