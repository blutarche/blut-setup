# ~/.zshenv — sourced by EVERY zsh invocation (login, interactive, and
# non-interactive `zsh -c` scripts / IDE- and tool-spawned shells).
#
# Put mise's shims dir on PATH as a fallback so mise-managed tools
# (node, npm, pnpm, yarn, go, codex, omc, …) resolve everywhere — including
# the non-interactive shells that never source .zshrc, where `mise activate`
# (in .zshrc) does not run.
#
# Interactive shells then run `mise activate zsh` in .zshrc, which REMOVES this
# shims entry and replaces it with full PATH/env/hook activation — so real
# install dirs win interactively and shims are only the fallback. The two are
# designed to compose. See https://mise.jdx.dev/dev-tools/shims.html
if [[ -d "$HOME/.local/share/mise/shims" \
      && ":$PATH:" != *":$HOME/.local/share/mise/shims:"* ]]; then
  export PATH="$HOME/.local/share/mise/shims:$PATH"
fi

# Expose only the MemPalace MCP bearer token to terminal-launched MCP clients.
# The token itself remains in the owner-only Hermes secret file.
if [[ -r "$HOME/.hermes/.env" ]]; then
  while IFS= read -r line; do
    if [[ "$line" == MEMPALACE_MCP_TOKEN=* ]]; then
      export MEMPALACE_MCP_TOKEN="${line#*=}"
      break
    fi
  done < "$HOME/.hermes/.env"
fi
