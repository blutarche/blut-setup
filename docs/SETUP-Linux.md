# Setup: Linux (Fedora KDE)

Fedora shell config lives in `zsh-fedora/`. macOS uses `zsh/`.

## Prerequisites

```bash
sudo dnf install -y git zsh
chsh -s "$(command -v zsh)"   # optional; log out after
```

## Install

### 1) Repo and submodule

```bash
cd "$HOME"   # or wherever you keep projects
git clone https://github.com/blutarche/blut-setup.git
cd blut-setup
git submodule update --init --recursive
```

### 2) Antidote

```bash
git clone --depth=1 https://github.com/mattmc3/antidote.git "$HOME/.antidote"
```

### 3) Packages (`dnf`)

```bash
sudo dnf install -y zsh zoxide fzf fd-find ripgrep eza bat fastfetch git
```

`fdfind` comes from package `fd-find`.

### 4) Starship

Not in default repos:

```bash
sudo dnf copr enable atim/starship
sudo dnf install -y starship
```

### 5) Rest of the stack (same things macOS gets from Homebrew)

Install these so `zsh-fedora/.zshrc` matches what you run on the Mac:

```bash
sudo dnf install -y atuin navi
curl https://mise.run | sh
```

**lazygit** is not in the default repos here; put the binary in `~/.local/bin`:

```bash
mkdir -p ~/.local/bin
curl -sL https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_Linux_x86_64.tar.gz | tar xz -C ~/.local/bin lazygit
```

**thefuck** — do not use Fedora’s RPM. Install pip and a user install:

```bash
sudo dnf install -y python3-pip
pip install --user thefuck
```

If `thefuck` still errors on startup, remove it and comment that line in `zsh-fedora/.zshrc`.

### 6) Symlinks

```bash
cd /path/to/blut-setup

ln -sf "$(pwd)/zsh-fedora/.zshrc" ~/.zshrc
mkdir -p ~/.config
ln -sf "$(pwd)/zsh-fedora/config" ~/.config/zsh

mkdir -p ~/.config/mise
ln -sf "$(pwd)/mise/config.toml" ~/.config/mise/config.toml
mise trust "$(pwd)/mise/config.toml"   # mise resolves the symlink to its real path; trust it once
mise install
```

### 7) New shell

```bash
exec zsh -l
```

## Cursor

`~/.config/Cursor/User/settings.json` should be a **symlink** to this repo (same idea as zsh):

```bash
cd ~/proj/blut-setup   # or your clone path

mkdir -p "$HOME/.config/Cursor/User"
tgt="$HOME/.config/Cursor/User/settings.json"
[ -e "$tgt" ] && [ ! -L "$tgt" ] && mv "$tgt" "$tgt.bak.$(date +%Y%m%d%H%M%S)"
ln -sf "$(pwd)/vscode/settings.json" "$tgt"
```

Restart Cursor after changing this.

## Symlinks

| Link | Target |
|------|--------|
| `~/.zshrc` | `blut-setup/zsh-fedora/.zshrc` |
| `~/.config/zsh` | `blut-setup/zsh-fedora/config` |
| `~/.config/mise/config.toml` | `blut-setup/mise/config.toml` |
| `~/.config/Cursor/User/settings.json` | `blut-setup/vscode/settings.json` |

## Verify

```bash
for link in ~/.zshrc ~/.config/zsh ~/.config/mise/config.toml ~/.config/Cursor/User/settings.json; do
  [[ -L "$link" ]] && echo "ok $link" || echo "missing $link"
done
```

## Troubleshooting

- **`starship` not found in dnf** — step 4 (COPR first).
- **Antidote missing** — step 2.
- **`fdfind` missing** — `sudo dnf install fd-find`.
- **Garbage commands after startup** — `rm -rf ~/.cache/antidote` then `exec zsh -l`.
- **`thefuck` / distutils** — `sudo dnf remove thefuck`; use `pip install --user thefuck` (step 5) or comment it out in `zsh-fedora/.zshrc`.
