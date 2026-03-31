# --- Zsh Cache Fix ---
# Set ZSH_CACHE_DIR for OMZ plugins
export ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/oh-my-zsh"
if [[ ! -d "$ZSH_CACHE_DIR/completions" ]]; then
  mkdir -p "$ZSH_CACHE_DIR/completions"
fi

# Stub compdef to prevent plugin errors before completion init
compdef() { true; }

# --- Environment (Load First) ---
# Ensure PATH and critical variables are set early
source "${ZDOTDIR:-$HOME}/.config/zsh/exports.zsh"

# --- Interactive Shell Guard ---
# If not running interactively, stop here.
[[ $- != *i* ]] && return

# --- Antidote Plugin Manager (Load Plugins First) ---
if command -v brew >/dev/null 2>&1; then
  source "$(brew --prefix antidote)/share/antidote/antidote.zsh"
else
  source /usr/local/opt/antidote/share/antidote/antidote.zsh
fi
antidote load ${ZDOTDIR:-$HOME}/.config/zsh/plugins.txt

# --- Modular Configuration ---
# Source aliases and functions
for config_file in $HOME/.config/zsh/*.zsh; do
  # Skip exports.zsh (already loaded) and plugins.txt
  [[ "$config_file" == */exports.zsh ]] && continue
  source "$config_file"
done

# --- Starship Prompt ---
eval "$(starship init zsh)"

# --- Completion System (Must run AFTER plugins add path, BEFORE fzf-tab) ---
autoload -U compinit
compinit -d "$ZSH_CACHE_DIR/zcompdump-${ZSH_VERSION}"
# Unset the stub now that real compdef is loaded (by plugins or compinit)
unset -f compdef

# --- Manual Plugin Loading (Order Sensitive) ---
# FZF-Tab (Must be after compinit)
source ~/.config/zsh/fzf-tab/fzf-tab.plugin.zsh

# --- Modern Tools ---
# Zoxide (smarter cd)
eval "$(zoxide init zsh)"

# TheFuck (command correction)
eval "$(thefuck --alias)"

# FZF (Fuzzy Finder)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source <(fzf --zsh)

# FZF Configuration (Use fd for speed & respecting .gitignore)
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Atuin (Magical Shell History)
eval "$(atuin init zsh)"

# Mise (Version Manager - replaces nvm, pyenv, etc)
eval "$(mise activate zsh)"

# Dashboard on start
fastfetch

# Navi (Cheatsheets) - Ctrl+G to launch
eval "$(navi widget zsh)"

