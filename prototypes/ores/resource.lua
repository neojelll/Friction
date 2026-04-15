local resource_autoplace = require("resource-autoplace")

local M = {}

function M.make(def)
  local res = table.deepcopy(data.raw["resource"]["iron-ore"])

  res.name = def.name
  res.icon = def.icon
  res.icon_size = 64
  res.map_color = def.color
  res.minable.result = def.name

  res.stages = {
    sheet = {
      filename = def.entity_sheet,
      priority = "extra-high",
      width = 128,
      height = 128,
      frame_count = 8,
      variation_count = 8,
      scale = 0.5,
    },
  }

  res.stages_effect = nil

  res.autoplace = resource_autoplace.resource_autoplace_settings({
    name = def.name,
    order = "b",
    base_density = 10,
    has_starting_area_placement = true,
    regular_rq_factor_multiplier = 1.10,
    starting_rq_factor_multiplier = 1.5,
    candidate_spot_count = 22,
  })

  return res
end

return M
