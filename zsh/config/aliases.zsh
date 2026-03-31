# Aliases

# Zsh
alias rezsh="source ~/.zshrc"
alias execz="exec zsh"
alias zconf="code ~/.config/zsh"

# Shortcuts
alias k="kubectl"
alias d="docker"
alias dc="docker compose"
alias py="python"
alias py3="python3"
alias y="yarn"
alias yz="yazi"

# Git
alias g="git"
alias gf="git fetch"
alias gpull="git pull"
alias gpush="git push"
alias gc="git commit"
alias gb="git branch"
alias gck="git checkout"
alias gckb="git checkout -b"
alias gst="git status"
alias gd="git diff"
alias gl="git log --oneline --graph --decorate --all"

# Editor
alias code="cursor"

# Modern Replacements
if command -v eza >/dev/null 2>&1; then
  alias ls="eza --icons --group-directories-first"
  alias ll="eza -la --icons --group-directories-first --git"
fi
if command -v bat >/dev/null 2>&1; then
  alias cat="bat"
fi
if command -v lazygit >/dev/null 2>&1; then
  alias lg="lazygit"
fi
if command -v rg >/dev/null 2>&1; then
  alias grep="rg"
fi
