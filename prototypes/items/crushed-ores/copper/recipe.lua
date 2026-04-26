data:extend({
  {
    type = "recipe",
    name = "crushed-copper-ore",
    localised_name = { "recipe-name.crushed-copper-ore" },
    category = "crushing",
    energy_required = 2,
    enabled = false,
    ingredients = {
      { type = "item", name = "copper-ore", amount = 1 },
    },
    results = {
      { type = "item", name = "crushed-copper-ore", amount = 2 },
    },
  },
  {
    type = "recipe",
    name = "crushed-copper-ore-by-hand",
    localised_name = { "recipe-name.crushed-copper-ore-by-hand" },
    category = "crafting",
    energy_required = 8,
    enabled = false,
    ingredients = {
      { type = "item", name = "copper-ore", amount = 1 },
    },
    results = {
      { type = "item", name = "crushed-copper-ore", amount = 2 },
    },
  },
})
