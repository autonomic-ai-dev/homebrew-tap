class AgentMuscle < Formula
  desc "Sandboxed command execution and training backend for Autonomic AI"
  homepage "https://github.com/autonomic-ai-dev/agent-muscle"
  version "1.0.0-rc1"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/autonomic-ai-dev/agent-muscle/releases/download/v1.0.0-rc1/agent-muscle-aarch64-apple-darwin"
    sha256 "76444cf1497276a3ef39c84a3f1ba1a90d5a284eaeac65a8a8ce89242d03a3dc"
  end

  def install
    odie "agent-muscle supports macOS Apple Silicon (arm64) only" if !OS.mac? || !Hardware::CPU.arm?

    bin.install "agent-muscle-aarch64-apple-darwin" => "agent-muscle"
  end

  test do
    assert_match "agent-muscle", shell_output("#{bin}/agent-muscle --version")
  end
end
