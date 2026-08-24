# Terminal palette

This is the canonical list of the Catppuccin Mocha terminal palette shared
across this repo's app configs — `ghostty/config`, `superset/catppuccin-mocha.json`,
and `orca/blutarche.yaml` are expected to match it, and any place they intentionally
diverge is recorded below.

## Canonical colours

Values below come from `superset/catppuccin-mocha.json`'s `terminal` block and
`orca/blutarche.yaml`. The two agree on every value except `background` — see
Declared divergences.

| Slot | Superset (`terminal.*`) | Orca (`blutarche.yaml`) |
|---|---|---|
| background | `#000000` | `#0b0b11` |
| foreground | `#cdd6f4` | `#cdd6f4` |
| cursor | `#f5e0dc` | `#f5e0dc` |
| 0 black | `#45475a` | `#45475a` |
| 1 red | `#f38ba8` | `#f38ba8` |
| 2 green | `#a6e3a1` | `#a6e3a1` |
| 3 yellow | `#f9e2af` | `#f9e2af` |
| 4 blue | `#89b4fa` | `#89b4fa` |
| 5 magenta | `#f5c2e7` | `#f5c2e7` |
| 6 cyan | `#94e2d5` | `#94e2d5` |
| 7 white | `#6c7086` | `#6c7086` |
| 8 brightBlack | `#585b70` | `#585b70` |
| 9 brightRed | `#f38ba8` | `#f38ba8` |
| 10 brightGreen | `#a6e3a1` | `#a6e3a1` |
| 11 brightYellow | `#f9e2af` | `#f9e2af` |
| 12 brightBlue | `#fab387` | `#fab387` |
| 13 brightMagenta | `#f5c2e7` | `#f5c2e7` |
| 14 brightCyan | `#94e2d5` | `#94e2d5` |
| 15 brightWhite | `#a6adc8` | `#a6adc8` |

No other mismatches found between the two files.

## Declared divergences

| Colour | Value per file | Reason |
|---|---|---|
| background | `#000000` in `ghostty/config` and `superset/catppuccin-mocha.json`; `#0b0b11` in `orca/blutarche.yaml` | Deliberate: the Orca theme sits just off pure black. |
| brightBlue (index 12) | `#fab387` (Catppuccin peach) instead of a blue, in all three configs (`ghostty/config`'s `palette = 12=...` line, `superset/catppuccin-mocha.json`'s `terminal.brightBlue`, `orca/blutarche.yaml`'s `bright.blue`) | Claude Code renders inline code as ANSI bright blue; peach separates it from prose. |
| white (index 7) | Dimmed to overlay0 `#6c7086` in `superset/catppuccin-mocha.json` (`terminal.white`) and `orca/blutarche.yaml` (`normal.white`) | Claude Code renders file/diff preview content as ANSI white; dimming keeps tool output quieter than answer prose. Ghostty does not share this divergence — see below. |

## Ghostty accuracy caveat

`ghostty/config` does not enumerate the palette. It sets `theme = Catppuccin
Mocha` (Ghostty's builtin theme) and overrides only `background` and
`palette = 12`. Its other 14 colours — including `white` (palette 7) — come
from Ghostty's builtin theme and are not pinned by this repo, so they are not
listed above and this file makes no claim about their values. In particular,
Ghostty's `white` is not dimmed the way Superset's and Orca's are, since
nothing in `ghostty/config` overrides it — the `white` dimming is a
Superset/Orca-only divergence.

## When to revisit

This file is hand-maintained, not generated. If a third config starts
enumerating the full palette, or a colour change needs to land everywhere in
one edit, that's the point to consider a generator plus a drift check.
