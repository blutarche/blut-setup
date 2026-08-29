# Route these MCP-capable CLIs through this MacBook's local userspace
# Tailscale HTTP proxy. This is intentionally scoped to Claude Code and Codex;
# normal shell commands keep their existing networking path.
_mempalace_tailscale_proxy='http://127.0.0.1:1055'

claude() {
  HTTPS_PROXY="$_mempalace_tailscale_proxy" \
  HTTP_PROXY="$_mempalace_tailscale_proxy" \
  NODE_USE_ENV_PROXY=1 \
  command claude "$@"
}

codex() {
  HTTPS_PROXY="$_mempalace_tailscale_proxy" \
  HTTP_PROXY="$_mempalace_tailscale_proxy" \
  command codex "$@"
}
