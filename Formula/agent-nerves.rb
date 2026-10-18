class AgentNerves < Formula
  desc "NATS / JetStream pub-sub event bridge and message bus for Autonomic AI"
  homepage "https://github.com/autonomic-ai-dev/agent-nerves"
  version "1.0.0-beta.3.3"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/autonomic-ai-dev/agent-nerves/releases/download/v1.0.0-beta.3.3/agent-nerves-aarch64-apple-darwin"
    sha256 "ac8648d003806bc40e31a90ac59b965991306fc8c2b18e5f36b82550bbc78557"
  end

  def install
    odie "agent-nerves supports macOS Apple Silicon (arm64) only" if !OS.mac? || !Hardware::CPU.arm?

    bin.install "agent-nerves-aarch64-apple-darwin" => "agent-nerves"
  end

  test do
    assert_match "agent-nerves", shell_output("#{bin}/agent-nerves --version")
  end
end
