# Design

## Concept

Friction modifies Factorio's production pipeline by adding intermediate processing steps to raw resources. The core idea: every shortcut has a cost, and investing in proper processing pays off in throughput.

## Repository layout

```
Friction/
├── info.json                        # mod metadata: name, version, dependencies
├── data.lua                         # data stage entry point — loads everything in order
├── locale/
│   ├── en/friction.cfg              # English strings
│   └── ru/friction.cfg              # Russian strings
├── graphics/
│   ├── icons/                       # item and entity icons (64×64 PNG)
│   └── entity/                      # in-world entity sprites
├── prototypes/
│   ├── categories/                  # recipe categories
│   ├── ores/                        # new minable resources and their map gen
│   ├── items/
│   │   ├── crushed-ores/            # intermediate processed ore items
│   │   └── plates/                  # modified/extended plate recipes
│   └── buildings/                   # placeable machines
└── docs/                            # design and architecture docs
```

## Data stage load order

`data.lua` is the single entry point. It requires everything in dependency order:

```lua
require("prototypes.categories.crushing")   -- 1. categories must exist before recipes
require("prototypes.ores.generator")         -- 2. new ores (items + resources + autoplace)
require("prototypes.items.crushed-ores.iron.data")  -- 3. intermediate items + recipes
require("prototypes.items.plates.iron.data")         -- 4. modified end-product recipes
require("prototypes.buildings.data")         -- 5. machines that use the categories
```

Order matters: recipe categories must be registered before any recipe references them.

## Prototype conventions

### Ores

Each ore is defined as a plain table in `prototypes/ores/data.lua` and processed by factory functions in the same directory:

```
ores/
├── data.lua       # list of ore definitions (name, icon, color, autoplace params)
├── generator.lua  # iterates definitions, calls each factory, calls data:extend()
├── item.lua       # M.make(def) → item prototype
├── resource.lua   # M.make(def) → resource prototype (mineable entity on map)
└── control.lua    # M.make(def) → autoplace-control prototype (map gen settings UI)
```

To add a new ore: add one entry to `prototypes/ores/data.lua`. The generator handles the rest automatically.

### Intermediate items (crushed ores)

Each crushed ore lives in its own subdirectory:

```
items/crushed-ores/
├── <ore-name>/
│   ├── item.lua    # the item prototype
│   └── recipe.lua  # the crushing recipe (category: "crushing")
└── <ore-name>/data.lua  # requires item.lua and recipe.lua
```

Crushing recipes use the `crushing` category — they can only be processed in the Crusher machine, not by hand.

### Modified recipes (plates)

Base game recipes that need to be altered live in `prototypes/items/plates/`:

```
items/plates/
└── <material>/
    ├── recipe.lua  # overwrites data.raw recipe + adds alternative recipe
    └── data.lua    # requires recipe.lua
```

The pattern: slow down the raw recipe, add a faster alternative that consumes the crushed intermediate.

### Buildings (machines)

Each machine has three files:

```
buildings/
└── <machine>/
    ├── entity.lua  # the placeable entity prototype
    ├── item.lua    # the inventory item that places the entity
    └── recipe.lua  # how to craft the item
```

`buildings/data.lua` requires all three for each machine.

## Recipe categories

Custom categories are defined in `prototypes/categories/` and registered before any recipe that uses them. Current categories:

| Category | Used by |
|---|---|
| `crushing` | All crushing recipes — only the Crusher machine can process them |

## Localisation

All strings live in `locale/<lang>/friction.cfg`. Every prototype that has a name visible to the player needs an entry. Sections:

- `[item-name]` — display name for items
- `[recipe-name]` — display name for recipes (shown in crafting UI)
- `[entity-name]` — display name for placeable entities
- `[entity-description]` — tooltip shown on hover

Missing locale strings show up in-game as `[item-name.foo-bar]`. After adding any prototype, update both `en` and `ru`.

## Graphics

| Path | Content | Format |
|---|---|---|
| `graphics/icons/<category>/` | Item and entity icons | 64×64 PNG |
| `graphics/entity/<category>/` | In-world entity sprites | PNG sprite sheet |

Icon files are referenced directly in prototype definitions via `__Friction__/graphics/...`.

## Adding new content

### New ore

1. Add definition to `prototypes/ores/data.lua`
2. Add graphics: icon + entity sprite sheet
3. Add locale entries in `en` and `ru`

### New crushed ore

1. Create `prototypes/items/crushed-ores/<ore-name>/item.lua` and `recipe.lua`
2. Add `data.lua` in the same folder that requires both
3. Require the new `data.lua` from `prototypes/items/crushed-ores/<parent>/data.lua` or wire directly in `data.lua`
4. Add icon to `graphics/icons/items/crushed-ores/`
5. Add locale entries

### New machine

1. Create `prototypes/buildings/<machine>/entity.lua`, `item.lua`, `recipe.lua`
2. Require all three from `prototypes/buildings/data.lua`
3. Add sprites to `graphics/`
4. Add locale entries
