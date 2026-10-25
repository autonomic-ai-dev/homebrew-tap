class AgentHeart < Formula
  desc "Scheduled GC, token budget gate, and heartbeat monitor for Autonomic AI"
  homepage "https://github.com/autonomic-ai-dev/agent-heart"
  version "1.0.0-rc1"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/autonomic-ai-dev/agent-heart/releases/download/v1.0.0-rc1/agent-heart-aarch64-apple-darwin"
    sha256 "6f2d77b71967236e84b627594480830e6d830b59a87d738bc7485caaaa9256ae"
  end

  def install
    odie "agent-heart supports macOS Apple Silicon (arm64) only" if !OS.mac? || !Hardware::CPU.arm?

    bin.install "agent-heart-aarch64-apple-darwin" => "agent-heart"
  end

  test do
    assert_match "agent-heart", shell_output("#{bin}/agent-heart --version")
  end
end
