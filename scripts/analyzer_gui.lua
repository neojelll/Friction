local M = {}

local ENTITY_NAME = "friction-data-analyzer"
local GUI_NAME = "friction-analyzer-panel"
local SCAN_RADIUS = 50

-- Not persisted: render objects are cosmetic and GUIs are closed on load.
local renders = {}

local function get_progress(entity)
  local data = storage.analyzers and storage.analyzers[entity.unit_number]
  return data and data.progress or 0
end

local function clear_radius_render(player_index)
  local obj = renders[player_index]
  if obj and obj.valid then
    obj.destroy()
  end
  renders[player_index] = nil
end

local function draw_radius_render(player, entity)
  clear_radius_render(player.index)
  local ok, result = pcall(rendering.draw_circle, {
    color = { r = 0.2, g = 0.9, b = 0.2, a = 0.5 },
    radius = SCAN_RADIUS,
    width = 3,
    filled = false,
    target = entity.position,
    surface = entity.surface,
    players = { player },
  })
  if ok then
    renders[player.index] = result
    player.print("[friction] circle drawn id=" .. tostring(result and result.id))
  else
    player.print("[friction] render error: " .. tostring(result))
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
  draw_radius_render(player, entity)
end

function M.on_gui_closed(event)
  if event.gui_type ~= defines.gui_type.entity then
    return
  end
  local player = game.players[event.player_index]
  if player.gui.relative[GUI_NAME] then
    player.gui.relative[GUI_NAME].destroy()
  end
  clear_radius_render(event.player_index)
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

return M
