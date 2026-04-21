data:extend({
  {
    type = "recipe",
    name = "crushed-iron-ore",
    localised_name = { "recipe-name.crushed-iron-ore" },
    category = "crushing",
    energy_required = 2,
    enabled = false,
    ingredients = {
      { type = "item", name = "iron-ore", amount = 1 },
    },
    results = {
      { type = "item", name = "crushed-iron-ore", amount = 2 },
    },
  },
  {
    type = "recipe",
    name = "crushed-iron-ore-by-hand",
    localised_name = { "recipe-name.crushed-iron-ore-by-hand" },
    category = "crafting",
    energy_required = 8,
    enabled = false,
    ingredients = {
      { type = "item", name = "iron-ore", amount = 1 },
    },
    results = {
      { type = "item", name = "crushed-iron-ore", amount = 2 },
    },
  },
})
