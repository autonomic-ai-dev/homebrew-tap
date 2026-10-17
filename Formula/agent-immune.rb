class AgentImmune < Formula
  desc "Security vulnerability scanner and policy enforcer for Autonomic AI"
  homepage "https://github.com/autonomic-ai-dev/agent-immune"
  version "1.0.0-beta.3"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/autonomic-ai-dev/agent-immune/releases/download/v1.0.0-beta.3/agent-immune-aarch64-apple-darwin"
    sha256 "e632cb4b4bb2f5e302e2796e5b84583732ea835ceaa1cc0098985a2f2d98ca02"
  end

  def install
    odie "agent-immune supports macOS Apple Silicon (arm64) only" if !OS.mac? || !Hardware::CPU.arm?

    bin.install "agent-immune-aarch64-apple-darwin" => "agent-immune"
  end

  test do
    assert_match "agent-immune", shell_output("#{bin}/agent-immune --version")
  end
end
