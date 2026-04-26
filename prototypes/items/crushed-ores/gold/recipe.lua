data:extend({
  {
    type = "recipe",
    name = "gold-dust",
    localised_name = { "recipe-name.gold-dust" },
    category = "crushing",
    energy_required = 2,
    enabled = false,
    ingredients = {
      { type = "item", name = "gold-ore", amount = 1 },
    },
    results = {
      { type = "item", name = "gold-dust", amount = 2 },
    },
  },
  {
    type = "recipe",
    name = "gold-dust-by-hand",
    localised_name = { "recipe-name.gold-dust-by-hand" },
    category = "crafting",
    energy_required = 8,
    enabled = false,
    ingredients = {
      { type = "item", name = "gold-ore", amount = 1 },
    },
    results = {
      { type = "item", name = "gold-dust", amount = 2 },
    },
  },
})
