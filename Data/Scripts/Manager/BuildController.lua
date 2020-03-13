---
--- Created by Benjamin Foo
--- DateTime: 04.03.2020 23:09
---
--- The BuildController class defines basic and advanced operations
---

builtEntities = {}

-- boolean for toggling the required files
-- if loading is enabled, load the mockup api for kcd
--- (true) useful for debug mode / standalone mode (with lua or luac) or ingame mode (=false)
-- require = built-in lua-reloading
-- Script.ReloadScript = kcd lua-reloading
useRequireInsteadOfReload = false;

---- optional dependencies
if useRequireInsteadOfReload then

    -- loading mockup API of KCD
    System = require("MockAPI/System")
    Game = require("MockAPI/Game")
    player = require("MockAPI/player")
    Script = require("MockAPI/Script")
    Physics = require("MockAPI/Physics")

    linmath = require("linmath")
else
    Script.ReloadScript("Scripts/Math/linmath.lua")
end

---- building / architecture / resources

-- the current index of the building-selection
bIndex = 1

-- the id of the next construction, gets incremented
-- this could lead to misaligned indices
current = System.GetCurrTime()
math.randomseed(current)
random = math.random

-- this function generates a unique ID
function uuid()
    local template ='xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
    return string.gsub(template, '[xy]', function (c) v = (c == 'x') and random(0, 15) or random(8, 11) return string.format('%x', v) end)
end


function rayCastHit()
    System.LogAlways("# rayCastHit start")

    local from = player:GetPos();
    from.z = from.z + 1.615;

    local dir = System.GetViewCameraDir();
    dir = vecScale(dir, 250);

    local skip = player.id;

    local hitData = {};
    local hits = Physics.RayWorldIntersection(from, dir, 10, ent_all, skip, nil, hitData);

    if hits > 0 then
        return hitData[1];
    end

    System.LogAlways("# rayCastHit end")

end

-- spawn the currently selected entity with the current selection as modelpath
function SpawnBuildingInstance(line)
    System.LogAlways("# SpawnBuildingInstance start")

    hitData = rayCastHit()

    if(hitData ~= nil) then

        local entity = hitData
        System.LogAlways("Hit entity: " .. tostring(entity))


        -- construct the entity and setup its parameters
        local spawnParams = {}

        -- use the BasicBuildingEntity.lua as a class for this entity
        spawnParams.class = "BasicBuildingEntity"

        -- setup the position from the raycast hit
        spawnParams.position = entity.pos
        spawnParams.orientation = { x = 0, y = 0, z = 1 }

        -- setup naming and serialization
        spawnParams.properties = {}
        spawnParams.properties.bSaved_by_game = 1 -- non-persistent
        spawnParams.properties.bSerialize = 1 -- non-persistent

        -- use the input of %line if provided, else use the current building index for the selection of the building
        if(line ~= nil) then
            modelPath = line
        else
            modelPath = buildings[bIndex]
        end
        spawnParams.properties.object_Model = modelPath

        spawnParams.name = modelPath .. "_".. uuid()


        local ent = System.SpawnEntity(spawnParams)

        -- setup the rotation of the spawned entity align the y-axis
        local up = player:GetAngles()
        up = { up.x, up.y, up.z }
        ent:SetAngles(up)

        Game.SendInfoText("Constructing\n" .. tostring(ent:GetName()), true, nil, 1)

        -- undo / redo control, build history
        table.insert(builtEntities, ent)

    end

    System.LogAlways("# SpawnBuildingInstance end")
end

