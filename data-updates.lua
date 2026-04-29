table.insert(data.raw.lab["lab"].inputs, "friction-tech-card-1")

for _, tech in pairs(data.raw.technology) do
  if tech.unit and tech.unit.ingredients then
    for i, ing in pairs(tech.unit.ingredients) do
      if ing[1] == "automation-science-pack" or ing.name == "automation-science-pack" then
        tech.unit.ingredients[i] = { "friction-tech-card-1", ing[2] or ing.amount }
      end
    end
  end
end

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

local adv_tech = data.raw.technology["advanced-circuit"]
if adv_tech and adv_tech.effects then
  table.insert(adv_tech.effects, { type = "unlock-recipe", recipe = "gold-wire" })
end
