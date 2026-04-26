data.raw.recipe["copper-plate"] = {
  type = "recipe",
  name = "copper-plate",
  category = "smelting",
  energy_required = 6,
  enabled = true,
  ingredients = {
    { type = "item", name = "copper-ore", amount = 2 },
  },
  results = {
    { type = "item", name = "copper-plate", amount = 1 },
  },
}

data:extend({
  {
    type = "recipe",
    name = "copper-plate-from-crushed",
    localised_name = { "recipe-name.copper-plate-from-crushed" },
    category = "smelting",
    energy_required = 3,
    enabled = true,
    ingredients = {
      { type = "item", name = "crushed-copper-ore", amount = 2 },
    },
    results = {
      { type = "item", name = "copper-plate", amount = 1 },
    },
  },
})
