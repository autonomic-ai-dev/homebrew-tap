class AgentNerves < Formula
  desc "NATS / JetStream pub-sub event bridge and message bus for Autonomic AI"
  homepage "https://github.com/autonomic-ai-dev/agent-nerves"
  version "1.0.0-rc1"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/autonomic-ai-dev/agent-nerves/releases/download/v1.0.0-rc1/agent-nerves-aarch64-apple-darwin"
    sha256 "4ed68685329a47228e48298953c942ed620fb396e10d38aaf5929a9948d0c29c"
  end

  def install
    odie "agent-nerves supports macOS Apple Silicon (arm64) only" if !OS.mac? || !Hardware::CPU.arm?

    bin.install "agent-nerves-aarch64-apple-darwin" => "agent-nerves"
  end

  test do
    assert_match "agent-nerves", shell_output("#{bin}/agent-nerves --version")
  end
end
