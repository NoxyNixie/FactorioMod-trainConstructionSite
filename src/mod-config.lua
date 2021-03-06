require("__LSlib__/LSlib")

-- To make sure everything is inline with the technology tree when the mod is added.
-- This is for when the mod is added into an existing game or when the mod is updated.
local trainControllerGui = require("prototypes.gui.layout.traincontroller")
local trainDepotGui = require("prototypes.gui.layout.traindepot")
local helpGui = require("prototypes.gui.layout.help-gui")

return function(configurationData)
  local modChanges = configurationData.mod_changes["trainConstructionSite"]
  if modChanges and modChanges.new_version ~= (modChanges.old_version or "") then
    log(string.format("Updating trainConstructionSite from version %q to version %q", modChanges.old_version or "nil", modChanges.new_version))

    --------------------------------------------------
    -- Prototype data                               --
    --------------------------------------------------
    for forceName, force in pairs(game.forces) do
      local technologies = force.technologies
      local recipes      = force.recipes

      if recipes["locomotive"].enabled then
        technologies["trainassembly-automated-train-assembling"].researched = true
      end

      if recipes["cargo-wagon"].enabled then
        technologies["trainassembly-cargo-wagon"].researched = true
     end

      if recipes["artillery-wagon"].enabled then
        technologies["trainassembly-artillery-wagon"].researched = true
      end

      force.reset_technology_effects()
    end

    --------------------------------------------------
    -- Trainassembly script                         --
    --------------------------------------------------
    if global.TA_data.version == 1 then
      log("Updating Trainassembly from version 1 to version 2.")
      global.TA_data.prototypeData.trainTint = {}
      global.TA_data.version = 2
    end

    if global.TA_data.version == 2 then
      log("Updating Trainassembly from version 2 to version 3.")
      global.TA_data.prototypeData.rollingStock =
      {
        ["locomotive"     ] = true,
        ["cargo-wagon"    ] = true,
        ["fluid-wagon"    ] = true,
        ["artillery-wagon"] = true,
      }
      global.TA_data.version = 3
    end

    if global.TA_data.version == 3 then
      log("Updating Trainassembly from version 3 to version 4.")
      for machineSurface,machineSurfaceData in pairs(global.TA_data and global.TA_data["trainAssemblers"] or {}) do
        for machinePositionY, machinePositionData in pairs(machineSurfaceData) do
          for machinePositionX, machineData in pairs(machinePositionData) do
            local renderIDs = {}
            local machineEntity = machineData.entity
            for animationLayer,renderLayer in pairs{
              ["base"] = 124,
              ["overlay"] = 133
            } do
              renderIDs[animationLayer] = rendering.draw_animation{
                animation = machineEntity.name .. "-" .. LSlib.utils.directions.toString(machineEntity.direction) .. "-" .. animationLayer,
                render_layer = renderLayer,
                target = machineEntity,
                surface = machineEntity.surface,
              }
            end
            global.TA_data["trainAssemblers"][machineSurface][machinePositionY][machinePositionX]["renderID"] = renderIDs
          end
        end
      end
      global.TA_data.version = 4
    end

    --------------------------------------------------
    -- Traincontroller script                       --
    --------------------------------------------------
    if global.TC_data.version == 1 then
      log("Updating Traincontroller from version 1 to version 2.")
      if LSlib.utils.table.isEmpty(global.TC_data["trainControllers"]) and global.TC_data["nextTrainControllerIterate"] then
        global.TC_data["nextTrainControllerIterate"] = nil
        Traincontroller.Builder:deactivateOnTick()
      end
      global.TC_data.version = 2
    end

    --------------------------------------------------
    -- Traincontroller.Gui script                   --
    --------------------------------------------------
    if global.TC_data.Gui.version == 1 then
      log("Updating Traincontroller.Gui from version 1 to version 2.")
      global.TC_data.Gui["prototypeData"]["trainControllerGui"] = trainControllerGui
      global.TC_data.Gui.version = 2
    end

    if global.TC_data.Gui.version == 2 then
      log("Updating Traincontroller.Gui from version 2 to version 3.")
      global.TC_data.Gui["clickHandler"] = nil
      global.TC_data.Gui.version = 3
    end

    if global.TC_data.Gui.version == 3 then
      log("Updating Traincontroller.Gui from version 3 to version 4.")
      global.TC_data.Gui["prototypeData"]["trainControllerGui"] = trainControllerGui
      global.TC_data.Gui.version = 4
    end

    --------------------------------------------------
    -- Traindepot script                            --
    --------------------------------------------------
    if global.TD_data.version == 1 then
      log("Updating Traindepot from version 1 to version 2.")
      global.TD_data.version = 2
    end

    --------------------------------------------------
    -- Traindepot.Gui script                        --
    --------------------------------------------------
    if global.TD_data.Gui.version == 1 then
      log("Updating Traindepot.Gui from version 1 to version 2.")
      global.TD_data.Gui["prototypeData"]["trainDepotGui"] = trainDepotGui
      global.TD_data.Gui.version = 2
    end

    if global.TD_data.Gui.version == 2 then
      log("Updating Traindepot.Gui from version 2 to version 3.")
      global.TD_data.Gui["clickHandler"] = nil
      global.TD_data.Gui.version = 3
    end

    if global.TD_data.Gui.version == 3 then
      log("Updating Traindepot.Gui from version 3 to version 4.")
      global.TD_data.Gui["prototypeData"]["trainDepotGui"] = trainDepotGui
      global.TD_data.Gui.version = 4
    end

    --------------------------------------------------
    -- Help.Gui script                              --
    --------------------------------------------------
    if global.H_data.Gui.version == 1 then
      log("Updating Help.Gui from version 1 to version 2.")
      global.H_data.Gui["clickHandler"] = nil
      global.H_data.Gui.version = 2
    end

    if global.H_data.Gui.version == 2 then
      log("Updating Help.Gui from version 2 to version 3.")
      global.H_data.Gui["prototypeData"]["helpGui"] = helpGui
      global.H_data.Gui.version = 3
    end

  end
end

