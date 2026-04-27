-- Unobtainable item used as craft-item research_trigger so the technology
-- can never be unlocked through normal play. Only force.research_technology()
-- can unlock card-gated technologies.
data:extend({
  {
    type = "item",
    name = "friction-research-token",
    icon = "__Friction__/graphics/technology/primitive-crushing.png",
    icon_size = 256,
    subgroup = "intermediate-product",
    order = "z[friction-token]",
    stack_size = 1,
  },
})

require("prototypes.technologies.primitive-crushing")
