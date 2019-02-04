require 'util'
--require 'lib.util'
--require 'lib.table'

-- Create class
Traincontroller.Builder = {}

--------------------------------------------------------------------------------
-- Initiation of the class
--------------------------------------------------------------------------------
function Traincontroller.Builder:onInit()
  if not global.TC_data.Builder then
    global.TC_data.Builder = self:initGlobalData()
  end
end



function Traincontroller.Builder:onLoad()
  -- sync the on tick event
  if global.TC_data.Builder["onTickActive"] then
    self:activateOnTick()
  else
    self:deactivateOnTick()
  end
end



-- Initiation of the global data
function Traincontroller.Builder:initGlobalData()
  local Builder = {
    ["version"] = 1, -- version of the global data
    ["onTickActive"] = false, -- if the on_tick event is active or not
    ["onTickDelay"] = 5,

    ["builderStates"] = { -- states in the builder process
    },
  }

  return util.table.deepcopy(Builder)
end



--------------------------------------------------------------------------------
-- Behaviour functions, mostly event handlers
--------------------------------------------------------------------------------
function Traincontroller.Builder:onTick(event)
  game.print(event.tick)
end



function Traincontroller.Builder:activateOnTick()
  -- only need to activate it if its deactivated
  if not global.TC_data.Builder["onTickActive"] then
    --game.print("on_tick activated")
    script.on_nth_tick(global.TC_data.Builder["onTickDelay"], function(event)
      self:onTick(event)
    end)
    global.TC_data.Builder["onTickActive"] = true
  end
end



function Traincontroller.Builder:deactivateOnTick()
  -- only need to deactivate it if its not active
  if global.TC_data.Builder["onTickActive"] then
    --game.print("on_tick deactivated")
    script.on_nth_tick(global.TC_data.Builder["onTickDelay"], nil)
    global.TC_data.Builder["onTickActive"] = false
  end
end
