---
--- Created by Benjamin Foo
---
--- This file contains the runtime configuration and related methods.
---

config = {
    modEnabled = true,
    debugMode = true,
    primary_town_name = "Farkletown",
    primary_town_position = { x = 0, y = 0, z = 0 },
}

-- TODO: These values need to get stored
-- TODO: Implement an entity which stores this values OnSave and restores OnLoad


-- set the position of the home
function SetHome()
    config.primary_town_position = player:GetPos()
    log("Setting the home\'s position to " .. Vec2Str(config.primary_town_position))
end

-- not a real getter though ...
function GetHome()
    player:SetWorldPos(config.primary_town_position)
    log("Returning to .. " .. config.primary_town_name .. " at " .. Vec2Str(config.primary_town_position))
end

-- set the town's name
function SetHomeName(newTownName)
    config.primary_town_name = newTownName
    log("Set the town-name to " .. config.primary_town_name .. ", congrats!")
end


-- Changes the current weather to cloudless_sunny
-- The sun is shining, the weather is sweet yeah.
function MakeSunshine()
    EnvironmentModule.BlendTimeOfDay('cloudless_sunny', 1, 1)
    EnvironmentModule.ForceImmediateWeatherUpdate()
end

function toggleModState()

    -- toggle the mods state
    config.modEnabled = not config.modEnabled

    -- define a message for user feedback
    message = ""

    -- setup message and display it for some seconds
    if (config.modEnabled) then
        message = "The mod has been enabled."

        -- init
        spawnPreview()

    else
        message = "The mod has been disabled."

        -- shutdown


        -- remove preview entity
        if (previewModelEntity ~= nil) then
            System.LogAlways("Removing preview ...")

            System.RemoveEntity(previewModelEntity.id)
            previewModelEntity = nil
        end
    end

    Game.SendInfoText(message, true, nil, 3)

end

System.AddCCommand('toggleModState', 'toggleModState()', "toggleModState!")
System.ExecuteCommand("bind 'h' toggleModState ")
