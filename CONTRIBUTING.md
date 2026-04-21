# Contributing

## Getting started

```bash
git clone https://github.com/neojelll/Friction.git
cd Friction
mise install
```

Install `luacheck` via your package manager (`brew install luacheck`, `apt install lua-check`, or `luarocks install luacheck`).

## Development workflow

Branch naming: `[<issue>]/<type>/<slug>` — e.g. `42/feat/add-smelting-step`.

Commit messages follow [Conventional Commits](https://www.conventionalcommits.org/): `feat(scope): summary`.

```bash
mise run lint       # check for errors
mise run fmt-check  # check formatting
mise run fmt        # auto-format
```

## Submitting a PR

1. Open a **draft** PR early
2. Make sure lint passes (`mise run lint`)
3. Reference the related issue (`Closes #N`)
4. Mark ready for review when done

## Reporting issues

Use the [issue templates](https://github.com/neojelll/Friction/issues/new/choose). Include Factorio version and mod version.

## Code of conduct

See [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md).
