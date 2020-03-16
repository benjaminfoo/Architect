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

        -- use BasicBuildingEntity.lua as type for static constructions
        spawnParams.class = "BasicBuildingEntity"

        -- use DynamicBuildingEntity.lua as type for constructions with any kind of functionality
        -- spawnParams.class = "DynamicBuildingEntity"

        -- setup the position from the raycast hit
        spawnParams.position = entity.pos
        spawnParams.orientation = { x = 0, y = 0, z = 1 }

        -- setup naming and serialization
        spawnParams.properties = {}
        spawnParams.properties.bSaved_by_game = 1
        spawnParams.properties.bSerialize = 1

        -- use the input of %line if provided, else use the current building index for the selection of the building
        --[[
        if(line ~= nil) then
            modelPath = line
        else
            modelPath = parameterizedConstructions[bIndex]
        end
        ]]

        -- get the path of the model for the construction
        construction = parameterizedConstructions[bIndex]
        spawnParams.properties.object_Model = construction.modelPath

        -- generate a unique name for the entity
        spawnParams.name = construction.modelPath .. "_" .. uuid()

        if (construction.sitable) then
            spawnParams.properties.guidSmartObjectType = "2320f814-8ec1-430d-860f-960286323dbc"
            spawnParams.properties.soclasses_SmartObjectHelpers = "Bench_1Place_noTable"
            spawnParams.properties.sWH_AI_EntityCategory = "Seat"
        end

        if (construction.sleepable) then
            spawnParams.class = "DynamicBuildingEntity"
        end

        if (construction.cookable) then
            spawnParams.class = "CookingSpotEntity"
        end

        -- spawn the new entity
        local ent = System.SpawnEntity(spawnParams)

        -- setup the entity within the world after it has been spawned
        if construction.sitable then
            ent.GetActions = function(user, firstFast)
                output = {}
                AddInteractorAction(output, firstFast, Action():hint("@ui_hud_sit"):action("use"):func(ent.OnUsed):interaction(inr_bedSleep):enabled(1))
                return output
            end
            ent.OnUsed = function(user)
                XGenAIModule.SendMessageToEntity(player.this.id, "player:request", "target(" .. Framework.WUIDToMsg(XGenAIModule.GetMyWUID(ent)) .. "), mode ('use')")
            end
        end

        if construction.sleepable then
        end

        if (construction.cookable) then
            ent.GetActions = function(user, firstFast)
                output = {}
                AddInteractorAction(output, firstFast, Action():hint("Bake bread"):action("use"):func(ent.OnUsed):interaction(inr_chair):enabled(1))
                return output
            end
            -- executed when this entity has been used
            ent.OnUsed = function(user)

                -- TODO: This is all in todo state!
                --[[
                -- remove item with UUID from inventory
                -- local removeableItemUUID = "86e4ff24-88db-4024-abe6-46545fa0fbd1" == bread
                    for i,dat in pairs(player.inventory:GetInventoryTable()) do
                        local item = ItemManager.GetItem(dat)
                        for i=1, item.amount do
                            if(item.class == removeableItemUUID) then
                                player.inventory:RemoveItem(item.id, 1)
                            end
                        end
                    end

                    -- Syntax: Database.LoadTable("player_item")
                    -- Loads or reloads table. Returns true if table is loaded.

                    -- Syntax: Database.GetTableInfo("player_item")
                    -- Returns lua table with C_Table properties.

                    -- true if table was loaded
                    log("Entity " .. ent:GetName() .. " has been used!")

                ]]


                -- This is only a prototype
                -- TODO: define needed resources for newly crafted items
                -- TODO: define dynamic amounts for recipes and results

                -- 5e9b4fa1-aafa-4352-b5d6-58df2c263caa : Nettle
                local recipeName = "Bread"
                local costUUIDs = "5e9b4fa1-aafa-4352-b5d6-58df2c263caa"
                local costAmount = 1
                local costResource = "Nettle"



                -- bread:  86e4ff24-88db-4024-abe6-46545fa0fbd1
                local craftedResourceUUID = "86e4ff24-88db-4024-abe6-46545fa0fbd1"
                local craftedAmount = 1
                local playerTable = "player_item"

                -- 1. Check if costs are covered for creating the construction
                if (availableResources - costAmount >= 0) then

                    -- 2. Remove costs from inventory
                    removeItem(costUUIDs, costAmount)

                    -- this is for debugging purposes - this should work two times
                    availableResources = availableResources - costAmount

                    resultSuccess = Database.LoadTable(playerTable)

                    -- 3. Create new item instance, add to inventory
                    newItemInstance = ItemManager.CreateItem(craftedResourceUUID, 100, craftedAmount)
                    player.inventory:AddItem(newItemInstance);

                    Game.SendInfoText("Created " .. craftedAmount .. "x " .. recipeName .. " for " .. costAmount .. "x " .. costResource
                            .. "\n" .. "" .. costResource .. " left: " .. tostring(availableResources), true, nil, 3)
                else
                    -- If there arent enough resources available than needed, abort this
                    Game.SendInfoText("Not enough resources for " .. craftedAmount .. "x " .. recipeName, true, nil, 3)
                end

                XGenAIModule.SendMessageToEntity(player.this.id, "player:request", "target(" .. Framework.WUIDToMsg(XGenAIModule.GetMyWUID(ent)) .. "), mode ('use')")
            end
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



