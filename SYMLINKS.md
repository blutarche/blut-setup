# Symlinks

This repo uses symlinks so config changes apply immediately on your system. Apply them after cloning.

## Required symlinks

| Link | Target |
|------|--------|
| `~/.zshrc` | `blut-setup/zsh/.zshrc` |
| `~/.config/zsh` | `blut-setup/zsh/config` |
| `~/.yabairc` | `blut-setup/yabai/.yabairc` |
| `~/Library/Application Support/com.mitchellh.ghostty/config` | `blut-setup/ghostty/config` |
| `~/Library/Application Support/Cursor/User/settings.json` | `blut-setup/vscode/settings.json` (optional) |

## Apply all symlinks

```bash
cd /path/to/blut-setup

ln -sf "$(pwd)/zsh/.zshrc" ~/.zshrc
mkdir -p ~/.config
ln -sf "$(pwd)/zsh/config" ~/.config/zsh
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
for link in ~/.zshrc ~/.config/zsh ~/.yabairc; do
  [[ -L "$link" ]] && echo "✓ $link -> $(readlink "$link")" || echo "✗ $link (not a symlink)"
done && \
[[ -L "$HOME/Library/Application Support/com.mitchellh.ghostty/config" ]] && \
  echo "✓ Ghostty config -> $(readlink "$HOME/Library/Application Support/com.mitchellh.ghostty/config")" || \
  echo "✗ Ghostty config (not a symlink)"
```
