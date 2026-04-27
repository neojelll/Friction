-- Unobtainable item used as science pack so the lab can never auto-research
-- card-gated technologies. Only force.research_technology() can unlock them.
data:extend({
  {
    type = "tool",
    name = "friction-research-token",
    localised_name = { "item-name.friction-research-token" },
    icon = "__Friction__/graphics/technology/primitive-crushing.png",
    icon_size = 256,
    subgroup = "science-pack",
    order = "z[friction-token]",
    stack_size = 1,
    durability = 1,
    durability_description_key = "description.science-pack-remaining-uses",
  },
})

require("prototypes.technologies.primitive-crushing")
