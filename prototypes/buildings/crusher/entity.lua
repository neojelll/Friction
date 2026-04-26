data:extend({
  {
    type = "furnace",
    name = "friction-crusher",
    icon = "__Friction__/graphics/icons/buildings/crusher.png",
    icon_size = 64,
    flags = { "placeable-neutral", "placeable-player", "player-creation" },
    minable = { mining_time = 0.5, result = "friction-crusher" },
    max_health = 200,
    corpse = "medium-remnants",
    collision_box = { { -1.7, -0.7 }, { 1.7, 0.7 } },
    selection_box = { { -1.8, -1 }, { 1.8, 1 } },
    crafting_categories = { "crushing" },
    result_inventory_size = 1,
    source_inventory_size = 1,
    energy_usage = "90kW",
    crafting_speed = 1,
    energy_source = {
      type = "burner",
      fuel_categories = { "chemical" },
      effectivity = 1,
      fuel_inventory_size = 1,
      emissions_per_minute = { pollution = 4 },
      smoke = {
        {
          name = "smoke",
          deviation = { 0.1, 0.1 },
          frequency = 5,
          position = { 0.0, -0.8 },
          starting_vertical_speed = 0.08,
          starting_frame_deviation = 60,
        },
      },
    },
    graphics_set = {
      animation = {
        layers = {
          {
            filename = "__Friction__/graphics/entity/buildings/crusher.png",
            priority = "extra-high",
            width = 256,
            height = 256,
            shift = { -0.25 / 32, 6 / 32 },
            scale = 0.5,
          },
        },
      },
    },
  },
})
