require_relative "autonomic_setup"

class AutonomicStack < Formula
  desc "Full Autonomic AI organ stack (meta CLI + all peripheral binaries)"
  homepage "https://github.com/autonomic-ai-dev/agent-body"
  url "https://github.com/autonomic-ai-dev/agent-body"
  version "0.5.13"
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
      url = "https://github.com/#{repo}/releases/latest/download/#{asset}"
      dest = buildpath/binary
      system "curl", "-fsSL", url, "-o", dest
      chmod 0755, dest
      bin.install dest
    end

    bin.install_symlink "agent-body" => "autonomic"
  end

  def post_install
    AutonomicSetup.run_workspace_init(bin)
  end

  def caveats
    AutonomicSetup.shadow_warning + AutonomicSetup.finish_setup_caveats(meta_only: false)
  end

  test do
    assert_predicate bin/"agent-body", :exist?
    assert_predicate bin/"agent-brain", :exist?
    shell_output("#{bin}/autonomic --version")
  end
end
