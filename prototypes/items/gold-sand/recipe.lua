data:extend({
  {
    type = "recipe",
    name = "gold-sand",
    localised_name = { "recipe-name.gold-sand" },
    category = "crushing",
    energy_required = 2,
    enabled = false,
    ingredients = {
      { type = "item", name = "gold-ore", amount = 1 },
    },
    results = {
      { type = "item", name = "gold-sand", amount = 2 },
    },
  },
  {
    type = "recipe",
    name = "gold-sand-by-hand",
    localised_name = { "recipe-name.gold-sand-by-hand" },
    category = "crafting",
    energy_required = 8,
    enabled = false,
    ingredients = {
      { type = "item", name = "gold-ore", amount = 1 },
    },
    results = {
      { type = "item", name = "gold-sand", amount = 2 },
    },
  },
})
