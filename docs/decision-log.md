# Decision Log

This file records decisions made for this repository.
Each entry should be short, factual, and link to supporting artifacts (issues/PRs/ADRs).

## Format

- YYYY-MM-DD — <Decision> (Owner: @<DRI>) — <link(s)>

## Entries

- 2026-04-21 — Initialized decision log (Owner: @neojelll)
- 2026-04-21 — `crushed-quartz-ore → quartz-sand` uses the Crusher (not a new Grinder machine). Keeps Stage 1 scope tight; a dedicated grinder can be introduced later if the chain needs differentiation. (Owner: @neojelll) — [#34](https://github.com/neojelll/Friction/issues/34)
- 2026-04-21 — All four new quartz-chain recipes (`crushed-quartz-ore`, `crushed-quartz-ore-by-hand`, `quartz-sand`, `glass`) are locked behind `primitive-crushing` technology. Glass smelting is conceptually basic, but the quartz chain is the bottleneck anyway, so locking all steps keeps the tech tree clean. (Owner: @neojelll) — [#34](https://github.com/neojelll/Friction/issues/34)
- 2026-04-21 — Vanilla recipe patches (lab, accumulator, solar-panel, small-lamp, radar) add glass as an additional ingredient rather than replacing existing ones. Preserves playability before glass is available. (Owner: @neojelll) — [#34](https://github.com/neojelll/Friction/issues/34)
