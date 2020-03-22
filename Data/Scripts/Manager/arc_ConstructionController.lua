---
--- Created by Benjamin Foo
--- DateTime: 04.03.2020 23:09
---
--- The ConstructionController class defines basic and advanced operations
---

builtEntities = {}

-- the current index of the building-selection
-- the id of the next construction, gets incremented
bIndex = 1

-- the set of elements which are allowed to delete by the user
whitelistSet = {
    "BasicBuildingEntity",
    "BedEntity",
    "ChairEntity",
    "CookingSpotEntity",
    "DynamicBuildingEntity",
    "GeneratorEntity",
    "UIManager"
}

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
        dump(hitData[1])
        return hitData[1];
    end

    System.LogAlways("# rayCastHit end")

end

-- remove an item by its class and by an amount
-- class = example - bread, 86e4ff24-88db-4024-abe6-46545fa0fbd1
-- deleteAmount = how often an item gets removed
function removeItem(itemRemovedByClass, deleteAmount)
    local removed = 0
    for i, userdata in pairs(player.inventory:GetInventoryTable()) do
        local item = ItemManager.GetItem(userdata)
        for i = 1, item.amount do
            if (item.class == itemRemovedByClass) then
                if (removed < deleteAmount) then
                    removed = removed + 1
                    player.inventory:RemoveItem(item.id, 1)
                end
            end
        end
    end
end

-- TODO: this is just a placeholder variable
-- in order to execute crafting
availableResources = 999

-- spawn the currently selected entity with the current selection as modelpath
function SpawnBuildingInstance(line)
    System.LogAlways("# SpawnBuildingInstance start")

    hitData = rayCastHit()

    if (hitData ~= nil) then

        local entity = hitData

        -- System.LogAlways("Hit entity: " .. tostring(entity))

        -- construct the entity and setup its parameters
        local spawnParams = {}

        -- use arc_BasicBuildingEntity.lua as type for static constructions
        spawnParams.class = "BasicBuildingEntity"

        -- use arc_DynamicBuildingEntity.lua as type for constructions with any kind of functionality
        -- spawnParams.class = "DynamicBuildingEntity"

        -- setup the position from the raycast hit
        spawnParams.position = entity.pos
        spawnParams.orientation = { x = 0, y = 0, z = 1 }

        -- setup naming and serialization
        spawnParams.properties = {}
        spawnParams.properties.bSaved_by_game = 1
        spawnParams.properties.bSerialize = 1

        -- use the input of %line if provided, else use the current building index for the selection of the building
        -- if(line ~= nil) then modelPath = line else  modelPath = parameterizedConstructions[bIndex] end

        -- get the path of the model for the construction
        construction = parameterizedConstructions[bIndex]
        spawnParams.properties.object_Model = construction.modelPath

        -- generate a unique name for the entity
        spawnParams.name = construction.modelPath .. "_" .. uuid()

        if (construction.sitable) then
            spawnParams.class = "ChairEntity"
        end

        if (construction.sleepable) then
            spawnParams.class = "BedEntity"
        end

        if (construction.cookable) then
            spawnParams.class = "CookingSpotEntity"
        end

        if (construction.useable) then
            -- spawnParams.class = "GeneratorEntity"
            -- spawnParams.class = "ShootingTarget"
            spawnParams.class = "RigidBody"
            spawnParams.properties.objModel = "Objects/buildings/houses/budin_mill/barrel_01.cgf"

        end

        -- finish any work _before_ the entity gets initialized and spawned

        -- spawn the new entity
        local ent = System.SpawnEntity(spawnParams)

        -- setup the entity within the world _after_ it has been spawned
        if construction.sitable then
        end

        if construction.sleepable then
        end

        if (construction.useable) then
        end

        if (construction.cookable) then
        end


        -- setup the rotation of the spawned entity align the y-axis
        local up = player:GetAngles()
        up = { up.x, up.y, up.z }
        ent:SetAngles(up)

        Game.SendInfoText("Constructing\n" .. tostring(ent:GetName()), true, nil, 2)

        -- undo / redo control, build history
        table.insert(builtEntities, ent)

    end

    System.LogAlways("# SpawnBuildingInstance end")
end



-- Toggles the currently "seen" deletion_lock state
-- If the entity's deletion_lock property's value equals to zero, it wont be deleted
-- Also dumps information about the current entity to the console
function toggleEntityLock()
    System.LogAlways("# toggleEntityLock start")

    -- execute a raycast within the players fov
    hitData = rayCastHit()

    -- if our ray collided with something ...
    if (hitData ~= nil) then

        -- get the entity from the collision
        result = hitData.entity;

        -- if there was an entity related to this collision ...
        if result ~= nil then

            -- toggle the current state (true => false, false => true)
            result.Properties.deletion_lock = not result.Properties.deletion_lock

            if (result.Properties.deletion_lock) then
                visRes = "Locked entity: " .. tostring(result:GetName()) .. "\n" .. "ID: " .. tostring(hitData.entity:GetRawId())
            else
                visRes = "Unlocked entity: " .. tostring(result:GetName()) .. "\n" .. "ID: " .. tostring(hitData.entity:GetRawId())
            end

            -- output state message
            Game.SendInfoText(visRes, true, nil, 1)

        end

    end

    System.LogAlways("# toggleEntityLock end")
end

