-- resource.lua
local resource_autoplace = require("resource-autoplace")

local tin_item = table.deepcopy(data.raw["resource"]["iron-ore"])
tin_item.name = "tin-ore"
tin_item.icon = "__Friction__/graphics/icons/ores/tin-ore.png"
tin_item.icon_size = 64
tin_item.stages = {
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
tin_item.stage_counts = { 0 }
tin_item.stages_effect = nil
tin_item.minable.result = "tin-ore"
tin_item.autoplace = resource_autoplace.resource_autoplace_settings({
  name = "tin-ore",
  order = "b",
  base_density = 8,
  base_spots_per_km2 = 1.5,
  has_starting_area_placement = false,
  random_spot_size_minimum = 2,
  random_spot_size_maximum = 4,
})

data:extend({ tin_item })
