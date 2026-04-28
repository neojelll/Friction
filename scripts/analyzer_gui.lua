local M = {}

local ENTITY_NAME = "friction-data-analyzer"
local GUI_NAME = "friction-analyzer-panel"

local function get_analyzer_data(entity)
  return storage.analyzers and storage.analyzers[entity.unit_number]
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

  local data = get_analyzer_data(entity)
  local progress = data and data.progress or 0
  local tech_name = data and data.technology or nil

  local label = frame.add({
    type = "label",
    name = "friction-analyzer-tech",
    caption = tech_name and { "gui.friction-analyzer-tracking", { "technology-name." .. tech_name } }
      or { "gui.friction-analyzer-no-card" },
  })
  label.style.single_line = false
  label.style.maximal_width = 160

  frame.add({
    type = "progressbar",
    name = "friction-analyzer-bar",
    value = progress,
    style = "achievement_progressbar",
  }).style.width =
    160
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
end

function M.on_gui_closed(event)
  if event.gui_type ~= defines.gui_type.entity then
    return
  end
  local player = game.players[event.player_index]
  if player.gui.relative[GUI_NAME] then
    player.gui.relative[GUI_NAME].destroy()
  end
end

-- Called from analyzer.on_tick to refresh any open panels.
function M.refresh(entity, progress, tech_name)
  for _, player in pairs(entity.force.players) do
    local panel = player.gui.relative[GUI_NAME]
    if not panel then
      goto continue
    end

    local bar = panel["friction-analyzer-bar"]
    if bar then
      bar.value = progress
    end

    local lbl = panel["friction-analyzer-tech"]
    if lbl then
      lbl.caption = tech_name and { "gui.friction-analyzer-tracking", { "technology-name." .. tech_name } }
        or { "gui.friction-analyzer-no-card" }
    end

    ::continue::
  end
end

return M
