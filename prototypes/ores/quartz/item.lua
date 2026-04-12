-- item.lua
local quartz_item = table.deepcopy(data.raw["item"]["iron-ore"])
quartz_item.name = "quartz-ore"
quartz_item.localised_name = { "item-name.quartz-ore" }
quartz_item.order = "z[quartz-ore]"

quartz_item.icon = "__Friction__/graphics/icons/quartz-ore.png"
quartz_item.icon_size = 64

data:extend({ quartz_item })
