# blut-setup

Dotfiles and Zsh: **macOS** uses `zsh/` (original layout). **Fedora** uses top-level `zsh-fedora/` so the macOS tree stays untouched. Symlink from this repo on each machine.

## Platform setup

| Platform | Guide |
|----------|--------|
| macOS | [docs/SETUP-macOS.md](./docs/SETUP-macOS.md) — Ghostty, Yabai, Homebrew |
| Linux (Fedora KDE) | [docs/SETUP-Linux.md](./docs/SETUP-Linux.md) — Konsole, `dnf`, no Ghostty/Yabai |

## Structure

```
blut-setup/
├── docs/
│   ├── SETUP-macOS.md   # macOS install & symlinks
│   ├── SETUP-Linux.md   # Fedora KDE (`zsh-fedora/`), Konsole
│   └── PALETTE.md       # canonical terminal palette reference
├── ghostty/
│   └── config
├── zsh/                 # macOS only — unchanged paths
│   ├── .zshrc
│   ├── .zshenv          # sourced by every zsh; mise shims fallback for non-interactive shells
│   └── config/         # modular zsh + fzf-tab submodule
├── zsh-fedora/          # Fedora only — separate tree (reuses zsh/config/fzf-tab)
│   ├── .zshrc
│   └── config/
├── mise/
│   └── config.toml      # mise tool versions + global npm: CLIs (codex, omc, …)
├── orca/                # blutarche theme (Catppuccin Mocha palette) for Orca terminal
├── superset/            # Catppuccin Mocha theme for Superset terminal
├── yabai/
│   └── .yabairc
└── vscode/
```

## Quick start

1. Clone and init submodules (required for `fzf-tab`): see your platform doc.
2. Install dependencies: [SETUP-macOS.md](./docs/SETUP-macOS.md) or [SETUP-Linux.md](./docs/SETUP-Linux.md).
3. Apply symlinks from [SYMLINKS.md](./SYMLINKS.md) or copy commands from the platform guide.

## Cursor / VS Code

`vscode/settings.json` follows the normal Cursor/VS Code user-settings format. Install paths differ by OS; see **SETUP-macOS.md** or **SETUP-Linux.md**.

## Reference

- [SYMLINKS.md](./SYMLINKS.md) — index to platform-specific symlink instructions
- [docs/PALETTE.md](./docs/PALETTE.md) — canonical terminal palette reference

## Dependencies (Zsh stack)

- **Zsh**: Antidote, Starship, Zoxide, fzf, optional: Atuin, Mise, Navi, TheFuck
- **Extras**: fd (or `fdfind` on Fedora), fastfetch, eza, bat, ripgrep, lazygit
- **macOS only**: yabai (`~/.yabairc`), Ghostty config under `~/Library/Application Support/...`
- **Linux (this repo’s doc)**: Konsole — shell config only; terminal theme/profile is local to KDE
