class Tekmor < Formula
  desc "Proof eval for coding agents: allowlisted checks, receipts and gates"
  homepage "https://github.com/autonomic-ai-dev/tekmor"
  version "2.0.0"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/autonomic-ai-dev/tekmor/releases/download/v2.0.0/tekmor-aarch64-apple-darwin"
    sha256 "8742780d7a1fda28ac0c7b78a9874bf8d819b01712e8e2d72f66bde88390bba8"
  end

  def install
    odie "tekmor supports macOS Apple Silicon (arm64) only" if !OS.mac? || !Hardware::CPU.arm?

    bin.install "tekmor-aarch64-apple-darwin" => "tekmor"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tekmor --version")
  end
end
