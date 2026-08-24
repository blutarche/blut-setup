# Setup: macOS

Dotfiles and config for macOS. Managed via symlinks into this repo. Use Zsh as your login shell.

## Structure (this repo)

See the [README](../README.md#structure) for the layout. macOS uses **Ghostty** and **Yabai** paths below.

## Prerequisites

- Git (Xcode Command Line Tools)

```bash
xcode-select --install || true
```

- [Homebrew](https://brew.sh)

```bash
brew --version
```

## Install

### 1) Clone and init submodules

Required for `fzf-tab`.

```bash
cd "$HOME"
git clone https://github.com/blutarche/blut-setup.git
cd blut-setup
git submodule update --init --recursive
```

### 2) Antidote (plugin manager)

Prefer Homebrew:

```bash
brew install antidote
```

Antidote is expected from Homebrew (see `.zshrc` in `zsh/`).

### 3) CLI dependencies

```bash
brew update
brew install antidote starship zoxide fzf atuin mise navi thefuck fd fastfetch eza bat ripgrep lazygit
```

### 4) Symlinks

```bash
cd /path/to/blut-setup

ln -sf "$(pwd)/zsh/.zshrc" ~/.zshrc
ln -sf "$(pwd)/zsh/.zshenv" ~/.zshenv
mkdir -p ~/.config
ln -sf "$(pwd)/zsh/config" ~/.config/zsh

mkdir -p ~/.config/mise
ln -sf "$(pwd)/mise/config.toml" ~/.config/mise/config.toml
mise trust "$(pwd)/mise/config.toml"   # mise resolves the symlink to its real path; trust it once

ln -sf "$(pwd)/yabai/.yabairc" ~/.yabairc

mkdir -p "$HOME/Library/Application Support/com.mitchellh.ghostty"
ln -sf "$(pwd)/ghostty/config" "$HOME/Library/Application Support/com.mitchellh.ghostty/config"
```

### 5) Restart the shell

```bash
exec zsh -l
```

## Symlink reference (macOS)

| Link | Target |
|------|--------|
| `~/.zshrc` | `blut-setup/zsh/.zshrc` |
| `~/.zshenv` | `blut-setup/zsh/.zshenv` |
| `~/.config/zsh` | `blut-setup/zsh/config` |
| `~/.config/mise/config.toml` | `blut-setup/mise/config.toml` |
| `~/.yabairc` | `blut-setup/yabai/.yabairc` |
| `~/Library/Application Support/com.mitchellh.ghostty/config` | `blut-setup/ghostty/config` |
| `~/Library/Application Support/Cursor/User/settings.json` | `blut-setup/vscode/settings.json` (optional) |

## Verify

```bash
echo "=== Symlinks ===" && \
for link in ~/.zshrc ~/.zshenv ~/.config/zsh ~/.config/mise/config.toml ~/.yabairc; do
  [[ -L "$link" ]] && echo "✓ $link -> $(readlink "$link")" || echo "✗ $link (not a symlink)"
done && \
[[ -L "$HOME/Library/Application Support/com.mitchellh.ghostty/config" ]] && \
  echo "✓ Ghostty config -> $(readlink "$HOME/Library/Application Support/com.mitchellh.ghostty/config")" || \
  echo "✗ Ghostty config (not a symlink)" && \
[[ -L "$HOME/Library/Application Support/Cursor/User/settings.json" ]] && \
  echo "✓ Cursor settings -> $(readlink "$HOME/Library/Application Support/Cursor/User/settings.json")" || \
  echo "✗ Cursor settings (not a symlink — edits in blut-setup won't apply)"
```

## Cursor / VS Code settings

User settings live at `vscode/settings.json` in this repo. Cursor uses the same format on macOS.

### Install into Cursor (copy)

```bash
cd /path/to/blut-setup
mkdir -p "$HOME/Library/Application Support/Cursor/User"

[ -f "$HOME/Library/Application Support/Cursor/User/settings.json" ] && \
  cp "$HOME/Library/Application Support/Cursor/User/settings.json" \
     "$HOME/Library/Application Support/Cursor/User/settings.json.bak.$(date +%Y%m%d-%H%M%S)"

cp "$(pwd)/vscode/settings.json" \
   "$HOME/Library/Application Support/Cursor/User/settings.json"
```

### Symlink instead (optional)

```bash
mkdir -p "$HOME/Library/Application Support/Cursor/User"
ln -sf "$(pwd)/vscode/settings.json" "$HOME/Library/Application Support/Cursor/User/settings.json"
```

### Extensions referenced by settings

- Theme: `Catppuccin Mocha`
- Formatter: `esbenp.prettier-vscode`

Install via Cursor’s Extensions UI.

## Troubleshooting

### Homebrew path (Apple Silicon vs Intel)

Zsh config expects Homebrew in `/opt/homebrew` or `/usr/local`.

### If Zsh fails on first launch

Install missing dependencies, for example:

```bash
brew install antidote starship zoxide fzf atuin mise navi thefuck fd fastfetch eza bat ripgrep lazygit
```

### Yabai

Scripting addition needs SIP-related steps (see yabai documentation). You can symlink `~/.yabairc` now and enable yabai later.
