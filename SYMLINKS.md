# Symlinks

This repo uses symlinks so config changes apply immediately on your system. Apply them after cloning.

## Required symlinks

| Link | Target |
|------|--------|
| `~/.zshrc` | `blut-setup/zsh/.zshrc` |
| `~/.zshenv` | `blut-setup/zsh/.zshenv` |
| `~/.config/zsh` | `blut-setup/zsh/config` |
| `~/.config/mise/config.toml` | `blut-setup/mise/config.toml` |
| `~/.yabairc` | `blut-setup/yabai/.yabairc` |
| `~/Library/Application Support/com.mitchellh.ghostty/config` | `blut-setup/ghostty/config` |
| `~/Library/Application Support/Cursor/User/settings.json` | `blut-setup/vscode/settings.json` (optional) |

## Apply all symlinks

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

# Cursor (optional)
mkdir -p "$HOME/Library/Application Support/Cursor/User"
ln -sf "$(pwd)/vscode/settings.json" "$HOME/Library/Application Support/Cursor/User/settings.json"
```

## Cursor settings (copy instead of symlink)

If you prefer not to symlink Cursor settings, copy instead:

```bash
cd /path/to/blut-setup
mkdir -p "$HOME/Library/Application Support/Cursor/User"
cp "$(pwd)/vscode/settings.json" "$HOME/Library/Application Support/Cursor/User/settings.json"
```

## Submodules

After cloning, init the fzf-tab submodule:

```bash
git submodule update --init --recursive
```

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
