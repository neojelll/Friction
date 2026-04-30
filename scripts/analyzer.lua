local analyzer_gui = require("scripts.analyzer_gui")

local M = {}

local ENTITY_NAME = "friction-data-analyzer"
local CHEST_NAME = "friction-data-analyzer-chest"
local BLANK_CARD = "friction-data-card"
local TECH_CARD_1 = "friction-tech-card-1"
local SCAN_TYPES = { "assembling-machine", "furnace", "rocket-silo" }
local SCAN_RADIUS = 50

local function get_iron_rate(entity)
  if not entity.valid then
    return nil
  end
  local recipe = entity.get_recipe()
  if not recipe or recipe.name ~= "iron-plate" then
    return nil
  end
  if entity.status ~= defines.entity_status.working then
    return nil
  end
  for _, result in pairs(recipe.products) do
    if result.name == "iron-plate" then
      return (result.amount or result.amount_min or 1) / recipe.energy * entity.crafting_speed
    end
  end
  return nil
end

local function measure_iron_per_sec(surface, position)
  local total = 0
  for _, etype in pairs(SCAN_TYPES) do
    local entities = surface.find_entities_filtered({
      position = position,
      radius = SCAN_RADIUS,
      type = etype,
    })
    for _, entity in pairs(entities) do
      local rate = get_iron_rate(entity)
      if rate then
        total = total + rate
      end
    end
  end
  return total
end

function M.on_init()
  storage.analyzers = {}
  storage.chest_to_pole = {}
end

function M.on_load() end

local function register_analyzer(pole)
  local chest = pole.surface.create_entity({
    name = CHEST_NAME,
    position = pole.position,
    force = pole.force,
  })
  local data = { entity = pole, chest = chest, progress = 0 }
  storage.analyzers[pole.unit_number] = data
  if chest then
    storage.chest_to_pole[chest.unit_number] = pole.unit_number
  end
end

local function unregister_analyzer(pole)
  local data = storage.analyzers[pole.unit_number]
  if data then
    if data.chest and data.chest.valid then
      storage.chest_to_pole[data.chest.unit_number] = nil
      data.chest.destroy()
    end
    storage.analyzers[pole.unit_number] = nil
  end
end

function M.on_built(event)
  local entity = event.entity
  if entity and entity.valid and entity.name == ENTITY_NAME then
    register_analyzer(entity)
  end
end

function M.on_removed(event)
  local entity = event.entity
  if entity and entity.valid and entity.name == ENTITY_NAME then
    unregister_analyzer(entity)
  end
end

function M.on_tick()
  for _, data in pairs(storage.analyzers) do
    local pole = data.entity
    local chest = data.chest

    if not pole or not pole.valid then
      goto continue
    end
    if not chest or not chest.valid then
      goto continue
    end

    local inv = chest.get_inventory(defines.inventory.chest)
    if not inv then
      goto continue
    end

    local slot1 = inv[1]
    local slot2 = inv[2]

    -- Need a blank card in slot 1 and slot 2 must be empty.
    if not slot1 or not slot1.valid_for_read or slot1.name ~= BLANK_CARD then
      data.progress = 0
      analyzer_gui.refresh(pole, 0)
      goto continue
    end
    if slot2 and slot2.valid_for_read then
      -- Output slot occupied; pause filling until player takes the card.
      goto continue
    end

    local iron_per_sec = measure_iron_per_sec(pole.surface, pole.position)
    -- 1 iron/sec = 1%/sec, so each on_nth_tick(60) call adds iron_per_sec * 0.01
    data.progress = data.progress + iron_per_sec * 0.01

    if data.progress >= 1 then
      data.progress = 0
      inv[1].clear()
      inv[2].set_stack({ name = TECH_CARD_1, count = 1 })
      analyzer_gui.refresh(pole, 0)
    else
      analyzer_gui.refresh(pole, data.progress)
    end

    ::continue::
  end
end

return M
