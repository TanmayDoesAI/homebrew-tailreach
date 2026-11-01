# homebrew-tailreach

Homebrew tap for [tailreach](https://github.com/TanmayDoesAI/tailreach): your Mac's screen in any browser on your Tailscale tailnet.

```sh
brew install tanmaydoesai/tailreach/tailreach
mydevices setup
```

`mydevices setup` signs the installed copy with a local identity (so macOS keeps the permissions you grant), starts it at login and checks everything. Run it again after each `brew upgrade tailreach`.
