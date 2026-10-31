class Stepcode < Formula
  desc "Independent Stepcode CLI built from official stable Codex releases"
  homepage "https://github.com/Zereker/stepcode"
  url "https://github.com/Zereker/stepcode/releases/download/stepcode-rust-v0.166.0/stepcode-macos-arm64-rust-v0.166.0.tar.gz"
  sha256 "f58bb1771e7698a71aae064b99d706d26d61e0b9779d1603b89e47a938b2b8dc"
  version "0.166.0"
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
