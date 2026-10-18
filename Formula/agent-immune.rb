class AgentImmune < Formula
  desc "Security vulnerability scanner and policy enforcer for Autonomic AI"
  homepage "https://github.com/autonomic-ai-dev/agent-immune"
  version "1.0.0-beta.3.1"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/autonomic-ai-dev/agent-immune/releases/download/v1.0.0-beta.3.1/agent-immune-aarch64-apple-darwin"
    sha256 "8a0a5c248964861146f752cedf14bbf28abea6f0f25dfa4b5a08c9f38e57fe60"
  end

  def install
    odie "agent-immune supports macOS Apple Silicon (arm64) only" if !OS.mac? || !Hardware::CPU.arm?

    bin.install "agent-immune-aarch64-apple-darwin" => "agent-immune"
  end

  test do
    assert_match "agent-immune", shell_output("#{bin}/agent-immune --version")
  end
end
