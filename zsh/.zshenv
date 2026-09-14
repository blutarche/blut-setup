# ~/.zshenv — sourced by EVERY zsh invocation (login, interactive, and
# non-interactive `zsh -c` scripts / IDE- and tool-spawned shells).
#
# Put mise's shims dir on PATH as a fallback so mise-managed tools
# (node, npm, pnpm, yarn, go, codex, omc, …) resolve everywhere — including
# the non-interactive shells that never source .zshrc, where `mise activate`
# (in .zshrc) does not run.
#
# Interactive shells also run `mise activate zsh --shims` in .zshrc (same
# shims mechanism, no per-prompt hook — that hook cost 90-200ms on every
# prompt). This file is the fallback for non-interactive shells that never
# source .zshrc. See https://mise.jdx.dev/dev-tools/shims.html
if [[ -d "$HOME/.local/share/mise/shims" \
      && ":$PATH:" != *":$HOME/.local/share/mise/shims:"* ]]; then
  export PATH="$HOME/.local/share/mise/shims:$PATH"
fi

# Hermes' launcher uses /usr/bin/env python3; prefer its own compatible venv.
if [[ -x "$HOME/.hermes/hermes-agent/venv/bin/python3" ]]; then
  export PATH="$HOME/.hermes/hermes-agent/venv/bin:$PATH"
fi

# Expose the MemPalace MCP bearer token to terminal-launched clients.
# Read the owner-only Hermes secret file once; never store its contents here.
if [[ -r "$HOME/.hermes/.env" ]]; then
  typeset -i _mempalace_token_seen=0 _mempalace_atrium_seen=0
  while IFS= read -r _mempalace_line; do
    case "$_mempalace_line" in
      MEMPALACE_MCP_TOKEN=*)
        if (( !_mempalace_token_seen )); then
          export MEMPALACE_MCP_TOKEN="${_mempalace_line#*=}"
          _mempalace_token_seen=1
        fi
        ;;
      MCP_MEMPALACE_API_KEY=*)
        if [[ -z "${MEMPALACE_ATRIUM_TOKEN:-}" && $_mempalace_atrium_seen -eq 0 ]]; then
          export MEMPALACE_ATRIUM_TOKEN="${_mempalace_line#*=}"
          _mempalace_atrium_seen=1
        fi
        ;;
    esac
  done < "$HOME/.hermes/.env"
  unset _mempalace_line _mempalace_token_seen _mempalace_atrium_seen
fi

# >>> mempalace-mcp-env >>>
if [[ -n "${MEMPALACE_ATRIUM_TOKEN:-}" && -z "${MEMPALACE_MCP_TOKEN:-}" ]]; then
  export MEMPALACE_MCP_TOKEN="$MEMPALACE_ATRIUM_TOKEN"
fi

# Keep inherited PATH entries unique for every zsh invocation.
typeset -U path
# <<< mempalace-mcp-env <<<
