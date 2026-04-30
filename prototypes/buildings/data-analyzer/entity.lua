data:extend({
  -- Main entity: electric-pole so the engine renders the supply-area
  -- square natively on hover and during cursor placement.
  {
    type = "electric-pole",
    name = "friction-data-analyzer",
    localised_name = { "entity-name.friction-data-analyzer" },
    localised_description = { "entity-description.friction-data-analyzer" },
    icon = "__Friction__/graphics/icons/buildings/data-analyzer.png",
    icon_size = 256,
    flags = { "placeable-neutral", "placeable-player", "player-creation" },
    minable = { mining_time = 0.5, result = "friction-data-analyzer" },
    max_health = 150,
    corpse = "small-remnants",
    collision_box = { { -0.7, -0.7 }, { 0.7, 0.7 } },
    selection_box = { { -1, -1 }, { 1, 1 } },
    supply_area_distance = 50,
    maximum_wire_distance = 0,
    connection_range = 0,
    connection_points = { { wire = {}, shadow = {} } },
    pictures = {
      filename = "__Friction__/graphics/entity/buildings/data-analyzer.png",
      priority = "extra-high",
      width = 256,
      height = 256,
      shift = { -0.25 / 32, 6 / 32 },
      scale = 0.5,
      direction_count = 1,
    },
  },
  -- Hidden container placed alongside the pole to hold the 2-slot inventory.
  -- Not selectable; opened programmatically when the player opens the pole.
  {
    type = "container",
    name = "friction-data-analyzer-chest",
    flags = { "not-blueprintable", "not-deconstructable", "not-selectable-in-game", "hidden" },
    collision_box = { { 0, 0 }, { 0, 0 } },
    selection_box = { { 0, 0 }, { 0, 0 } },
    max_health = 1,
    inventory_size = 2,
    picture = {
      filename = "__Friction__/graphics/icons/items/data-card.png",
      width = 64,
      height = 64,
      scale = 0.001,
    },
  },
})
