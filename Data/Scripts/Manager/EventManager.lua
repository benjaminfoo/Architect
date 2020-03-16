---
--- Created by Benjamin Foo
--- DateTime: 04.03.2020 23:09
---
--- The EventManager handles the initialization of the UIManager and shows tutorial messages to the player
---

architect_init = {}

function architect_init:uiActionListener(actionName, eventName, argTable)

    -- System.LogAlways("actionName: " .. actionName)
    -- System.LogAlways("eventName: " .. eventName)

    if argTable then
        -- System.LogAlways("argTable: " .. tostring(eventName))
    end

    if actionName == "sys_loadingimagescreen" and eventName == "OnEnd" then
        -- create controller for the ingame user-interface
        -- Script.UnloadScript("Scripts/Manager/UIController.lua")
        -- Script.ReloadScript("Scripts/Manager/UIController.lua")
        uiManagerParams = {}
        uiManagerParams.class = "UIManager"
        uiManagerParams.name = "UIManager_Instance"

        uiManagerEntity = System.SpawnEntity(uiManagerParams)

        -- create tutorial and show
        showMessage = "<font color='#333333' size='34'>Architect " .. architect_version .. "</font> <font color='#333333' size='18'>\nA base-building / resource-management modification for kingdom come deliverance.</font>"
        showMessageT = "<font color='#333333' size='20'>\n\nUsage / Keys\n</font><font color='#333333' size='18'>\nMousewheel up/down \nChoose construction\n\nKey V \nCreate construction \n\nKey G \nRemove construction </font> \n\n"
        showMessageTT = "<font color='#333333' size='18'>F9 \nRecompile mod at runtime\n\nContact\n"

        third = "<font color='#333333' size='14'>http://github.com/benjaminfoo/architect/</font> \n\n"
        fourth = "<font color='#333333' size='18'>Execute architect_help in the ingame console for additional help.</font> \n\n"
        Game.ShowTutorial(showMessage .. showMessageT .. showMessageTT .. third .. fourth, 20, false, true)
    end
end

UIAction.UnregisterActionListener(architect_init, "uiActionListener")
UIAction.RegisterActionListener(architect_init, "", "", "uiActionListener")

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
