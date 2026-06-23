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
      # Download to buildpath first — bin/ may not exist yet (curl error 23 otherwise).
      dest = buildpath/binary
      system "curl", "-fsSL", url, "-o", dest
      chmod 0755, dest
      bin.install dest
    end

    bin.install_symlink "agent-body" => "autonomic"
  end

  def post_install
    workspace = Dir.home/".autonomic"
    return if workspace.directory?

    cli = bin/"autonomic"
    unless cli.exist?
      opoo "autonomic binary missing; run `agent-body init` after install."
      return
    end

    ohai "Initializing Autonomic workspace at #{workspace}"
    if quiet_system(cli, "init")
      ohai "Workspace ready: #{workspace}"
    else
      opoo <<~EOS
        autonomic init exited non-zero (formula install succeeded).
        Finish setup manually: #{cli} init
      EOS
    end
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
