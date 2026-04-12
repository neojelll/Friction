-- autoplace-controls.lua
local quartz_ore = {
  type = "autoplace-control",
  name = "quartz-ore",
  localised_name = { "", "[entity=quartz-ore] ", { "entity-name.quartz-ore" } },
  richness = true,
  order = "b[quartz-ore]",
  category = "resource",
}

local tin_ore = {
  type = "autoplace-control",
  name = "tin-ore",
  localised_name = { "", "[entity=tin-ore] ", { "entity-name.tin-ore" } },
  richness = true,
  order = "b[tin-ore]",
  category = "resource",
}

data.raw["planet"]["nauvis"].map_gen_settings.autoplace_controls["quartz-ore"] = {}
data.raw["planet"]["nauvis"].map_gen_settings.autoplace_settings.entity.settings["quartz-ore"] = {}

data.raw["planet"]["nauvis"].map_gen_settings.autoplace_controls["tin-ore"] = {}
data.raw["planet"]["nauvis"].map_gen_settings.autoplace_settings.entity.settings["tin-ore"] = {}

data:extend({ quartz_ore, tin_ore })
