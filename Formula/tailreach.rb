# brew install tanmaydoesai/tailreach/tailreach
# tailreach setup
class Tailreach < Formula
  desc "Your Mac's screen in any browser on your Tailscale tailnet"
  homepage "https://tailreach.tanmaylabs.me"
  url "https://github.com/TanmayDoesAI/tailreach/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "4587ff3ca086f91dfcf40b24494c91f6b740780044d22d0a2abe11a9eb307585"
  license "Apache-2.0"
  head "https://github.com/TanmayDoesAI/tailreach.git", branch: "main"

  depends_on "go" => :build
  depends_on macos: :sonoma

  def install
    ENV["CGO_ENABLED"] = "0"
    # The helper must sit next to the binary: tailreach looks for it there.
    system "go", "build", *std_go_args(output: libexec/"tailreach", ldflags: "-s -w"), "./cmd/tailreach"
    system "swiftc", "-O", "-swift-version", "5", *Dir["macos/*.swift"], "-o", libexec/"tailreach-capture"
    bin.install_symlink libexec/"tailreach"
  end

  def caveats
    <<~EOS
      Finish with:
        tailreach setup
      It signs tailreach with a local identity (so macOS remembers its permissions),
      starts it at login and lists what's left for you to do.
      Run it again after every `brew upgrade tailreach`.
      Coming from mydevices? setup moves your login, password and passkeys over.
    EOS
  end

  test do
    assert_match(/\d+\.\d+/, shell_output("#{bin}/tailreach version"))
  end
end
