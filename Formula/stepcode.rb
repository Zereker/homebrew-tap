class Stepcode < Formula
  desc "Independent Stepcode CLI built from official stable Codex releases"
  homepage "https://github.com/Zereker/stepcode"
  url "https://github.com/Zereker/stepcode/releases/download/stepcode-rust-v0.167.2/stepcode-macos-arm64-rust-v0.167.2.tar.gz"
  sha256 "dab5573e93442eaaef4d844fc25701b11c369caa5092b4d6c22bed4ddc87798b"
  version "0.167.2"
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
