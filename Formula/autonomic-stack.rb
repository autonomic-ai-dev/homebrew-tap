class AutonomicStack < Formula
  desc "Full Autonomic AI organ stack (meta CLI + all peripheral binaries)"
  homepage "https://github.com/autonomic-ai-dev/agent-body"
  # Formula version tracks agent-body; other organs install from each repo's latest release.
  url "https://github.com/autonomic-ai-dev/agent-body"
  version "0.5.12"
  license "MIT"

  depends_on "curl"
  depends_on "nats-server"

  ORGANS = {
    "autonomic-ai-dev/agent-body" => "agent-body",
    "autonomic-ai-dev/agent-brain" => "agent-brain",
    "autonomic-ai-dev/agent-spine" => "agent-spine",
    "autonomic-ai-dev/agent-heart" => "agent-heart",
    "autonomic-ai-dev/agent-nerves" => "agent-nerves",
    "autonomic-ai-dev/agent-muscle" => "agent-muscle",
    "autonomic-ai-dev/agent-immune" => "agent-immune",
    "autonomic-ai-dev/agent-eyes" => "agent-eyes",
    "autonomic-ai-dev/agent-mouth" => "agent-mouth",
  }.freeze

  def install
    odie "autonomic-stack supports macOS only; use curl install on Linux" unless OS.mac?

    target = if Hardware::CPU.arm?
      "aarch64-apple-darwin"
    else
      "x86_64-apple-darwin"
    end

    ORGANS.each do |repo, binary|
      asset = "#{binary}-#{target}"
      # Same as install-all-organs.sh: each organ's latest release (not one shared tag).
      url = "https://github.com/#{repo}/releases/latest/download/#{asset}"
      dest = bin/binary
      system "curl", "-fsSL", url, "-o", dest
      chmod 0755, dest
    end

    bin.install_symlink bin/"agent-body" => "autonomic"
  end

  def post_install
    system "#{bin}/autonomic", "init" unless (Dir.home/".autonomic").directory?
  end

  def caveats
    <<~EOS
      Installed latest release binary per organ (see install-all-organs.sh).
      Symlink: autonomic -> agent-body
      NATS: nats-server from Homebrew core (dependency)
      Meta CLI only: brew install autonomic-ai-dev/tap/autonomic
    EOS
  end

  test do
    assert_predicate bin/"agent-body", :exist?
    assert_predicate bin/"agent-brain", :exist?
    shell_output("#{bin}/autonomic --version")
  end
end
