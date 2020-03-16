---
--- Entry point for the project
--- Created by Benjamin Foo
--- DateTime: 03.03.2020 01:01
---

-- Load simple constants or runtime settings
Script.ReloadScript("Scripts/Util/Constants.lua")

-- load mathematical operations for lua
Script.ReloadScript("Scripts/Math/linmath.lua")

-- load utility methods for development
Script.ReloadScript("Scripts/Util/Utils.lua")

-- load the console-commands manager
Script.ReloadScript("Scripts/Manager/CCommandManager.lua")

-- load the buildings-manager
Script.ReloadScript("Scripts/Manager/BuildingsManager.lua")

-- add event-handlers for common in-game events
Script.ReloadScript("Scripts/Manager/EventManager.lua")

-- load the core api of the project
Script.ReloadScript("Scripts/Manager/ConstructionController.lua")

-- load the resource-system, basic
Script.ReloadScript("Scripts/Manager/ResourcesController.lua")

-- load external key bindings
System.ExecuteCommand('exec Mods/architect/keybinds.cfg')
System.ExecuteCommand('exec Mods/architect_release/keybinds.cfg')

-- if this gets printed the mod should work :)
System.LogAlways("architect " .. architect_version .. " - initialized!")
