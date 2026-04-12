-- resource.lua
local resource_autoplace = require("resource-autoplace")

local tin_ore = table.deepcopy(data.raw["resource"]["iron-ore"])
tin_ore.name = "tin-ore"
tin_ore.icon = "__Friction__/graphics/icons/ores/tin-ore.png"
tin_ore.icon_size = 64
tin_ore.map_color = { r = 0.42, g = 0.23, b = 0.16 }
tin_ore.stages = {
  sheet = {
    filename = "__Friction__/graphics/icons/ores/tin-ore.png",
    priority = "extra-high",
    width = 64,
    height = 64,
    frame_count = 1,
    variation_count = 1,
    scale = 0.5,
  },
}
tin_ore.stage_counts = { 0 }
tin_ore.stages_effect = nil
tin_ore.minable.result = "tin-ore"
tin_ore.autoplace = resource_autoplace.resource_autoplace_settings({
  name = "tin-ore",
  order = "b",
  base_density = 8,
  base_spots_per_km2 = 1.5,
  has_starting_area_placement = false,
  random_spot_size_minimum = 2,
  random_spot_size_maximum = 4,
})

data:extend({ tin_ore })
