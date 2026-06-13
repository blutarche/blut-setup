# Catppuccin Mocha — Superset theme

Custom appearance theme for the [Superset](https://superset.sh) desktop app
(the multi-agent terminal). Catppuccin Mocha ANSI palette, pure-black
background to match the Ghostty setup, UI surfaces darkened a step.

## Install

1. Open Superset → **Settings → Appearance → Custom Themes**.
2. Click **Import custom theme files** and select
   `catppuccin-mocha.json`.
3. Pick **Catppuccin Mocha** from the theme list.

## Update after editing the JSON

Re-import the file (it dedupes by `id`, so it overwrites in place), then
**re-select the theme** — Superset does not hot-reload an already-active
custom theme.

## Notes

- For colored CLI output (e.g. Claude Code) to follow this palette, set the
  CLI to an ANSI-colors theme. Claude Code: `/theme` → *Dark mode (ANSI
  colors only)*. Otherwise the tool's hardcoded truecolor ignores the palette.
- Imported themes live in Superset's own app state
  (`~/.superset/app-state.json` → `themeState.customThemes`); this repo file is
  just the version-controlled source.
