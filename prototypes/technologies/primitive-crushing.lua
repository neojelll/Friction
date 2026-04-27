data:extend({
  {
    type = "technology",
    name = "primitive-crushing",
    icon = "__Friction__/graphics/technology/primitive-crushing.png",
    icon_size = 256,
    enabled = true,
    unit = {
      count = 1,
      ingredients = { { "friction-full-data-card", 1 } },
      time = 15,
    },
    effects = {
      { type = "unlock-recipe", recipe = "crushed-iron-ore" },
      { type = "unlock-recipe", recipe = "crushed-iron-ore-by-hand" },
      { type = "unlock-recipe", recipe = "crushed-copper-ore" },
      { type = "unlock-recipe", recipe = "crushed-copper-ore-by-hand" },
      { type = "unlock-recipe", recipe = "gold-sand" },
      { type = "unlock-recipe", recipe = "gold-sand-by-hand" },
      { type = "unlock-recipe", recipe = "crushed-quartz-ore" },
      { type = "unlock-recipe", recipe = "crushed-quartz-ore-by-hand" },
      { type = "unlock-recipe", recipe = "quartz-sand" },
      { type = "unlock-recipe", recipe = "glass" },
    },
  },
})
