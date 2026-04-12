-- resource.lua
local resource_autoplace = require("resource-autoplace")

local quartz_ore = table.deepcopy(data.raw["resource"]["iron-ore"])
quartz_ore.name = "quartz-ore"
quartz_ore.icon = "__Friction__/graphics/icons/ores/quartz-ore.png"
quartz_ore.icon_size = 64
quartz_ore.stages = {
  sheet = {
    filename = "__Friction__/graphics/icons/ores/quartz-ore.png",
    priority = "extra-high",
    width = 64,
    height = 64,
    frame_count = 1,
    variation_count = 1,
    scale = 0.5,
  },
}
quartz_ore.stage_counts = { 0 }
quartz_ore.stages_effect = nil
quartz_ore.minable.result = "quartz-ore"
quartz_ore.autoplace = resource_autoplace.resource_autoplace_settings({
  name = "quartz-ore",
  order = "b",
  base_density = 8,
  base_spots_per_km2 = 1.5,
  has_starting_area_placement = false,
  random_spot_size_minimum = 2,
  random_spot_size_maximum = 4,
})

data:extend({ quartz_ore })
