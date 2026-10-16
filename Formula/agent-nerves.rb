class AgentNerves < Formula
  desc "NATS / JetStream pub-sub event bridge and message bus for Autonomic AI"
  homepage "https://github.com/autonomic-ai-dev/agent-nerves"
  version "1.0.0-beta.1"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/autonomic-ai-dev/agent-nerves/releases/download/v1.0.0-beta.1/agent-nerves-aarch64-apple-darwin"
    sha256 "921e1d9475b6218e84d3056802f8f84f4526390e2d0304f90b559ce39b20b632"
  end

  def install
    odie "agent-nerves supports macOS Apple Silicon (arm64) only" if !OS.mac? || !Hardware::CPU.arm?

    bin.install "agent-nerves-aarch64-apple-darwin" => "agent-nerves"
  end

  test do
    assert_match "agent-nerves", shell_output("#{bin}/agent-nerves --version")
  end
end
