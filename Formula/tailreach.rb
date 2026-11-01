# brew install tanmaydoesai/tailreach/tailreach
# mydevices setup
class Tailreach < Formula
  desc "Your Mac's screen in any browser on your Tailscale tailnet"
  homepage "https://github.com/TanmayDoesAI/tailreach"
  url "https://github.com/TanmayDoesAI/tailreach/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "b8db14a0f97c6722f9a6cd79686ba2466421a29af2eeba78453359b61dc22692"
  license "Apache-2.0"
  head "https://github.com/TanmayDoesAI/tailreach.git", branch: "main"

  depends_on "go" => :build
  depends_on macos: :sonoma

  def install
    ENV["CGO_ENABLED"] = "0"
    # The binary keeps the name mydevices: macOS ties granted permissions to it.
    system "go", "build", *std_go_args(output: libexec/"mydevices", ldflags: "-s -w"), "."
    system "swiftc", "-O", "-swift-version", "5", *Dir["capture/*.swift"], "-o", libexec/"mydevices-capture"
    bin.install_symlink libexec/"mydevices"
  end

  def caveats
    <<~EOS
      Finish with:
        mydevices setup
      It signs tailreach with a local identity (so macOS remembers its permissions),
      starts it at login and lists what's left for you to do.
      Run it again after every `brew upgrade tailreach`.
    EOS
  end

  test do
    assert_match(/\d+\.\d+/, shell_output("#{bin}/mydevices version"))
  end
end
