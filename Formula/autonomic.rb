class Autonomic < Formula
  desc "Autonomic AI ecosystem manager (meta CLI)"
  homepage "https://github.com/autonomic-ai-dev/agent-body"
  url "https://github.com/autonomic-ai-dev/agent-body"
  version "0.5.12"
  license "MIT"

  depends_on "curl"

  def install
    odie "autonomic formula supports macOS only; use curl install on Linux" unless OS.mac?

    arch = if Hardware::CPU.arm?
      "aarch64-apple-darwin"
    else
      "x86_64-apple-darwin"
    end
    asset = "agent-body-#{arch}"
    url = "https://github.com/autonomic-ai-dev/agent-body/releases/download/v#{version}/#{asset}"
    binpath = bin/"agent-body"
    system "curl", "-fsSL", url, "-o", binpath
    chmod 0755, binpath
    bin.install_symlink binpath => "autonomic"
  end

  def post_install
    system "#{bin}/autonomic", "init" unless (Dir.home/".autonomic").directory?
  end

  def caveats
    <<~EOS
      Installed: agent-body + autonomic symlink in #{HOMEBREW_PREFIX}/bin
      Full stack: brew install autonomic-ai-dev/tap/autonomic-stack
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/autonomic --version")
  end
end
