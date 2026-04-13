local resource_autoplace = require("resource-autoplace")

local M = {}

function M.make(def)
  local res = table.deepcopy(data.raw["resource"]["iron-ore"])

  res.name = def.name
  res.icon = def.icon
  res.icon_size = 64
  res.map_color = def.color

  res.stages = {
    sheet = {
      filename = def.icon,
      priority = "extra-high",
      width = 64,
      height = 64,
      frame_count = 1,
      variation_count = 1,
      scale = 0.5,
    },
  }

  res.stage_counts = { 0 }
  res.stages_effect = nil

  res.minable.result = def.name

  res.autoplace = resource_autoplace.resource_autoplace_settings({
    name = def.name,
    order = "b",
    base_density = 8,
    base_spots_per_km2 = 1.5,
    has_starting_area_placement = false,
    random_spot_size_minimum = 2,
    random_spot_size_maximum = 4,
  })

  return res
end

return M
