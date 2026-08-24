# Environment variables & PATH (Fedora / Linux — zsh-fedora)

export LANG=en_US.UTF-8

export PATH="$HOME/.local/bin:$PATH"

# Go
export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
export GO111MODULE=on
export PATH="$GOBIN:$PATH"

# Node.js / NPM / Yarn
export PATH="$HOME/.npm/bin:$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# PNPM
export PNPM_HOME="${PNPM_HOME:-$HOME/.local/share/pnpm}"
export PATH="$PNPM_HOME:$PATH"

# Rust / Cargo
export PATH="$HOME/.cargo/bin:$PATH"

# Foundry & AVM (Blockchain)
export PATH="$HOME/.foundry/bin:$PATH"
export PATH="$HOME/.avm/bin:$PATH"

# Google Cloud SDK (user-managed installs)
if [[ -f "$HOME/lib/google-cloud-sdk/path.zsh.inc" ]]; then
  source "$HOME/lib/google-cloud-sdk/path.zsh.inc"
fi
if [[ -f "$HOME/Downloads/google-cloud-sdk/path.zsh.inc" ]]; then
  source "$HOME/Downloads/google-cloud-sdk/path.zsh.inc"
fi

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Solana
export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"

# Antigravity
export PATH="$HOME/.antigravity/antigravity/bin:$PATH"

# Other
export KAFKA="$HOME/app/kafka/bin"
export SSH_KEY_PATH="~/.ssh/rsa_id"

# Deno
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

export PATH

[[ -d "$HOME/.lmstudio/bin" ]] && export PATH="$PATH:$HOME/.lmstudio/bin"
