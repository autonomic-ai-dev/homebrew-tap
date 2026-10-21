class AgentNerves < Formula
  desc "NATS / JetStream pub-sub event bridge and message bus for Autonomic AI"
  homepage "https://github.com/autonomic-ai-dev/agent-nerves"
  version "1.0.0-beta.3.9"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/autonomic-ai-dev/agent-nerves/releases/download/v1.0.0-beta.3.9/agent-nerves-aarch64-apple-darwin"
    sha256 "60cc71347626ea9adccd64b8f14860ca7f6fdae63dd1adcba6f19797747d715d"
  end

  def install
    odie "agent-nerves supports macOS Apple Silicon (arm64) only" if !OS.mac? || !Hardware::CPU.arm?

    bin.install "agent-nerves-aarch64-apple-darwin" => "agent-nerves"
  end

  test do
    assert_match "agent-nerves", shell_output("#{bin}/agent-nerves --version")
  end
end
