class AgentImmune < Formula
  desc "Security vulnerability scanner and policy enforcer for Autonomic AI"
  homepage "https://github.com/autonomic-ai-dev/agent-immune"
  version "1.0.0-rc1"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/autonomic-ai-dev/agent-immune/releases/download/v1.0.0-rc1/agent-immune-aarch64-apple-darwin"
    sha256 "e865507f52f917fa926f940e75aec95d48edd40de30b09f6c63fb14f6270cc22"
  end

  def install
    odie "agent-immune supports macOS Apple Silicon (arm64) only" if !OS.mac? || !Hardware::CPU.arm?

    bin.install "agent-immune-aarch64-apple-darwin" => "agent-immune"
  end

  test do
    assert_match "agent-immune", shell_output("#{bin}/agent-immune --version")
  end
end
