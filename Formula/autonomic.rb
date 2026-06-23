require_relative "autonomic_setup"

class Autonomic < Formula
  desc "Autonomic AI ecosystem manager (meta CLI)"
  homepage "https://github.com/autonomic-ai-dev/agent-body"
  url "https://github.com/autonomic-ai-dev/agent-body"
  version "0.5.13"
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
    dest = buildpath/"agent-body"
    system "curl", "-fsSL", url, "-o", dest
    chmod 0755, dest
    bin.install dest
    bin.install_symlink "agent-body" => "autonomic"
  end

  def post_install
    AutonomicSetup.run_workspace_init(bin)
  end

  def caveats
    AutonomicSetup.shadow_warning + AutonomicSetup.finish_setup_caveats(meta_only: true)
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/autonomic --version")
  end
end
