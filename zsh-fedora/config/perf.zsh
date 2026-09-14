# Cache `eval "$(tool init ...)"` output so tool binaries are not forked on
# every shell start. Calls queue their cache file and source one merged file.
typeset -ga _cached_init_files

_cached_init() {
  local name=$1; shift
  local bin cache
  bin=$commands[$1]
  [[ -n "$bin" ]] || return
  cache="$ZSH_CACHE_DIR/init-${name}.zsh"
  if [[ ! -f "$cache" || "$bin" -nt "$cache" ]]; then
    "$@" >| "$cache" 2>/dev/null
  fi
  _cached_init_files+=("$cache")
}

_cached_init_flush() {
  local merged="$ZSH_CACHE_DIR/init-merged.zsh"
  local manifest="$ZSH_CACHE_DIR/init-merged.list"
  local current_manifest="${(j:\n:)_cached_init_files}"
  local f rebuild=0
  [[ -f "$merged" ]] || rebuild=1
  [[ -f "$manifest" ]] || rebuild=1
  [[ -f "$manifest" && "$(<"$manifest")" != "$current_manifest" ]] && rebuild=1
  for f in "${_cached_init_files[@]}"; do
    [[ "$f" -nt "$merged" ]] && rebuild=1
  done
  if (( rebuild )); then
    cat "${_cached_init_files[@]}" >| "$merged"
    print -r -- "$current_manifest" >| "$manifest"
    zcompile "$merged" 2>/dev/null
  fi
  source "$merged"
  unset _cached_init_files
}
