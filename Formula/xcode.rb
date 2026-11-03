class Xcode < Formula
  desc "Claude Code binary repackaged with the xcode name and local signing"
  homepage "https://github.com/Zereker/xcode"
  url "https://github.com/Zereker/xcode/releases/download/xcode-v2.1.311-r1/xcode-darwin-arm64.tar.gz"
  version "2.1.311"
  sha256 "23704b206497c83ecc6fc9111ed74b868a0769a52a5d317bd0731ef0bc6e4534"
  revision 1
  license :cannot_represent

  depends_on :macos
  depends_on arch: :arm64

  def install
    bin.install "xcode"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/xcode --version")
    assert_match "Usage:", shell_output("#{bin}/xcode --help")
  end
end
