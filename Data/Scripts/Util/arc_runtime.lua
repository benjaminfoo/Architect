---
--- Created by Benjamin Foo
---
--- This file contains the runtime configuration and related methods.
---

config = {
    debugMode = true,
    primary_town_name = "",
    primary_town_position = { x = 0, y = 0, z = 0 },

}


-- set the position of the home
function SetHome()
    config.primary_town_position = player:GetPos()
    GetHome()
end

function GetHome()
    log(
            "Setting the home\'s position to " ..
                    "{" ..
                    "x: " .. config.primary_town_position.x ..
                    "y: " .. config.primary_town_position.y ..
                    "z: " .. config.primary_town_position.z ..
                    "}"
    )
end


-- set the players position the home position
function Home()
    player:SetWorldPos(config.primary_town_position)
end


-- set the town's name
function SetHomeName(newTownName)
    config.primary_town_position = newTownName
    log("Set the town-name to " .. config.primary_town_position .. ", congrats!")
end
