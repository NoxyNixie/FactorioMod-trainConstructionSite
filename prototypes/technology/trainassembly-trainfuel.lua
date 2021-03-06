
for _, recipeName in pairs{
  "trainassembly-trainfuel-wood",
} do
  table.insert(data.raw["technology"]["trainassembly-automated-train-assembling"].effects,
  {
    type = "unlock-recipe",
    recipe = recipeName,
  })
end



data:extend{ -- add fuel recipe to tech tree
  {
    type = "technology",
    name = "trainfuel-2",
    localised_name = {"technology-name.trainfuel", "trainassemblyfuel", "coal"},
    localised_description = {"technology-description.trainfuel", "trainassemblyfuel", "coal"},
    icons = LSlib.recipe.getIcons("trainassembly-trainfuel-coal"),
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "trainassembly-trainfuel-coal",
      },
    },
    prerequisites =
    {
      "trainassembly-automated-train-assembling",
    },
    unit =
    {
      count = 75,
      ingredients = util.table.deepcopy(data.raw["technology"]["railway"].unit.ingredients),
      time = 10,
    },
    order = "c-g-a-b",
  },
  {
    type = "technology",
    name = "trainfuel-3",
    localised_name = {"technology-name.trainfuel", "trainassemblyfuel", "solid-fuel"},
    localised_description = {"technology-description.trainfuel", "trainassemblyfuel", "solid-fuel"},
    icons = LSlib.recipe.getIcons("trainassembly-trainfuel-solid-fuel"),
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "trainassembly-trainfuel-solid-fuel",
      },
    },
    prerequisites =
    {
      "trainfuel-2",
      "oil-processing",
    },
    unit =
    {
      count = 100,
      ingredients = util.table.deepcopy(data.raw["technology"]["oil-processing"].unit.ingredients),
      time = 10,
    },
    order = "c-g-a-c",
  },
  {
    type = "technology",
    name = "trainfuel-4",
    localised_name = {"technology-name.trainfuel", "trainassemblyfuel", "rocket-fuel"},
    localised_description = {"technology-description.trainfuel", "trainassemblyfuel", "rocket-fuel"},
    icons = LSlib.recipe.getIcons("trainassembly-trainfuel-rocket-fuel"),
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "trainassembly-trainfuel-rocket-fuel",
      },
    },
    prerequisites =
    {
      "trainfuel-3",
      "rocket-fuel",
    },
    unit =
    {
      count = 75,
      ingredients = util.table.deepcopy(data.raw["technology"]["rocket-fuel"].unit.ingredients),

      time = 30,
    },
    order = "c-g-a-d",
  },
  {
    type = "technology",
    name = "trainfuel-5",
    localised_name = {"technology-name.trainfuel", "trainassemblyfuel", "nuclear-fuel"},
    localised_description = {"technology-description.trainfuel", "trainassemblyfuel", "nuclear-fuel"},
    icons = LSlib.recipe.getIcons("trainassembly-trainfuel-nuclear-fuel"),
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "trainassembly-trainfuel-nuclear-fuel",
      },
    },
    prerequisites =
    {
      "trainfuel-4",
      "kovarex-enrichment-process",
    },
    unit =
    {
      count = 500,
      ingredients = util.table.deepcopy(data.raw["technology"]["kovarex-enrichment-process"].unit.ingredients),
      time = 60,
    },
    order = "c-g-a-e",
  },
}

-- update the icons
for level = 2, 5 do
  for _,iconLayer in pairs(data.raw["technology"][string.format("trainfuel-%i", level)].icons) do
    if iconLayer.icon == "__trainConstructionSite__/graphics/item/trainfuel/loco/loco-64.png" then
      iconLayer.icon      = "__trainConstructionSite__/graphics/item/trainfuel/loco/loco-128.png"
      iconLayer.icon_size = 128
    elseif iconLayer.icon == "__trainConstructionSite__/graphics/item/trainfuel/fuel-handle/fuel-handle-32.png" then
      iconLayer.icon      = "__trainConstructionSite__/graphics/item/trainfuel/fuel-handle/fuel-handle-64.png"
      iconLayer.icon_size = 64
    end
    for shiftAxis,shiftAmount in pairs(iconLayer.shift or {}) do
      iconLayer.shift[shiftAxis] = 2 * shiftAmount
    end
  end
end