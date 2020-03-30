---
--- Author: Benjamin Foo
---

if (config.mockRuntime) then


    -- mocks methods from player.*
    player = {}
    Script["GetWorldPos"] = function()
        return { x = 1, y = 2, z = 3 }
    end


    -- mocks methods from Physics.*
    Physics = {}
    Physics["RayWorldIntersection"] = function(rayStart, rayDir, nr, ent_terrainPlusent_static, valO, valT, newGHitTable)
        print("Physics.RayWorldIntersection ... ")
        return 0
    end


    -- mocks methods from Script.*
    Script = {}
    Script["ReloadScripts"] = function()
        print("Reloading all scripts")
    end


    -- mocks methods from Game.*
    Game = {}

    Game["SendInfoText"] = function(displayedMessage, bAbortCurrent, any, duration)
        print("SendInfoText - called with: " .. displayedMessage)
    end


    -- mocks methods from System.*
    System = {}

    System["LogAlways"] = function(logMessage)
        print("LogAlways: " .. logMessage)
    end

    System["AddCCommand"] = function(cmdName, cmdFunc, cmdHelp)
        print("AddCCommand: " .. cmdName .. cmdFunc .. cmdHelp)
    end

end
