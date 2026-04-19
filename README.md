# Friction

> Realistic production processes. Every reaction has steps, every shortcut has consequences.

A [Factorio 2.0](https://www.factorio.com/) mod that adds friction to production chains by introducing mandatory intermediate processing steps. Raw ore must be crushed before smelting for maximum efficiency — skipping the step is possible, but costly.

## Core mechanic

Every ore can be crushed into a finer form before smelting. Crushing unlocks faster and more efficient recipes:

| Path | Input | Time | Output |
|---|---|---|---|
| Raw smelting | 2× iron ore | 6s | 1× iron plate |
| Crush → smelt | 1× iron ore → 2× crushed → smelt | 2s + 3s | 1× iron plate |

Investing in a Crusher doubles your smelting throughput.

## Content

### Machines

| Machine | Fuel | Purpose |
|---|---|---|
| **Crusher** | Coal | Crushes raw ore into crushed ore (2× output) |

Crafted from: 8 iron plates + 10 stone.

### New items

| Item | Source |
|---|---|
| Crushed Iron Ore | Crusher |
| Crushed Quartz Ore | Crusher |

### New ores

| Ore | Notes |
|---|---|
| Quartz Ore | Spawns on Nauvis. Primary source of silicon (planned). |

## Getting started

1. Craft a **Crusher** (8 iron plates + 10 stone)
2. Place it and fuel it with coal
3. Insert raw ore — the Crusher outputs 2× crushed ore per input
4. Feed crushed ore into a furnace for faster iron plates

## Compatibility

- Requires Factorio `>= 2.0`
- No other mod dependencies

## Development

```bash
# Lint
luacheck .

# Format check
stylua --check .
```

CI runs both checks on every PR. Releases are automated via [release-please](https://github.com/googleapis/release-please) — merging to `main` with conventional commits triggers a version bump and mod portal zip.

## License

[MIT](LICENSE)
