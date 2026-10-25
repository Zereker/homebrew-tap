class Stepcode < Formula
  desc "Independent Stepcode CLI built from official stable Codex releases"
  homepage "https://github.com/Zereker/stepcode"
  url "https://github.com/Zereker/stepcode/releases/download/stepcode-rust-v0.164.0/stepcode-macos-arm64-rust-v0.164.0.tar.gz"
  sha256 "a6ad155a39dca482a66ec4ae1de2efe98669255a5d64101254a99b4c5e5e6bb9"
  version "0.164.0"
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