-- delete the current entity (the entity which collides with the raycast)
function deleteRayCastEntityHit()
    System.LogAlways("# deleteRayCastEntityHit start")

    hitData = rayCastHit()

    if (hitData ~= nil and hitData.entity ~= nil and hitData.entity.class ~= nil) then

        result = hitData.entity;

        -- We only want to delete our constructions,
        -- so we keep a whitelist of everything - if the hit entity is within the list, the entity will get deleted
        if (contains(whitelistSet, result.class)) then

            -- if there is something to delete, log its name to the player first
            visRes = "Removing entity: " .. tostring(result:GetName()) .. "\n" .. "ID: " .. tostring(hitData.entity:GetRawId())
            Game.SendInfoText(visRes, true, nil, 1)

            if (result.Properties.deletion_lock == false) then
                -- remove the entity by its id
                System.RemoveEntity(result.id)
            end

        end

    end

    System.LogAlways("# deleteRayCastEntityHit end")
end


-- list all elements of the whitelist
function show_whitelist()
    System.LogAlways("Elements of the whitelist:")
    for i = 1, #whitelistSet do
        System.LogAlways(tostring(i) .. ".) " .. whitelistSet[i])
    end
end

-- lists all built constructions by the player to the console
function showall()
    for i = 1, #builtEntities do
        if (builtEntities[i] ~= nil and i ~= nil) then
            log("Built (" .. tostring(i) .. ") = " .. tostring(builtEntities[i]))
        end
    end
end

-- Delete an existing construction by its build-index
function deleteAt(index)
    if (index) then

        deletionEntity = builtEntities[index]

        if (deletionEntity ~= nil and e.Properties.deletion_lock == false) then
            System.RemoveEntity(deletionEntity.id)
        end

        log("Deleting " .. tostring(deletionEntity))
        builtEntities[index] = nil


    end
end

--[[ Increments the index of the currently selected building when the player uses the mousewheel (up) ]]
function bIndexInc()

    -- update the current building for the ui-controller
    -- TODO: refactor global variables from UIController to object instances

    if bIndex < #parameterizedConstructions then
        bIndex = bIndex + 1
        l("Increment bIndex to " .. tostring(bIndex))
    end

    -- update the current building for the ui-controller
    -- TODO: refactor global variables from UIController to object instances
    updateSelection()

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
    updateSelection()

end

function updateSelection()
    modelPath = parameterizedConstructions[bIndex]
    res_current_model = modelPath;
    Game.SendInfoText(
            "Selected (" .. bIndex .. "/" .. #parameterizedConstructions .. ")\n" .. tostring(parameterizedConstructions[bIndex].modelPath)
    , true, nil, 1)
end


--[[
        Helper methods
--]]


-- removes all whitelisted entities by their classes
function deleteall ()

    --[[
    -- local ents = System.GetEntitiesByClass("BasicBuildingEntity")
        for i, e in pairs(ents) do
            -- remove the entity from the game
            System.RemoveEntity(e.id)
        end
    --]]

    for i = 1, #whitelistSet do

        whitelistElem = whitelistSet[i]

        local ents = System.GetEntitiesByClass(whitelistElem)

        -- TODO: update the stats, exclude the entities with deletion_lock = true
        System.LogAlways("Removing " .. #ents .. " entities with class " .. whitelistElem)

        for i, e in pairs(ents) do
            if (e.Properties.deletion_lock == false) then
                -- remove the entity from the game by its id
                System.RemoveEntity(e.id)
            end
        end

    end

end
-- reloads all scripts but is shorter to type into console
function reloadall ()

    -- unload all controller first
    Script.UnloadScript("Scripts/Manager/arc_UIController.lua")
    Script.UnloadScript("Scripts/Manager/arc_ConstructionController.lua")
    Script.UnloadScript("Scripts/Manager/arc_BuildingsManager.lua")
    Script.UnloadScript("Scripts/Manager/arc_CCommandManager.lua")

    Script.UnloadScript("Scripts/Util/arc_constants.lua")
    Script.UnloadScript("Scripts/Util/arc_utils.lua")


    -- unload entity related scripts (which MUST be inside pak structure at least once)
    Script.UnloadScript("Scripts/Entities/arc_BasicBuildingEntity.lua")
    Script.UnloadScript("Scripts/Entities/arc_DynamicBuildingEntity.lua")
    Script.UnloadScript("Scripts/Entities/arc_CookingSpotEntity.lua")
    Script.UnloadScript("Scripts/Entities/arc_GeneratorEntity.lua")

    -- reload everything
    Script.ReloadScripts()

    Script.ReloadEntityScript("Scripts/Entities/arc_BasicBuildingEntity.lua")
    Script.ReloadEntityScript("Scripts/Entities/arc_DynamicBuildingEntity.lua")
    Script.ReloadEntityScript("Scripts/Entities/arc_CookingSpotEntity.lua")
    Script.ReloadEntityScript("Scripts/Entities/arc_GeneratorEntity.lua")

    Script.ReloadScript("Scripts/Util/arc_constants.lua")
    Script.ReloadScript("Scripts/Util/arc_utils.lua")

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
System.AddCCommand('toggleEntityLock', 'toggleEntityLock()', "toggleEntityLock!")
--System.ExecuteCommand("bind mouse5 toggleEntityLock ")


-- helper methods and commands
function SelectFirst()
    bIndex = 1
    updateSelection()
end

function SelectLast()
    bIndex = #parameterizedConstructions - 1
    updateSelection()
end

function SelectIndex(newIndex)
    bIndex = newIndex;
    updateSelection()
end

-- This code is used to obtain resources after the player used the entity to gather resources
Script.SetTimerForFunction(1000, "GatherStone", {}, false)

function GatherStone(self)
    -- System.LogAlways("HELLO ")
end

-- what do we want to do today?
-- basic resource management?
--- basic resource costs

-- preview for building
