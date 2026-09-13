# Cache `eval "$(tool init ...)"` output so the tool binary isn't forked on
# every shell start; regenerates when the binary's mtime changes. Calls queue
# their cache file — _cached_init_flush sources them all in one merged file,
# since `source` has fixed per-call overhead regardless of file size.
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
  local f rebuild=0
  [[ -f "$merged" ]] || rebuild=1
  for f in "${_cached_init_files[@]}"; do
    [[ "$f" -nt "$merged" ]] && rebuild=1
  done
  if (( rebuild )); then
    cat "${_cached_init_files[@]}" >| "$merged"
    zcompile "$merged" 2>/dev/null
  fi
  source "$merged"
  unset _cached_init_files
}
