local analyzer = require("scripts.analyzer")

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
