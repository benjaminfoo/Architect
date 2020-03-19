---
--- Created by Benjamin Foo
--- DateTime: 04.03.2020 23:09
---
--- The EventManager handles the initialization of the UIManager and shows tutorial messages to the player
---

architect_init = {}

function showUsage()
    -- create controller for the ingame user-interface
    -- Script.UnloadScript("Scripts/Manager/arc_UIController.lua")
    -- Script.ReloadScript("Scripts/Manager/arc_UIController.lua")
    uiManagerParams = {}
    uiManagerParams.class = "UIManager"
    uiManagerParams.name = "UIManager_Instance"

    uiManagerEntity = System.SpawnEntity(uiManagerParams)

    message = "<font color='#333333' size='8'>\n</font>"
            .. "<font color='#333333' size='32'>Architect " .. architect_version .. "</font>" .. "\n"
            .. "<font color='#333333' size='14'>codename: Farklewood</font>" .. "\n"
            .. "<font color='#333333' size='8'>\n</font>"
            .. "<font color='#333333' size='16'>An advanced base-building modification for kingdom come deliverance.</font>" .. "\n"

            .. "<font color='#333333' size='18'>\nKey Mousewheel up/down</font>" .. "\n"
            .. "<font color='#333333' size='16'>Choose construction</font>" .. "\n"

            .. "<font color='#333333' size='18'>\nKey V </font>" .. "\n"
            .. "<font color='#333333' size='16'>Create construction</font>" .. "\n"

            .. "<font color='#333333' size='18'>\nKey G </font>" .. "\n"
            .. "<font color='#333333' size='16'>Remove construction</font>" .. "\n"

            .. "<font color='#333333' size='18'>\nKey O </font>" .. "\n"
            .. "<font color='#333333' size='16'>Toggle deletion of entity-lock</font>" .. "\n\n"

            .. "<font color='#333333' size='16'>Execute architect_help in the ingame console for additional help.</font>" .. "\n\n"

            .. "<font color='#333333' size='18'>Contact - Ideas, Feedback, etc.</font>" .. "\n"
            .. "<font color='#333333' size='14'>http://github.com/benjaminfoo/architect/</font>" .. "\n"

    -- create tutorial and show
    Game.ShowTutorial(message, 20, false, true)

end

function architect_init:sceneInitListener(actionName, eventName, argTable)

    -- System.LogAlways("actionName: " .. actionName)
    -- System.LogAlways("eventName: " .. eventName)

    if argTable then
        -- System.LogAlways("argTable: " .. tostring(eventName))
    end

    if actionName == "sys_loadingimagescreen" and eventName == "OnEnd" then
        showUsage()
    end
end

UIAction.UnregisterActionListener(architect_init, "sceneInitListener")
UIAction.RegisterActionListener(architect_init, "", "", "sceneInitListener")

--[[

    -- this code leads to crashes !
    UIAction.UnregisterEventSystemListener(architect_init, "uiEventSystemListener")
    UIAction.RegisterEventSystemListener(architect_init, "", "", "uiEventSystemListener")

    -- this code leads to crashes !
    function architect_init:uiEventSystemListener(actionName, eventName, argTable)

        System.LogAlways("ui-event: actionName: " .. actionName)
        System.LogAlways("ui-event: eventName: " .. eventName)

        if argTable then
            System.LogAlways("ui-event: argTable: " .. tostring(eventName))
        end

    end

]]
