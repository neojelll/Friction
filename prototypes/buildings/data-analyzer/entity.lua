data:extend({
  {
    type = "container",
    name = "friction-data-analyzer",
    localised_name = { "entity-name.friction-data-analyzer" },
    localised_description = { "entity-description.friction-data-analyzer" },
    icon = "__Friction__/graphics/icons/buildings/data-analyzer.png",
    icon_size = 64,
    flags = { "placeable-neutral", "placeable-player", "player-creation" },
    minable = { mining_time = 0.5, result = "friction-data-analyzer" },
    max_health = 150,
    corpse = "small-remnants",
    collision_box = { { -0.7, -0.7 }, { 0.7, 0.7 } },
    selection_box = { { -1, -1 }, { 1, 1 } },
    inventory_size = 1,
    picture = {
      filename = "__Friction__/graphics/entity/buildings/data-analyzer.png",
      priority = "extra-high",
      width = 128,
      height = 128,
      scale = 0.5,
    },
  },
})
