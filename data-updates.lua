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
