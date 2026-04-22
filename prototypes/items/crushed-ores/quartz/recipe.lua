data:extend({
  {
    type = "recipe",
    name = "crushed-quartz-ore",
    localised_name = { "recipe-name.crushed-quartz-ore" },
    category = "crushing",
    energy_required = 2,
    enabled = false,
    ingredients = {
      { type = "item", name = "quartz-ore", amount = 1 },
    },
    results = {
      { type = "item", name = "crushed-quartz-ore", amount = 2 },
    },
  },
  {
    type = "recipe",
    name = "crushed-quartz-ore-by-hand",
    localised_name = { "recipe-name.crushed-quartz-ore-by-hand" },
    category = "crafting",
    energy_required = 8,
    enabled = false,
    ingredients = {
      { type = "item", name = "quartz-ore", amount = 1 },
    },
    results = {
      { type = "item", name = "crushed-quartz-ore", amount = 2 },
    },
  },
})
