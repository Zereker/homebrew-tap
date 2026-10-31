# Homebrew Tap for Stepcode

This tap will provide the macOS ARM64 Stepcode formula after a verified Stepcode release is published.

Once available:

```sh
brew install Zereker/tap/stepcode
brew upgrade stepcode
```

Do not use the earlier incomplete Zcode binary release as a Stepcode package.

## xcode

macOS Apple Silicon build of Claude Code, repackaged with the command name
`xcode`, signing identifier `com.zereker.xcode` and JIT entitlement.

```sh
brew install Zereker/tap/xcode
brew upgrade xcode
```

[Releases](https://github.com/Zereker/xcode/releases) are built daily from the
official stable channel. This tap checks releases hourly, verifies the archive
checksum and layout, and commits the formula only when it changes. It does not
alter the Stepcode formula. Both workflows also support manual runs.

If `~/.local/bin/xcode` already exists, it may take precedence over Homebrew.
Use `which -a xcode` to see which installation runs. Keep the older standalone
binary as a backup until you have tested the Homebrew installation.
