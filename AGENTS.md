# AGENTS.md

Multi-machine dotfiles repo. Configs are edited here and take effect live via symlinks (see SYMLINKS.md). Every change must work on a fresh machine, not just this one.

## Invariants

- **Never commit machine-specific or generated files.** No absolute `$HOME`-baked paths, no tool-generated caches. `zsh/config/plugins.zsh` is antidote's generated output (gitignored); `zsh/config/plugins.txt` is the source of truth — edit only the .txt.
- **Guard optional tools.** Anything not guaranteed installed on every machine gets a `command -v <tool> >/dev/null && ...` guard (see direnv in `zsh/.zshrc`).
- **Symlinks make edits live.** Files here are symlinked into place (`~/.yabairc`, `~/.zshrc`, Ghostty config, …). Editing a repo file edits the running system. Adding a new config dir requires a SYMLINKS.md entry (table + apply script + verify block).

## Layout

One directory per tool: `zsh/`, `yabai/`, `ghostty/`, `mise/`, `superset/`, `vscode/`. New zsh utilities go in their own `zsh/config/<name>.zsh` file — `.zshrc` sources every `*.zsh` there automatically (except `exports.zsh`, loaded early, and `plugins.zsh`, loaded by antidote). `zsh/config/fzf-tab` is a git submodule.

## Verifying changes

- zsh: `zsh -ic true` exits 0 and prints no errors.
- yabai: rules apply live without restart — `yabai -m rule --add ... && yabai -m rule --apply`; confirm with `yabai -m rule --list`. Keep `.yabairc` in sync with rules added live.
- Ghostty: reload with cmd+shift+r in a Ghostty window.
- mise: `mise install` after editing `mise/config.toml`.
