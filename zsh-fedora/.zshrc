# Fedora Zsh — keep macOS `zsh/` untouched. Symlink:
#   ~/.zshrc  →  blut-setup/zsh-fedora/.zshrc
#   ~/.config/zsh  →  blut-setup/zsh-fedora/config
# Submodules: clone repo and `git submodule update --init` (fzf-tab lives under zsh/config/).

# --- Zsh Cache Fix ---
export ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/oh-my-zsh"
if [[ ! -d "$ZSH_CACHE_DIR/completions" ]]; then
  mkdir -p "$ZSH_CACHE_DIR/completions"
fi

compdef() { true; }

source "${ZDOTDIR:-$HOME}/.config/zsh/exports.zsh"

[[ $- != *i* ]] && return

# Antidote (~/.antidote)
if [[ ! -f "$HOME/.antidote/antidote.zsh" ]]; then
  echo 'zsh: antidote missing — git clone --depth=1 https://github.com/mattmc3/antidote.git "$HOME/.antidote"' >&2
  return 1
fi
source "$HOME/.antidote/antidote.zsh"
antidote load "${ZDOTDIR:-$HOME}/.config/zsh/plugins.txt"

for config_file in "${ZDOTDIR:-$HOME}/.config/zsh"/*.zsh; do
  [[ "$config_file" == */exports.zsh ]] && continue
  source "$config_file"
done

command -v starship >/dev/null 2>&1 && eval "$(starship init zsh)"

autoload -U compinit
compinit -d "$ZSH_CACHE_DIR/zcompdump-${ZSH_VERSION}"
unset -f compdef

_zfed="${${(%):-%x}:A:h}"
source "$_zfed/../zsh/config/fzf-tab/fzf-tab.plugin.zsh"
unset _zfed

command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh)"
command -v thefuck >/dev/null 2>&1 && eval "$(thefuck --alias 2>/dev/null)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh)
  if command -v fdfind >/dev/null 2>&1; then
    export FZF_DEFAULT_COMMAND='fdfind --type f --strip-cwd-prefix --hidden --follow --exclude .git'
  else
    export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
  fi
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

command -v atuin >/dev/null 2>&1 && eval "$(atuin init zsh)"
command -v mise >/dev/null 2>&1 && eval "$(mise activate zsh)"
command -v fastfetch >/dev/null 2>&1 && fastfetch
command -v navi >/dev/null 2>&1 && eval "$(navi widget zsh)"

# pnpm
export PNPM_HOME="/home/blut/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end
