class Stepcode < Formula
  desc "Independent Stepcode CLI built from official stable Codex releases"
  homepage "https://github.com/Zereker/stepcode"
  url "https://github.com/Zereker/stepcode/releases/download/stepcode-rust-v0.163.0-r1/stepcode-macos-arm64-rust-v0.163.0-r1.tar.gz"
  sha256 "ab98f04674ef2463c93550508d5b9a3112bba1a324f9c8acb52255215bec2571"
  version "0.163.0"
  revision 1

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
