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
script.on_event(defines.events.on_gui_opened, analyzer_gui.on_gui_opened)
script.on_event(defines.events.on_gui_closed, analyzer_gui.on_gui_closed)

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
    local pole = data.entity
    local chest = data.chest
    if not pole or not pole.valid then
      player.print("Analyzer " .. id .. ": pole invalid")
      goto continue
    end
    player.print("--- Analyzer " .. id .. " ---")
    player.print("  progress: " .. string.format("%.3f", data.progress))
    local inv = chest and chest.valid and chest.get_inventory(defines.inventory.chest)
    local slot1 = inv and inv[1]
    local slot2 = inv and inv[2]
    player.print("  slot1: " .. (slot1 and slot1.valid_for_read and slot1.name or "empty"))
    player.print("  slot2: " .. (slot2 and slot2.valid_for_read and slot2.name or "empty"))
    local furnaces = pole.surface.find_entities_filtered({ position = pole.position, radius = 50, type = "furnace" })
    player.print("  furnaces in radius 50: " .. #furnaces)
    for _, f in pairs(furnaces) do
      if f.valid then
        local recipe = f.get_recipe()
        player.print(
          "    furnace: recipe="
            .. tostring(recipe and recipe.name)
            .. " status="
            .. tostring(f.status)
            .. " speed="
            .. tostring(f.crafting_speed)
        )
      end
    end
    ::continue::
  end
end)
