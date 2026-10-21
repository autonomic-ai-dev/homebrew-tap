class AgentImmune < Formula
  desc "Security vulnerability scanner and policy enforcer for Autonomic AI"
  homepage "https://github.com/autonomic-ai-dev/agent-immune"
  version "1.0.0-beta.3.9"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/autonomic-ai-dev/agent-immune/releases/download/v1.0.0-beta.3.9/agent-immune-aarch64-apple-darwin"
    sha256 "666ca18d88f7419185aef91cf5349dc52f69147c8143eb5abe288ec3b6090795"
  end

  def install
    odie "agent-immune supports macOS Apple Silicon (arm64) only" if !OS.mac? || !Hardware::CPU.arm?

    bin.install "agent-immune-aarch64-apple-darwin" => "agent-immune"
  end

  test do
    assert_match "agent-immune", shell_output("#{bin}/agent-immune --version")
  end
end
