local M = {}

function M.make(def)
  data.raw["planet"]["nauvis"].map_gen_settings.autoplace_controls[def.name] = {}
  data.raw["planet"]["nauvis"].map_gen_settings.autoplace_settings.entity.settings[def.name] = {}

  return {
    type = "autoplace-control",
    name = def.name,
    localised_name = { "", "[entity=" .. def.name .. "] ", { "entity-name." .. def.name } },
    richness = true,
    order = "b[" .. def.name .. "]",
    category = "resource",
  }
end

return M
