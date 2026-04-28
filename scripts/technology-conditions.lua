-- Defines what each technology requires the analyzer to observe.
-- radius: tiles around the analyzer to scan
-- duration: cumulative seconds the conditions must be met to fill the card
-- requirements: list of { recipe, min_rate } where min_rate is items/sec
return {
  ["primitive-crushing"] = {
    radius = 30,
    duration = 60,
    requirements = {
      { recipe = "iron-plate", min_rate = 1.0 },
    },
  },
}
