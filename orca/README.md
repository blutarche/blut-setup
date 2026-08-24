# blutarche — Orca theme

Terminal theme for the [Orca](https://orca.computer) desktop app (Superset's
successor), in Warp YAML format. Same Catppuccin Mocha palette as the Ghostty
setup (`ghostty/config`) and the Superset theme (`superset/`), except the
background: `#0b0b11` here, a near-black roughly halfway to Catppuccin crust
(`#11111b`), instead of the pure `#000000` those two use — a deliberate
divergence, not drift.

## Install

1. Open Orca → **Settings → Appearance** → Terminal Themes → **Import from YAML**.
2. Choose `orca/blutarche.yaml`.
3. Under the Dark Theme selector, pick **blutarche** from the
   "imported" group (labelled Warp).

## Update after editing the YAML

Re-import the file — Orca ids the theme by name plus a hash of the source
file path, so re-importing the same path overwrites in place, but renaming
the file or importing a copy from elsewhere adds a duplicate entry instead
— then **re-select the theme** in the Dark Theme selector.

## What didn't carry over from the Superset theme

Orca has no custom UI theme, unlike Superset. Its app-level appearance is
just **Settings → Appearance** → Dark/Light/System, plus a few discrete
knobs — `appFontFamily`, `appIcon`, a left-sidebar tint (an 8%-opacity
overlay, not a background colour). None of that reads the Catppuccin `ui`
block from the Superset theme; there's no equivalent to import. The closest
hand-set match worth knowing: Appearance → Terminal Themes → **Dark Divider Color**
(`terminalDividerColorDark`, Orca default `#3f3f46`) can be set to
Catppuccin surface1 (`#313244`) to match the Superset theme's `border`.

`editor.syntax.comment` also has no Orca equivalent.

The Warp YAML format has no field for selection colours or cursor accent,
so `selectionBackground` and `cursorAccent` from the Superset theme are
dropped — Orca's YAML importer simply can't reach them. The only path to
those in Orca is **Settings → Appearance → Import from Ghostty**, which reads
a Ghostty config and writes a global colour-override layer
(`terminalColorOverrides`) on top of whichever theme is selected, rather
than a named theme. It also pulls across non-colour settings it recognises
(opacity, padding, line height, divider colour) — the import modal lists
what it will change. Since this repo already ships `ghostty/config` with the
same palette, that's a viable alternative if you want selection/cursor-accent
colours too.

## Notes

- For colored CLI output (e.g. Claude Code) to follow this palette, set the
  CLI to an ANSI-colors theme. Claude Code: `/theme` → *Dark mode (ANSI
  colors only)*. Otherwise the tool's hardcoded truecolor ignores the palette.
- `bright.blue` and `normal.white` are intentionally remapped from the stock
  Catppuccin values; see [docs/PALETTE.md](../docs/PALETTE.md) for the
  canonical palette and the reasons for both divergences.
- Imported themes live in Orca's own app state
  (`~/.config/orca/profiles/<profile>/orca-data.json` →
  `settings.terminalCustomThemes`); this repo file is just the
  version-controlled source. There's no symlink for it — import-based, same
  as Superset — so no SYMLINKS.md entry is needed.
