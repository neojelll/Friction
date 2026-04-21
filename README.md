# Friction

[![Factorio](https://img.shields.io/badge/Factorio-2.0-orange)](https://www.factorio.com/)
[![License](https://img.shields.io/badge/license-MIT-blue)](LICENSE)
[![CI](https://github.com/neojelll/Friction/actions/workflows/lint.yaml/badge.svg)](https://github.com/neojelll/Friction/actions/workflows/lint.yaml)

> Realistic production processes. Every reaction has steps, every shortcut has consequences.

A Factorio 2.0 mod that adds friction to production chains by introducing mandatory intermediate processing steps. Raw resources require additional preparation before use — taking shortcuts is possible, but inefficient.

## Installation

Download from the [Factorio Mod Portal](https://mods.factorio.com/) or place the mod folder into your Factorio `mods/` directory.

**Requirements:** Factorio `>= 2.0`

## Development

Install [mise](https://mise.jdx.dev/), then:

```bash
mise install  # installs stylua
```

Install `luacheck` via your package manager (`brew install luacheck`, `apt install lua-check`, or `luarocks install luacheck`).

```bash
mise run lint       # luacheck linter
mise run fmt        # format with stylua
mise run fmt-check  # check formatting without modifying files
```

Releases are automated via [release-please](https://github.com/googleapis/release-please).

## License

[MIT](LICENSE)
