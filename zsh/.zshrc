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

# --- Antidote Plugin Manager (static bundle; only invoke antidote when plugins.txt changes) ---
_plugins_txt="${ZDOTDIR:-$HOME}/.config/zsh/plugins.txt"
_plugins_bundle="${ZDOTDIR:-$HOME}/.config/zsh/plugins.zsh"
if [[ ! -f "$_plugins_bundle" || "$_plugins_txt" -nt "$_plugins_bundle" ]]; then
  if command -v brew >/dev/null 2>&1; then
    source "$(brew --prefix antidote)/share/antidote/antidote.zsh"
  else
    source /usr/local/opt/antidote/share/antidote/antidote.zsh
  fi
  antidote bundle <"$_plugins_txt" >|"$_plugins_bundle"
  # Byte-compile the bundle and everything it sources — zsh prefers a newer
  # .zwc transparently, cutting zsh-syntax-highlighting/autosuggestions parse time.
  zcompile "$_plugins_bundle" 2>/dev/null
  while IFS= read -r _src; do
    _src=${(e)_src}
    [[ -f "$_src" ]] || continue
    zcompile "$_src" 2>/dev/null
  done < <(grep -oE '^source "[^"]+"' "$_plugins_bundle" | sed -E 's/^source "//; s/"$//')
  unset _src
fi
# is-at-least used to be autoloaded as a side effect of the (now removed) git
# plugin; the docker plugin also depends on it (in a backgrounded `&|` block,
# which forks before any code placed after `source` below would run), so
# autoload it explicitly first.
autoload -Uz is-at-least
source "$_plugins_bundle"
unset _plugins_txt _plugins_bundle

# --- Modular Configuration ---
# Source aliases and functions
for config_file in $HOME/.config/zsh/*.zsh; do
  # Skip exports.zsh (already loaded) and plugins.zsh (antidote's generated cache — already loaded by antidote load)
  [[ "$config_file" == */exports.zsh ]] && continue
  [[ "$config_file" == */plugins.zsh ]] && continue
  source "$config_file"
done

# --- Starship Prompt ---
_cached_init starship starship init zsh

# --- Completion System (Must run AFTER plugins add path, BEFORE fzf-tab) ---
# Skip the full security audit/rebuild unless the dump is >24h old or missing.
autoload -Uz compinit
_dump="$ZSH_CACHE_DIR/zcompdump-${ZSH_VERSION}"
if [[ -n "$_dump"(#qN.mh+24) ]]; then
  compinit -C -d "$_dump"
else
  compinit -d "$_dump"
fi
[[ -f "$_dump" && ( ! -f "$_dump.zwc" || "$_dump" -nt "$_dump.zwc" ) ]] && zcompile "$_dump" 2>/dev/null &!
unset _dump
# Unset the stub now that real compdef is loaded (by plugins or compinit)
unset -f compdef

# --- Manual Plugin Loading (Order Sensitive) ---
# FZF-Tab (Must be after compinit)
_fzt=~/.config/zsh/fzf-tab/fzf-tab.plugin.zsh
[[ -f "$_fzt" && ( ! -f "$_fzt.zwc" || "$_fzt" -nt "$_fzt.zwc" ) ]] && zcompile "$_fzt" 2>/dev/null
source "$_fzt"
unset _fzt

# --- Modern Tools ---
# Zoxide (smarter cd)
_cached_init zoxide zoxide init zsh

# TheFuck (command correction) — lazy: pay its python startup cost only on first real use
fuck() {
  unfunction fuck
  eval "$(thefuck --alias)"
  fuck "$@"
}

# --- FZF (Fuzzy Finder) ---
if [[ -t 0 && -t 1 ]]; then
  _cached_init fzf fzf --zsh
fi

# FZF Configuration (Use fd for speed & respecting .gitignore)
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Atuin (Magical Shell History)
_cached_init atuin atuin init zsh

# Mise (Version Manager - replaces nvm, pyenv, etc)
# --shims: no per-prompt hook (was costing 90-200ms on EVERY prompt, not just startup);
# version resolution happens lazily inside the shim when a managed tool actually runs.
_cached_init mise mise activate zsh --shims

# Navi (Cheatsheets) - Ctrl+G to launch
_cached_init navi navi widget zsh

# Direnv (per-project env via .envrc) — guarded: not every machine has it installed
command -v direnv >/dev/null 2>&1 && _cached_init direnv direnv hook zsh

_cached_init_flush

# Tool initializers can append paths after exports.zsh; remove duplicates once.
path=($path)
