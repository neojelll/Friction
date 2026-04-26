local function add_glass(recipe_name, amount)
  local recipe = data.raw.recipe[recipe_name]
  if recipe and recipe.ingredients then
    table.insert(recipe.ingredients, { type = "item", name = "glass", amount = amount })
  end
end

add_glass("lab", 1)
add_glass("accumulator", 2)
add_glass("solar-panel", 2)
add_glass("small-lamp", 1)
add_glass("radar", 1)

data.raw.recipe["advanced-circuit"] = {
  type = "recipe",
  name = "advanced-circuit",
  category = "crafting",
  energy_required = 6,
  enabled = false,
  ingredients = {
    { type = "item", name = "electronic-circuit", amount = 2 },
    { type = "item", name = "copper-cable", amount = 2 },
    { type = "item", name = "gold-wire", amount = 2 },
    { type = "item", name = "plastic-bar", amount = 2 },
  },
  results = {
    { type = "item", name = "advanced-circuit", amount = 1 },
  },
}

local adv_tech = data.raw.technology["advanced-electronics"]
if adv_tech and adv_tech.effects then
  table.insert(adv_tech.effects, { type = "unlock-recipe", recipe = "gold-wire" })
end
