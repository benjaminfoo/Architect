---
--- Author:  Benjamin Foo
---
--- Description
--- The EventManager handles the initialization of the UIManager and shows tutorial messages to the player
---

architect_init = {}

-- initialize the user-interface and show the introduction message
function showUsage()

    -- if there already is a uiManagerEntity, remove it
    if (uiManagerEntity ~= nil) then
        System.RemoveEntity(uiManagerEntity.id)
        uiManagerEntity = nil
        log("Removed uiManagerEntity")
    end

    -- if there already is a ecsManagerEntity, remove it
    if (ecsManagerEntity ~= nil) then
        System.RemoveEntity(ecsManagerEntity.id)
        ecsManagerEntity = nil
        log("Removed ecsManagerEntity")
    end

    -- (re-)spawn the uiManagerEntity
    if uiManagerEntity == nil then
        uiManagerParams = {}
        uiManagerParams.class = "UIManager"
        uiManagerParams.name = "UIManager_Instance"
        uiManagerEntity = System.SpawnEntity(uiManagerParams)
        log("Spawning UIManager")
    end

    -- (re-)spawn the ecsManagerEntity
    if ecsManagerEntity == nil then
        ecsManagerParams = {}
        ecsManagerParams.class = "ECSManager"
        ecsManagerParams.name = "ECSManager_Instance"
        ecsManagerEntity = System.SpawnEntity(ecsManagerParams)
        log("Spawning ECSManager")
    end


    -- setup the introduction-tutorial
    message = "<font color='#333333' size='28'>Architect " .. architect_version .. "</font>" .. "\n"
            .. "<font color='#333333' size='15'>See benjaminfoo.github.io/Architect/ \n</font>"
            .. "<font color='#333333' size='8'>\n</font>"
            .. "<font color='#333333' size='16'>Introduces base-building mechanics and other new features into KCD.</font>" .. "\n"
            .. "<font color='#333333' size='18'>\nKey Mousewheel up/down</font>" .. "\n"
            .. "<font color='#333333' size='16'>Choose construction</font>" .. "\n"

            .. "<font color='#333333' size='18'>\nKey V </font>" .. "\n"
            .. "<font color='#333333' size='16'>Create construction</font>" .. "\n"

            .. "<font color='#333333' size='18'>\nKey R </font>" .. "\n"
            .. "<font color='#333333' size='16'>Rotate new construction</font>" .. "\n"

            .. "<font color='#333333' size='18'>\nKey G </font>" .. "\n"
            .. "<font color='#333333' size='16'>Remove construction</font>" .. "\n"

            .. "<font color='#333333' size='18'>\nKey O </font>" .. "\n"
            .. "<font color='#333333' size='16'>Toggle deletion-lock of entity</font>" .. "\n"

            .. "<font color='#333333' size='18'>\nKey H </font>" .. "\n"
            .. "<font color='#333333' size='16'>Enable / disable modification</font>" .. "\n"

            .. "\n"
            .. "<font color='#333333' size='16'>Execute 'architect_help' in the ingame-console for additional help."
            .. "\nUse 'architect_intro' to show this message again.</font>" .. "\n"


    -- create the introduction tutorial and display it to the user for 20 seconds
    Game.ShowTutorial(message, 20, false, true)

end


-- this listener gets called after a scene has been loaded or a new game started
function architect_init:sceneInitListener(actionName, eventName, argTable)

    System.LogAlways("actionName: " .. actionName)
    System.LogAlways("eventName: " .. eventName)

    if argTable then
        -- System.LogAlways("argTable: " .. tostring(eventName))
    end

    if actionName == "sys_loadingimagescreen" and eventName == "OnEnd" then
        showUsage()
    end
end

-- UIAction.UnregisterActionListener(architect_init, "sceneInitListener")
UIAction.RegisterActionListener(architect_init, "", "", "sceneInitListener")

--[[
    UIAction.UnregisterEventSystemListener(architect_init, "userInterfaceEventSystemListener")
    UIAction.RegisterEventSystemListener(architect_init, "", "", "userInterfaceEventSystemListener")

    function architect_init:userInterfaceEventSystemListener(actionName, eventName, argTable)
        System.LogAlways("ui-event: actionName: " .. actionName)
        System.LogAlways("ui-event: eventName: " .. eventName)
        if argTable then System.LogAlways("ui-event: argTable: " .. tostring(eventName)) end
    end
]]

System.AddCCommand('architect_intro', 'showUsage()', "Shows the intro banner from startup")
