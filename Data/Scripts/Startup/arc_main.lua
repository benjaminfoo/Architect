---
--- Entry point for the project
--- Created by Benjamin Foo
--- DateTime: 03.03.2020 01:01
---

-- Load simple constants or runtime settings
Script.ReloadScript("Scripts/Util/arc_constants.lua")

-- load mathematical operations for lua
Script.ReloadScript("Scripts/Math/arc_linmath.lua")

-- load utility methods for development
Script.ReloadScript("Scripts/Util/arc_utils.lua")

-- load the console-commands manager
Script.ReloadScript("Scripts/Manager/arc_CCommandManager.lua")

-- load the buildings-manager
Script.ReloadScript("Scripts/Manager/arc_BuildingsManager.lua")

-- add event-handlers for common in-game events
Script.ReloadScript("Scripts/Manager/arc_EventManager.lua")

-- load the core api of the project
Script.ReloadScript("Scripts/Manager/arc_ConstructionController.lua")

-- load the resource-system, basic
Script.ReloadScript("Scripts/Manager/arc_ResourcesController.lua")

-- load external key bindings
System.ExecuteCommand('exec Mods/architect/keybinds.cfg')
System.ExecuteCommand('exec Mods/architect_release/keybinds.cfg')

-- if this gets printed the mod should work :)
System.LogAlways("architect " .. architect_version .. " - initialized!")
