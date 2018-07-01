require 'util'

local trainassembly = util.table.deepcopy(data.raw["item"]["rail-signal"])

trainassembly.name  = "trainassembly"
trainassembly.localised_name = {"item-name.trainassembly"}
trainassembly.localised_description = {"item-description.trainassembly"}

trainassembly.icon = "__trainConstructionSite__/graphics/placeholders/icon.png"
trainassembly.icons = nil
trainassembly.icon_size = 32

trainassembly.place_result = "trainassembly-placeable" -- the placeable entity



data:extend({
  trainassembly,
})