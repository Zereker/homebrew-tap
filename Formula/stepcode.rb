class Stepcode < Formula
  desc "Independent Stepcode CLI built from official stable Codex releases"
  homepage "https://github.com/Zereker/stepcode"
  url "https://github.com/Zereker/stepcode/releases/download/stepcode-rust-v0.165.0/stepcode-macos-arm64-rust-v0.165.0.tar.gz"
  sha256 "c000a7ac62cd931c93e72db3784411dc968edf3cf090a1908f861e1c4688ab8a"
  version "0.165.0"
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
