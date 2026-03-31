# Environment Variables & PATH

# Base Language Settings
export LANG=en_US.UTF-8

# --- PATH Configuration ---
# Construct PATH by prepending to ensure priority
# Start with system paths if needed, or just let them be
# But usually $PATH already has system stuff. We prepend custom stuff.

# Local Binaries
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
export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

# Rust / Cargo
export PATH="$HOME/.cargo/bin:$PATH"

# Foundry & AVM (Blockchain)
export PATH="$HOME/.foundry/bin:$PATH"
export PATH="$HOME/.avm/bin:$PATH"

# Databases
export PATH="/usr/local/mysql/bin:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# Google Cloud SDK
if [ -f "$HOME/lib/google-cloud-sdk/path.zsh.inc" ]; then
    source "$HOME/lib/google-cloud-sdk/path.zsh.inc"
fi
# Check for alternative install location (Downloads) - User had duplicates
if [ -f "$HOME/Downloads/google-cloud-sdk/path.zsh.inc" ]; then
   source "$HOME/Downloads/google-cloud-sdk/path.zsh.inc"
fi
export PATH="/opt/homebrew/share/google-cloud-sdk/bin:$PATH"

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Solana
export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"

# Antigravity
export PATH="$HOME/.antigravity/antigravity/bin:$PATH"

# Other
export KAFKA="$HOME/app/kafka/bin"
export CPPFLAGS="-I/usr/local/opt/curl/include"
export PATH="/usr/local/opt/curl/bin:$PATH"
export SSH_KEY_PATH="~/.ssh/rsa_id"

# Homebrew
if [ -x "/opt/homebrew/bin/brew" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x "/usr/local/bin/brew" ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# Deno
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# Python (Legacy)
PATH="/Library/Frameworks/Python.framework/Versions/3.13/bin:${PATH}"
export PATH

# Google Cloud SDK
export PATH="/opt/homebrew/share/google-cloud-sdk/bin:$PATH"
