class Tekmor < Formula
  desc "Proof eval for coding agents: allowlisted checks, receipts and gates"
  homepage "https://github.com/autonomic-ai-dev/tekmor"
  version "1.0.0"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/autonomic-ai-dev/tekmor/releases/download/v1.0.0/tekmor-aarch64-apple-darwin"
    sha256 "279300605a7f81d4dc76571c0e250213e56c48bdd08872d2dff17f5c3362c9e4"
  end

  def install
    odie "tekmor supports macOS Apple Silicon (arm64) only" if !OS.mac? || !Hardware::CPU.arm?

    bin.install "tekmor-aarch64-apple-darwin" => "tekmor"
  end

  test do
    assert_match "1.0.0", shell_output("#{bin}/tekmor --version")
  end
end
