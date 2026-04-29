local M = {}

local ENTITY_NAME = "friction-data-analyzer"
local GUI_NAME = "friction-analyzer-panel"
local SCAN_RADIUS = 50

local gui_renders = {}
local hover_renders = {}

local function clear_render(tbl, player_index)
  local obj = tbl[player_index]
  if obj and obj.valid then
    obj.destroy()
  end
  tbl[player_index] = nil
end

local function draw_area_rect(target_pos, surface, player)
  local d = SCAN_RADIUS
  local ok, result = pcall(rendering.draw_rectangle, {
    color = { r = 0, g = 0.6, b = 0.8, a = 0.25 },
    left_top = { x = target_pos.x - d, y = target_pos.y - d },
    right_bottom = { x = target_pos.x + d, y = target_pos.y + d },
    width = 2,
    filled = false,
    surface = surface,
    players = { player },
  })
  return ok and result or nil
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
  gui_renders[player.index] = draw_area_rect(entity.position, entity.surface, player)
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
    hover_renders[player.index] = draw_area_rect(entity.position, entity.surface, player)
  else
    clear_render(hover_renders, player.index)
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
