---
--- Entry point for the project
--- Author:  Benjamin Foo
--- DateTime: 03.03.2020 01:01
---

-- added runtime configuration, basic town management
Script.ReloadScript("Scripts/Util/arc_runtime.lua")

-- Load simple constants or runtime settings
Script.ReloadScript("Scripts/Util/arc_constants.lua")

-- string handling
Script.ReloadScript("Scripts/Util/arc_string.lua")

-- load mathematical operations for lua
Script.ReloadScript("Scripts/Math/arc_linmath.lua")

-- load utility methods for development
Script.ReloadScript("Scripts/Util/arc_utils.lua")

-- initialize itemset- and manager
Script.ReloadScript("Scripts/Controller/arc_ItemController.lua")

-- load the console-commands manager
Script.ReloadScript("Scripts/Manager/arc_CCommandManager.lua")

-- load the buildings-manager
Script.ReloadScript("Scripts/Manager/arc_BuildingsManager.lua")

-- add event-handlers for common in-game events
Script.ReloadScript("Scripts/Manager/arc_EventManager.lua")

-- load the core api of the project
Script.ReloadScript("Scripts/Controller/arc_ConstructionController.lua")

-- load the resource-system, basic
Script.ReloadScript("Scripts/Controller/arc_ResourcesController.lua")

-- add different kind of ways to use core functions and allow case support
Script.ReloadScript("Scripts/Util/arc_CammelCaseSupport.lua")

-- keybindings as fallback,
-- these will be overwritten if keybinds.cfg is correctly set and loaded
System.ExecuteCommand("bind mwheel_up bIndexInc")           -- select the next construction
System.ExecuteCommand("bind mwheel_down bIndexDec")         -- select the previous construction
System.ExecuteCommand("bind 'v' architect_spawn")           -- create the current construction
System.ExecuteCommand("bind 'g' deleteRayCastEntityHit")    -- delete the currently facing entity (the thing you looking at)
System.ExecuteCommand("bind 'o' toggleEntityLock")              -- debug: print information about currently facing entity
System.ExecuteCommand("bind f9 architect_recompile")        -- debug: reload the mods sources

-- load external key bindings
-- these file must be stored under:
-- <path-to-steam-folder>\steamapps\common\KingdomComeDeliverance\mods\architect\keybinds.cfg
System.ExecuteCommand('exec mods/architect/keybinds.cfg')

-- if this gets printed the mod should work :)
System.LogAlways("architect " .. architect_version .. " - initialized!")
