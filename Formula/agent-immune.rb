class AgentImmune < Formula
  desc "Security vulnerability scanner and policy enforcer for Autonomic AI"
  homepage "https://github.com/autonomic-ai-dev/agent-immune"
  version "1.0.0-beta.1"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/autonomic-ai-dev/agent-immune/releases/download/v1.0.0-beta.1/agent-immune-aarch64-apple-darwin"
    sha256 "6790eeafeff5c6b3e7b1f42543e6b0c2decf55bdd3041e45c0fe2e6250d13a86"
  end

  def install
    odie "agent-immune supports macOS Apple Silicon (arm64) only" if !OS.mac? || !Hardware::CPU.arm?

    bin.install "agent-immune-aarch64-apple-darwin" => "agent-immune"
  end

  test do
    assert_match "agent-immune", shell_output("#{bin}/agent-immune --version")
  end
end
