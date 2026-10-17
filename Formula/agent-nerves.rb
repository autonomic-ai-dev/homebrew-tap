class AgentNerves < Formula
  desc "NATS / JetStream pub-sub event bridge and message bus for Autonomic AI"
  homepage "https://github.com/autonomic-ai-dev/agent-nerves"
  version "1.0.0-beta.3.1"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/autonomic-ai-dev/agent-nerves/releases/download/v1.0.0-beta.3.1/agent-nerves-aarch64-apple-darwin"
    sha256 "381a9ef7562a5749cc233212d14c3233fab281db93a379a63ebbc1f5254dd69b"
  end

  def install
    odie "agent-nerves supports macOS Apple Silicon (arm64) only" if !OS.mac? || !Hardware::CPU.arm?

    bin.install "agent-nerves-aarch64-apple-darwin" => "agent-nerves"
  end

  test do
    assert_match "agent-nerves", shell_output("#{bin}/agent-nerves --version")
  end
end
