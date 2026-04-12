-- item.lua
local tin_item = table.deepcopy(data.raw["item"]["iron-ore"])
tin_item.name = "tin-ore"
tin_item.localised_name = { "item-name.tin-ore" }
tin_item.order = "z[tin-ore]"

tin_item.icon = "__Friction__/graphics/icons/ores/tin-ore.png"
tin_item.icon_size = 64
tin_item.pictures = {
  { size = 64, filename = "__Friction__/graphics/icons/tin-ore.png", scale = 0.7, mipmap_count = 1 },
}

data:extend({ tin_item })
