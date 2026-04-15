local M = {}

function M.make(def)
  local item = table.deepcopy(data.raw["item"]["iron-ore"])

  item.name = def.name
  item.localised_name = { "item-name." .. def.name }
  item.order = def.order or ("z[" .. def.name .. "]")
  item.icon = def.icon
  item.icon_size = 64

  item.pictures = {
    { size = 64, filename = def.icon, scale = 0.5, mipmap_count = 1 },
    { size = 64, filename = def.icon:gsub("%.png", "-1.png"), scale = 0.5, mipmap_count = 1 },
    { size = 64, filename = def.icon:gsub("%.png", "-2.png"), scale = 0.5, mipmap_count = 1 },
    { size = 64, filename = def.icon:gsub("%.png", "-3.png"), scale = 0.5, mipmap_count = 1 },
  }

  return item
end

return M
