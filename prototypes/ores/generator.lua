local ores = require("prototypes.ores.data")

local item = require("prototypes.ores.item")
local resource = require("prototypes.ores.resource")
local control = require("prototypes.ores.control")

local items = {}
local resources = {}
local controls = {}

for _, def in pairs(ores) do
  table.insert(items, item.make(def))
  table.insert(resources, resource.make(def))
  table.insert(controls, control.make(def))
end

data:extend(items)
data:extend(resources)
data:extend(controls)
