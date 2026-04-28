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
    player.print("  technology: " .. tostring(data.technology))
    player.print("  progress:   " .. string.format("%.3f", data.progress))
    local inv = entity.get_inventory(defines.inventory.chest)
    local stack = inv and inv[1]
    if stack and stack.valid_for_read then
      player.print("  card: " .. stack.name)
      local ok, tags = pcall(function()
        return stack.tags
      end)
      if ok then
        local tech = tostring(tags and tags.technology)
        local prog = tostring(tags and tags.progress)
        player.print("  tags: tech=" .. tech .. " progress=" .. prog)
      else
        player.print("  tags: ERROR - " .. tostring(tags))
      end
    else
      player.print("  card: empty")
    end
    -- scan nearby machines
    local surface = entity.surface
    local found = surface.find_entities_filtered({ position = entity.position, radius = 30, type = "furnace" })
    player.print("  furnaces in radius 30: " .. #found)
    for _, f in pairs(found) do
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
