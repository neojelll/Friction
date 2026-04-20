data:extend({
  {
    type = "recipe-category",
    name = "crushing",
  },
})

-- Allow handcrafting of crushing recipes; Crusher remains faster via crafting_speed=4
local char = data.raw["character"]["character"]
if char then
  table.insert(char.crafting_categories, "crushing")
end
