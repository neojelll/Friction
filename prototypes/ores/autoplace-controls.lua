-- autoplace-controls.lua
local quartz_ore = {
  type = "autoplace-control",
  name = "quartz-ore",
  localised_name = { "", "[entity=quartz-ore] ", { "entity-name.quartz-ore" } },
  richness = true,
  order = "b[quartz-ore]",
  category = "resource",
}

data:extend({ quartz_ore })

data.raw["planet"]["nauvis"].map_gen_settings.autoplace_controls["quartz-ore"] = {}
data.raw["planet"]["nauvis"].map_gen_settings.autoplace_settings.entity.settings["quartz-ore"] = {}