-- dumps information about the current "seen" entity to the console
function detectEntity()
    System.LogAlways("# detectEntity start")

    hitData = rayCastHit()

    if (hitData ~= nil) then

        result = hitData.entity;

        visRes = "Hit entity: " .. tostring(result:GetName()) .. "\n" .. "ID: " .. tostring(hitData.entity:GetRawId())

        log(result.id)
        Game.SendInfoText(visRes, true, nil, 1)
        builtEntities[#builtEntities - 1] = nil

    end

    System.LogAlways("# detectEntity end")
end

-- delete the current entity (the entity which collides with the raycast)
function deleteRayCastEntityHit()
    System.LogAlways("# deleteRayCastEntityHit start")

    hitData = rayCastHit()

    if (hitData ~= nil) then

        result = hitData.entity;

        if (result ~= nil) then

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
        if (builtEntities[i] ~= nil and i ~= nil) then
            log("Built (" .. tostring(i) .. ") = " .. tostring(builtEntities[i]))
        end
    end
end

function deleteAt(index)
    if (index) then
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

    if bIndex < #parameterizedConstructions then
        bIndex = bIndex + 1
        l("Increment bIndex to " .. tostring(bIndex))
    end

    -- update the current building for the ui-controller
    -- TODO: refactor global variables from UIController to object instances
    modelPath = parameterizedConstructions[bIndex]
    res_current_model = modelPath;

    Game.SendInfoText("Selected (" .. bIndex .. "/" .. #parameterizedConstructions .. ")\n" .. tostring(parameterizedConstructions[bIndex].modelPath), true, nil, 1)

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
    modelPath = parameterizedConstructions[bIndex]
    res_current_model = modelPath;

    Game.SendInfoText("Selected (" .. bIndex .. "/" .. #parameterizedConstructions .. ")\n" .. tostring(parameterizedConstructions[bIndex].modelPath), true, nil, 1)

end


--[[
    Helper methods
]]


-- removes all entities of class "BasicBuildingEntity"
function deleteall ()
    -- local ents =  System.GetEntitiesByClass("BasicBuildingEntity")
    local ents = System.GetEntitiesByClass("BasicBuildingEntity")
    for i, e in pairs(ents) do
        -- remove the entity from the game
        System.RemoveEntity(e.id)
    end
end


-- reloads all scripts but is shorter to type into console
function reloadall ()
    -- unload all controller first
    Script.UnloadScript("Scripts/Manager/UIController.lua")
    Script.UnloadScript("Scripts/Manager/ConstructionController.lua")
    Script.UnloadScript("Scripts/Manager/BuildingsManager.lua")
    Script.UnloadScript("Scripts/Manager/CCommandManager.lua")
    Script.UnloadScript("Scripts/Util/Constants.lua")

    -- unload entity related scripts (which MUST be inside pak structure at least once)
    Script.UnloadScript("Scripts/Entities/BasicBuildingEntity.lua")
    Script.UnloadScript("Scripts/Entities/DynamicBuildingEntity.lua")
    Script.UnloadScript("Scripts/Entities/CookingSpotEntity.lua")
    Script.UnloadScript("Scripts/Entities/GeneratorEntity.lua")

    Script.ReloadEntityScript("Scripts/Entities/BasicBuildingEntity.lua")
    Script.ReloadEntityScript("Scripts/Entities/DynamicBuildingEntity.lua")
    Script.ReloadEntityScript("Scripts/Entities/CookingSpotEntity.lua")
    Script.ReloadEntityScript("Scripts/Entities/GeneratorEntity.lua")

    -- reload everything
    Script.ReloadScripts()

    Script.ReloadEntityScript("Scripts/Entities/BasicBuildingEntity.lua")
    Script.ReloadEntityScript("Scripts/Entities/DynamicBuildingEntity.lua")
    Script.ReloadEntityScript("Scripts/Entities/CookingSpotEntity.lua")
    Script.ReloadEntityScript("Scripts/Entities/GeneratorEntity.lua")

    Script.ReloadScript("Scripts/Util/Constants.lua")

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

