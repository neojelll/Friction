data:extend({
  {
    type = "technology",
    name = "primitive-crushing",
    icon = "__Friction__/graphics/technology/primitive-crushing.png",
    icon_size = 256,
    research_trigger = {
      type = "mine-entity",
      entity = "iron-ore",
      count = 10,
    },
    effects = {
      { type = "unlock-recipe", recipe = "crushed-iron-ore" },
      { type = "unlock-recipe", recipe = "crushed-iron-ore-by-hand" },
    },
  },
})