-- dumps information about the current "seen" entity to the console
function detectEntity()
    System.LogAlways("# detectEntity start")

    hitData = rayCastHit()

    if(hitData ~= nil) then

        result = hitData.entity;

        visRes = "Hit entity: " .. tostring(result:GetName()) .. "\n" .. "ID: " .. tostring(hitData.entity:GetRawId())

        log(result.id)
        Game.SendInfoText(visRes, true, nil, 1)
        builtEntities[#builtEntities-1] = nil

    end

    System.LogAlways("# detectEntity end")
end

-- delete the current entity (the entity which collides with the raycast)
function deleteRayCastEntityHit()
    System.LogAlways("# deleteRayCastEntityHit start")

    hitData = rayCastHit()

    if(hitData ~= nil) then

        result = hitData.entity;

        if(result ~= nil) then

            -- if there is something to delete, log its name to the player first
            visRes = "Removing entity: " .. tostring(result:GetName()) .. "\n" .. "ID: " .. tostring(hitData.entity:GetRawId())
            Game.SendInfoText(visRes, true, nil, 1)

            -- remove the entity by its id
            System.RemoveEntity(hitData.entity.id)
        end

    end

    System.LogAlways("# deleteRayCastEntityHit end")
end


-- lists all built constructions by the player to the console
function showall()
    for i = 1, #builtEntities do
        if(builtEntities[i] ~= nil and i ~= nil) then
            log("Built (" .. tostring(i) .. ") = " .. tostring(builtEntities[i]))
        end
    end
end

function deleteAt(index)
    if(index) then
        deletionEntity = builtEntities[index]
        System.RemoveEntity(deletionEntity.id)
        log("Deleting " .. tostring(deletionEntity))
        builtEntities[index] = nil
    end
end

--[[ Increments the index of the currently selected building when the player uses the mousewheel (up) ]]
function bIndexInc()

    -- update the current building for the ui-controller
    -- TODO: refactor global variables from UIController to object instances

    if bIndex < #buildings then
        bIndex = bIndex + 1
        l("Increment bIndex to " .. tostring(bIndex))

    end

    -- update the current building for the ui-controller
    -- TODO: refactor global variables from UIController to object instances
    modelPath = buildings[bIndex]
    res_current_model = modelPath;

    Game.SendInfoText("Selected (" .. bIndex ..  "/" .. #buildings .. ")\n " .. tostring(res_current_model), true, nil, 1)

end


--[[ Decrements the index of the currently selected building when the player uses the mousewheel (up)  ]]
function bIndexDec()

    if bIndex > 1 then
        bIndex = bIndex - 1

        if bIndex == 0 then
            return
        end

        l("Decrement bIndex to " .. tostring(bIndex))

    end

    -- update the current building for the ui-controller
    -- TODO: refactor global variables from UIController to object instances
    modelPath = buildings[bIndex]
    res_current_model = modelPath;

    Game.SendInfoText("Selected (" .. bIndex ..  "/" .. #buildings .. ")\n " .. tostring(res_current_model), true, nil, 1)

end


--[[
    Helper methods
]]


-- removes all entities of class "BasicBuildingEntity"
function deleteall ()
    -- local ents =  System.GetEntitiesByClass("BasicBuildingEntity")
    local ents =  System.GetEntitiesByClass("BasicBuildingEntity")
    for i,e in pairs(ents) do
        -- remove the entity from the game
        System.RemoveEntity(e.id)
    end
end


-- reloads all scripts but is shorter to type into console
function reloadall ()
    Script.ReloadScripts()
end


--[[
    Add & bind user commands to the ingame-console
]]

-- Increment the current building index, mouse wheel up
System.AddCCommand('bIndexInc', 'bIndexInc()', "bIndexInc!")
--System.ExecuteCommand("bind mwheel_up bIndexInc")

-- Decrement the current building index, mouse wheel down
System.AddCCommand('bIndexDec', 'bIndexDec()', "bIndexDec!")
--System.ExecuteCommand("bind mwheel_down bIndexDec")

-- Spawn the currently selected building
System.AddCCommand('architect_spawn', 'SpawnBuildingInstance()', "architect_spawn!")
--System.ExecuteCommand("bind mouse3 architect_spawn ")

-- Delete the current "seen" entity
System.AddCCommand('deleteRayCastEntityHit', 'deleteRayCastEntityHit()', "deleteRayCastEntityHit!")
--System.ExecuteCommand("bind mouse4 deleteRayCastEntityHit ")

-- Detect / dump information about the current "seen" entity
System.AddCCommand('detectEntity', 'detectEntity()', "detectEntity!")
--System.ExecuteCommand("bind mouse5 detectEntity ")

