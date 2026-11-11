class Stepcode < Formula
  desc "Independent Stepcode CLI built from official stable Codex releases"
  homepage "https://github.com/Zereker/stepcode"
  url "https://github.com/Zereker/stepcode/releases/download/stepcode-rust-v0.167.1/stepcode-macos-arm64-rust-v0.167.1.tar.gz"
  sha256 "a3022e6e7a5f6ded50f38cbe28f03b3a8518692832a8968db1419c9eb1db5241"
  version "0.167.1"
  revision 0

  depends_on :macos
  depends_on arch: :arm64

  def install
    libexec.install "bin", "codex-path", "codex-package.json", "REVISION.txt"
    bin.install_symlink libexec/"bin/stepcode"
  end

  test do
    assert_match "stepcode", shell_output("#{bin}/stepcode --help")
  end
end
