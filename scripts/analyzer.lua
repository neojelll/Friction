local conditions = require("scripts.technology-conditions")
local analyzer_gui = require("scripts.analyzer_gui")

local M = {}

local ENTITY_NAME = "friction-data-analyzer"
local CARD_NAME = "friction-data-card"
local SCAN_TYPES = { "assembling-machine", "furnace", "rocket-silo" }

-- Returns items/sec this entity produces of result_name, or nil if it doesn't.
local function get_production_rate(entity, recipe_name)
  if not entity.valid then return nil end
  local recipe = entity.get_recipe()
  if not recipe or recipe.name ~= recipe_name then return nil end
  if entity.status ~= defines.entity_status.working then return nil end

  for _, result in pairs(recipe.products) do
    if result.name == recipe_name then
      return (result.amount or result.amount_min or 1) / recipe.energy * entity.crafting_speed
    end
  end
  return nil
end

-- Scans radius around analyzer for total production rate of a recipe.
local function measure_rate(surface, position, radius, recipe_name)
  local total = 0
  for _, etype in pairs(SCAN_TYPES) do
    local entities = surface.find_entities_filtered({
      position = position,
      radius = radius,
      type = etype,
    })
    for _, entity in pairs(entities) do
      local rate = get_production_rate(entity, recipe_name)
      if rate then total = total + rate end
    end
  end
  return total
end

-- Returns true if all requirements for a condition set are met.
local function conditions_met(surface, position, cond)
  for _, req in pairs(cond.requirements) do
    local rate = measure_rate(surface, position, cond.radius, req.recipe)
    if rate < req.min_rate then return false end
  end
  return true
end

-- Reads the technology name stored in card tags, or nil.
local function card_technology(stack)
  if not stack or not stack.valid_for_read then return nil end
  if stack.name ~= CARD_NAME then return nil end
  local tags = stack.tags
  return tags and tags.technology or nil
end

-- Reads accumulated progress from card tags (0.0 – 1.0).
local function card_progress(stack)
  if not stack or not stack.valid_for_read then return 0 end
  local tags = stack.tags
  return tags and tags.progress or 0
end

-- Writes progress into card tags, preserving the technology field.
local function set_card_progress(stack, tech, progress)
  stack.tags = { technology = tech, progress = progress }
end

-- Transfers progress from storage into the card currently in the analyzer.
local function flush_to_card(analyzer_data)
  local entity = analyzer_data.entity
  if not entity or not entity.valid then return end
  local inv = entity.get_inventory(defines.inventory.chest)
  local stack = inv and inv[1]
  if not stack or not stack.valid_for_read then return end
  if stack.name ~= CARD_NAME then return end
  set_card_progress(stack, analyzer_data.technology, analyzer_data.progress)
end

function M.on_init()
  storage.analyzers = {}
end

function M.on_load()
  -- nothing: storage is already populated from save
end

local function register_analyzer(entity)
  storage.analyzers[entity.unit_number] = {
    entity = entity,
    technology = nil,
    progress = 0,
  }
end

local function unregister_analyzer(entity)
  local data = storage.analyzers[entity.unit_number]
  if data then
    flush_to_card(data)
    storage.analyzers[entity.unit_number] = nil
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
    local entity = data.entity
    if not entity or not entity.valid then goto continue end

    local inv = entity.get_inventory(defines.inventory.chest)
    local stack = inv and inv[1]

    -- No card present: reset tracking but keep entity registered.
    if not stack or not stack.valid_for_read or stack.name ~= CARD_NAME then
      data.technology = nil
      data.progress = 0
      goto continue
    end

    -- Card just inserted (or technology not yet read): sync from tags.
    local card_tech = card_technology(stack)
    if card_tech == nil then
      -- Blank card: assign first unresearched technology that has conditions.
      for tech_name, _ in pairs(conditions) do
        local tech = entity.force.technologies[tech_name]
        if tech and not tech.researched then
          set_card_progress(stack, tech_name, 0)
          data.technology = tech_name
          data.progress = 0
          break
        end
      end
      goto continue
    end

    -- Sync storage from card when a different card is inserted.
    if data.technology ~= card_tech then
      data.technology = card_tech
      data.progress = card_progress(stack)
    end

    local tech_name = data.technology
    local cond = conditions[tech_name]
    if not cond then goto continue end

    -- Check if already researched (card is now useless for this tech).
    local tech = entity.force.technologies[tech_name]
    if tech and tech.researched then goto continue end

    if conditions_met(entity.surface, entity.position, cond) then
      -- Each on_nth_tick(60) call represents 1 second of qualifying production.
      data.progress = data.progress + (1 / cond.duration)
      if data.progress >= 1 then
        data.progress = 1
        inv[1].set_stack({ name = "friction-full-data-card", count = 1 })
        data.technology = nil
        data.progress = 0
        local msg = { "message.friction-card-ready", { "technology-name." .. tech_name } }
        for _, player in pairs(entity.force.players) do
          player.print(msg, { r = 0.4, g = 1.0, b = 0.4 })
        end
        analyzer_gui.refresh(entity, data.progress, data.technology)
      else
        set_card_progress(stack, tech_name, data.progress)
        analyzer_gui.refresh(entity, data.progress, data.technology)
      end
    end

    ::continue::
  end
end

return M
