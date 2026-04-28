local analyzer = require("scripts.analyzer")
local analyzer_gui = require("scripts.analyzer_gui")

script.on_init(analyzer.on_init)
script.on_load(analyzer.on_load)

local built_events = {
  defines.events.on_built_entity,
  defines.events.on_robot_built_entity,
}
local removed_events = {
  defines.events.on_player_mined_entity,
  defines.events.on_robot_mined_entity,
  defines.events.on_entity_died,
}

for _, event in pairs(built_events) do
  script.on_event(event, analyzer.on_built, { { filter = "name", name = "friction-data-analyzer" } })
end

for _, event in pairs(removed_events) do
  script.on_event(event, analyzer.on_removed, { { filter = "name", name = "friction-data-analyzer" } })
end

script.on_nth_tick(60, analyzer.on_tick)
script.on_event(defines.events.on_tick, function() analyzer_gui.on_tick_render() end)
script.on_event(defines.events.on_gui_opened, analyzer_gui.on_gui_opened)
script.on_event(defines.events.on_gui_closed, analyzer_gui.on_gui_closed)
script.on_event(defines.events.on_selected_entity_changed, analyzer_gui.on_selected_entity_changed)

commands.add_command("friction-test-render", "Test rendering circle", function(event)
  analyzer_gui.draw_test_circle(game.players[event.player_index])
end)

commands.add_command("friction-debug", "Debug data analyzers", function(event)
  local player = game.players[event.player_index]
  if not storage.analyzers or not next(storage.analyzers) then
    player.print("No analyzers registered in storage.")
    return
  end
  for id, data in pairs(storage.analyzers) do
    local entity = data.entity
    if not entity or not entity.valid then
      player.print("Analyzer " .. id .. ": entity invalid")
      goto continue
    end
    player.print("--- Analyzer " .. id .. " ---")
    player.print("  progress: " .. string.format("%.3f", data.progress))
    local inv = entity.get_inventory(defines.inventory.chest)
    local slot1 = inv and inv[1]
    local slot2 = inv and inv[2]
    player.print("  slot1: " .. (slot1 and slot1.valid_for_read and slot1.name or "empty"))
    player.print("  slot2: " .. (slot2 and slot2.valid_for_read and slot2.name or "empty"))
    local surface = entity.surface
    local furnaces = surface.find_entities_filtered({ position = entity.position, radius = 50, type = "furnace" })
    player.print("  furnaces in radius 50: " .. #furnaces)
    for _, f in pairs(furnaces) do
      if f.valid then
        local recipe = f.get_recipe()
        local rname = tostring(recipe and recipe.name)
        local rstatus = tostring(f.status)
        local rspeed = tostring(f.crafting_speed)
        player.print("    furnace: recipe=" .. rname .. " status=" .. rstatus .. " speed=" .. rspeed)
      end
    end
    ::continue::
  end
end)
