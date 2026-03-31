# blut-setup

Dotfiles and config for macOS. Managed via symlinks into this repo.

## Structure

```
blut-setup/
├── ghostty/          # Ghostty terminal config
│   └── config
├── zsh/
│   ├── .zshrc        # Main shell config
│   └── config/       # Modular zsh config (aliases, exports, plugins, fzf-tab)
├── yabai/
│   └── .yabairc      # Yabai window manager
└── vscode/           # VS Code settings
```

## Quick start (new Mac)

This assumes macOS with Zsh as your login shell.

### Prereqs

- Git (Xcode Command Line Tools)

```bash
xcode-select --install || true
```

- Homebrew

Install from `https://brew.sh`, then verify:

```bash
brew --version
```

### Install

1) Clone and init submodules (required for `fzf-tab`)

```bash
cd "$HOME"
git clone https://github.com/blutarche/blut-setup.git
cd blut-setup
git submodule update --init --recursive
```

2) Install CLI dependencies

```bash
brew update
brew install antidote starship zoxide fzf atuin mise navi thefuck fd fastfetch eza bat ripgrep lazygit
```

3) Apply symlinks (so changes apply immediately)

```bash
cd /path/to/blut-setup

ln -sf "$(pwd)/zsh/.zshrc" ~/.zshrc
mkdir -p ~/.config
ln -sf "$(pwd)/zsh/config" ~/.config/zsh

ln -sf "$(pwd)/yabai/.yabairc" ~/.yabairc

mkdir -p "$HOME/Library/Application Support/com.mitchellh.ghostty"
ln -sf "$(pwd)/ghostty/config" "$HOME/Library/Application Support/com.mitchellh.ghostty/config"
```

4) Restart your shell

```bash
exec zsh -l
```

### Verify

```bash
echo "=== Symlinks ===" && \
for link in ~/.zshrc ~/.config/zsh ~/.yabairc; do
  [[ -L "$link" ]] && echo "✓ $link -> $(readlink "$link")" || echo "✗ $link (not a symlink)"
done && \
[[ -L "$HOME/Library/Application Support/com.mitchellh.ghostty/config" ]] && \
  echo "✓ Ghostty config -> $(readlink "$HOME/Library/Application Support/com.mitchellh.ghostty/config")" || \
  echo "✗ Ghostty config (not a symlink)"
```

## Cursor / VS Code settings

This repo contains user settings at `vscode/settings.json`. Cursor supports the same format.

### Install into Cursor (copy)

```bash
mkdir -p "$HOME/Library/Application Support/Cursor/User"

# optional backup
[ -f "$HOME/Library/Application Support/Cursor/User/settings.json" ] && \
  cp "$HOME/Library/Application Support/Cursor/User/settings.json" \
     "$HOME/Library/Application Support/Cursor/User/settings.json.bak.$(date +%Y%m%d-%H%M%S)"

cp "$(pwd)/vscode/settings.json" \
   "$HOME/Library/Application Support/Cursor/User/settings.json"
```

### Required extensions/themes referenced by settings

- Theme: `Catppuccin Mocha`
- Formatter: `esbenp.prettier-vscode`

Install them via Cursor’s Extensions UI.

## Notes / troubleshooting

### Homebrew path (Apple Silicon vs Intel)

The Zsh config supports both Homebrew locations:

- Apple Silicon: `/opt/homebrew`
- Intel: `/usr/local`

### If Zsh fails on first launch

Most failures are missing dependencies. Ensure these are installed:

```bash
brew install antidote starship zoxide fzf atuin mise navi thefuck fd fastfetch
```

### Yabai

`yabai` scripting addition requires SIP changes and manual steps (see yabai docs). You can still symlink `~/.yabairc` now and enable later.

## Reference docs

- Symlinks: [SYMLINKS.md](./SYMLINKS.md)

## Dependencies

- **zsh**: Antidote, Starship, Zoxide, fzf, Atuin, Mise, Navi, TheFuck
- **yabai**: Requires SIP parts disabled and `yabai --load-sa` for scripting addition
- **ghostty**: Terminal emulator
