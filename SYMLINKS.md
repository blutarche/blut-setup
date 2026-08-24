# Symlinks

Configs are symlinked so edits in the repo apply immediately. Exact commands and paths depend on the OS.

## By platform

- **macOS** — `zsh/.zshrc` + `zsh/.zshenv` + `zsh/config/` + `mise/config.toml` (Yabai, Ghostty, Cursor under `~/Library/…`): [docs/SETUP-macOS.md](./docs/SETUP-macOS.md)
- **Fedora KDE** — `zsh-fedora/.zshrc` + `zsh-fedora/config/` + `mise/config.toml` + symlink `~/.config/Cursor/User/settings.json` → `vscode/settings.json`: [docs/SETUP-Linux.md](./docs/SETUP-Linux.md)

## Submodules (all platforms)

After cloning, initialize the `fzf-tab` submodule:

```bash
git submodule update --init --recursive
```
