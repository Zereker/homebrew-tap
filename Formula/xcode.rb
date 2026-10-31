class Xcode < Formula
  desc "Claude Code binary repackaged with the xcode name and local signing"
  homepage "https://github.com/Zereker/xcode"
  url "https://github.com/Zereker/xcode/releases/download/xcode-v2.1.309-r1/xcode-darwin-arm64.tar.gz"
  version "2.1.309"
  sha256 "d066a76949b02c8813b6aacbf78fa9c59d9326e7c7c592f026fa6c36c3abf153"
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
