class AgentHeart < Formula
  desc "Scheduled GC, token budget gate, and heartbeat monitor for Autonomic AI"
  homepage "https://github.com/autonomic-ai-dev/agent-heart"
  version "1.0.0-beta.3.9"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/autonomic-ai-dev/agent-heart/releases/download/v1.0.0-beta.3.9/agent-heart-aarch64-apple-darwin"
    sha256 "64a8c4cb8546a5754ea9164b72ebd3dfe1c67f2158ea4fef63d8ef8b68d88cb2"
  end

  def install
    odie "agent-heart supports macOS Apple Silicon (arm64) only" if !OS.mac? || !Hardware::CPU.arm?

    bin.install "agent-heart-aarch64-apple-darwin" => "agent-heart"
  end

  test do
    assert_match "agent-heart", shell_output("#{bin}/agent-heart --version")
  end
end
