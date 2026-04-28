local M = {}

local ENTITY_NAME = "friction-data-analyzer"
local CURSOR_ITEM = "friction-data-analyzer"
local GUI_NAME = "friction-analyzer-panel"
local SCAN_RADIUS = 50

-- Module-level render tables: not persisted, GUIs reset on load.
local gui_renders = {}    -- open when GUI is open
local hover_renders = {}  -- open when mouse hovers over entity
local cursor_renders = {} -- open when holding the item

local function clear_render(tbl, player_index)
  local obj = tbl[player_index]
  if obj and obj.valid then
    obj.destroy()
  end
  tbl[player_index] = nil
end

local function make_circle(params)
  local ok, result = pcall(rendering.draw_circle, params)
  return ok and result or nil
end

local function circle_params(target, surface, player)
  return {
    color = { r = 0.2, g = 0.9, b = 0.2, a = 0.4 },
    radius = SCAN_RADIUS,
    width = 2,
    filled = false,
    target = target,
    surface = surface,
    players = { player },
  }
end

local function get_progress(entity)
  local data = storage.analyzers and storage.analyzers[entity.unit_number]
  return data and data.progress or 0
end

local function build_gui(player, entity)
  if player.gui.relative[GUI_NAME] then
    player.gui.relative[GUI_NAME].destroy()
  end

  local anchor = {
    gui = defines.relative_gui_type.container_gui,
    position = defines.relative_gui_position.right,
  }

  local frame = player.gui.relative.add({
    type = "frame",
    name = GUI_NAME,
    anchor = anchor,
    caption = { "gui.friction-analyzer-title" },
    direction = "vertical",
  })
  frame.style.width = 180

  local inv = entity.get_inventory(defines.inventory.chest)
  local slot1 = inv and inv[1]
  local has_card = slot1 and slot1.valid_for_read and slot1.name == "friction-data-card"

  frame.add({
    type = "label",
    name = "friction-analyzer-status",
    caption = has_card and { "gui.friction-analyzer-filling" } or { "gui.friction-analyzer-no-card" },
  }).style.single_line = false

  frame.add({
    type = "progressbar",
    name = "friction-analyzer-bar",
    value = get_progress(entity),
    style = "achievement_progressbar",
  }).style.width = 160
end

function M.on_gui_opened(event)
  if event.gui_type ~= defines.gui_type.entity then
    return
  end
  local entity = event.entity
  if not entity or not entity.valid or entity.name ~= ENTITY_NAME then
    return
  end
  local player = game.players[event.player_index]
  build_gui(player, entity)
  clear_render(gui_renders, player.index)
  gui_renders[player.index] = make_circle(circle_params(entity.position, entity.surface, player))
end

function M.on_gui_closed(event)
  if event.gui_type ~= defines.gui_type.entity then
    return
  end
  local player = game.players[event.player_index]
  if player.gui.relative[GUI_NAME] then
    player.gui.relative[GUI_NAME].destroy()
  end
  clear_render(gui_renders, event.player_index)
end

function M.on_selected_entity_changed(event)
  local player = game.players[event.player_index]
  if not player or not player.valid then
    return
  end
  local entity = player.selected
  if entity and entity.valid and entity.name == ENTITY_NAME then
    clear_render(hover_renders, player.index)
    hover_renders[player.index] = make_circle(circle_params(entity.position, entity.surface, player))
  else
    clear_render(hover_renders, player.index)
  end
end

-- Called every tick from control.lua to keep cursor circle following the mouse.
function M.on_tick_render()
  for _, player in pairs(game.players) do
    if not player.valid then
      goto continue
    end
    local cursor = player.cursor_stack
    local has_item = cursor and cursor.valid_for_read and cursor.name == CURSOR_ITEM
    if has_item then
      local pos = player.position
      local obj = cursor_renders[player.index]
      if not obj or not obj.valid then
        cursor_renders[player.index] = make_circle(circle_params(pos, player.surface, player))
      else
        obj.target = pos
      end
    else
      clear_render(cursor_renders, player.index)
    end
    ::continue::
  end
end

function M.refresh(entity, progress)
  for _, player in pairs(entity.force.players) do
    local panel = player.gui.relative[GUI_NAME]
    if not panel then
      goto continue
    end
    local bar = panel["friction-analyzer-bar"]
    if bar then
      bar.value = progress
    end
    ::continue::
  end
end

function M.draw_test_circle(player)
  local ok, result = pcall(rendering.draw_circle, {
    color = { r = 1, g = 0, b = 0, a = 0.8 },
    radius = 10,
    width = 4,
    filled = false,
    target = player.position,
    surface = player.surface,
    time_to_live = 300,
  })
  if ok then
    player.print("[friction] test circle drawn, id=" .. tostring(result and result.id))
  else
    player.print("[friction] test circle FAILED: " .. tostring(result))
  end
end

return M
