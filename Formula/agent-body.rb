class AgentBody < Formula
  desc "Ecosystem manager (meta CLI) and supervisor for Autonomic AI"
  homepage "https://github.com/autonomic-ai-dev/agent-body"
  version "1.0.0-beta.1"
  license "MIT"

  depends_on "autonomic-ai-dev/tap/autonomic"

  # Minimal payload for formula
  url "https://github.com/autonomic-ai-dev/agent-body/releases/download/v1.0.0-beta.1/agent-body-aarch64-apple-darwin"
  sha256 "a5b51aa4abf88880c10b9176757439c6ea7ac61e0e9d063ddb893188273ffdf1"

  def install
    # Provided by autonomic formula dependency
    (var/"autonomic").mkpath
    touch var/"autonomic/.agent-body-installed"
  end

  test do
    assert_predicate HOMEBREW_PREFIX/"bin/agent-body", :exist?
  end
end
