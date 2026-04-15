data.raw.recipe["iron-plate"] = {
  type = "recipe",
  name = "iron-plate",
  category = "smelting",
  energy_required = 6,
  enabled = true,
  ingredients = {
    { type = "item", name = "iron-ore", amount = 2 },
  },
  results = {
    { type = "item", name = "iron-plate", amount = 1 },
  },
}

data:extend({
  {
    type = "recipe",
    name = "iron-plate-from-crushed",
    localised_name = { "recipe-name.iron-plate-from-crushed" },
    category = "smelting",
    energy_required = 3,
    enabled = true,
    ingredients = {
      { type = "item", name = "crushed-iron-ore", amount = 2 },
    },
    results = {
      { type = "item", name = "iron-plate", amount = 1 },
    },
  },
})
