class Stepcode < Formula
  desc "Independent Stepcode CLI built from official stable Codex releases"
  homepage "https://github.com/Zereker/stepcode"
  url "https://github.com/Zereker/stepcode/releases/download/stepcode-rust-v0.163.0/stepcode-macos-arm64-rust-v0.163.0.tar.gz"
  sha256 "30862bf44bf4234de96438ba30d378e2e08ac6d9fd5801aa367b8010431a2215"
  version "0.163.0"

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
