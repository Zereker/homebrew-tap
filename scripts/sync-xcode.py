#!/usr/bin/env python3
"""Generate a formula only from a complete, verified stable xcode release."""
import hashlib
import json
import os
import re
import subprocess
import tempfile
from pathlib import Path
from urllib.parse import quote

REPO = "Zereker/xcode"
API = "https://api.github.com/repos/" + REPO
def fetch(url, path):
    subprocess.run(["curl", "--fail", "--location", "--silent", "--show-error",
                    "--proto", "=https", "--proto-redir", "=https", "--retry", "3",
                    "--connect-timeout", "20", "--max-time", "600",
                    "-o", str(path), url], check=True, timeout=2500)

def sync():
    # gh supplies the job-scoped token without embedding it in command lines.
    result = subprocess.run(["gh", "api", f"repos/{REPO}/releases/latest"],
                            check=True, capture_output=True, text=True, timeout=60)
    release = json.loads(result.stdout)
    if release["draft"] or release["prerelease"]:
        raise ValueError("Refusing a draft or prerelease")
    tag = release["tag_name"]
    match = re.fullmatch(r"xcode-v(\d+\.\d+\.\d+)-r(\d+)", tag)
    if not match:
        raise ValueError("Unrecognized release tag")
    version, revision = match.groups()
    names = {asset["name"] for asset in release["assets"]}
    if not {"xcode-darwin-arm64.tar.gz", "metadata.json", "SHA256SUMS"}.issubset(names):
        raise ValueError("Incomplete release")
    prefix = f"https://github.com/{REPO}/releases/download/{quote(tag, safe='')}/"
    with tempfile.TemporaryDirectory() as temp:
        temp = Path(temp)
        fetch(prefix + "metadata.json", temp / "metadata.json")
        metadata = json.loads((temp / "metadata.json").read_text())
        digest = metadata["archive_sha256"]
        if not re.fullmatch(r"[0-9a-f]{64}", digest):
            raise ValueError("Invalid archive checksum")
        if (metadata["upstream_version"] != version or
            metadata["packaging_revision"] != int(revision) or
            metadata["platform"] != "darwin-arm64" or
            metadata["signature_identifier"] != "com.zereker.xcode" or
            metadata["jit"] is not True):
            raise ValueError("Release metadata mismatch")
        formula = f'''class Xcode < Formula
  desc "Claude Code binary repackaged with the xcode name and local signing"
  homepage "https://github.com/{REPO}"
  url "{prefix}xcode-darwin-arm64.tar.gz"
  version "{version}"
  sha256 "{digest}"
  revision {revision}
  license :cannot_represent

  depends_on :macos
  depends_on arch: :arm64

  def install
    bin.install "xcode"
  end

  test do
    assert_match version.to_s, shell_output("#{{bin}}/xcode --version")
    assert_match "Usage:", shell_output("#{{bin}}/xcode --help")
  end
end
'''
        target = Path("Formula/xcode.rb")
        if target.exists() and target.read_text() == formula:
            print("Formula already current")
            return
        archive = temp / "xcode-darwin-arm64.tar.gz"
        fetch(prefix + archive.name, archive)
        with archive.open("rb") as f:
            actual = hashlib.file_digest(f, "sha256").hexdigest()
        if actual != digest:
            raise ValueError("Downloaded release archive checksum mismatch")
        # Validate tar content without extracting arbitrary paths.
        import tarfile
        with tarfile.open(archive) as tar:
            members = tar.getmembers()
            if len(members) != 1 or members[0].name != "xcode" or not members[0].isfile() or not members[0].mode & 0o111:
                raise ValueError("Unexpected binary archive layout")
        target.parent.mkdir(exist_ok=True)
        target.write_text(formula)
        print(f"Updated xcode formula to {version}, packaging revision {revision}")

if __name__ == "__main__":
    sync()
