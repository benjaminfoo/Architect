---
--- Author:  Benjamin Foo
--- DateTime: 04.03.2020 23:09
---
--- UIController handles the drawing of the user-interface
---

res_current_model = "none"

function UIController_Init()
    System.LogAlways("Init ui-controller")
end

bUpdateActive = true

function UIController_OnUpdate()

    -- System.LogAlways("Drawing stuff with ui-controller")

    --[[

        Game.DebugDrawText(30, 295, 2, "Resources", 255, 255, 255, 1)
        Game.DebugDrawText(30, 320, 1.5, "Stone x" .. tostring(res_stone), 255, 255, 255, 1)
        Game.DebugDrawText(30, 340, 1.5, "Wood  x" .. tostring(res_wood), 255, 255, 255, 1)
        Game.DebugDrawText(30, 360, 1.5, "Water x" .. tostring(res_water), 255, 255, 255, 1)
        Game.DebugDrawText(30, 380, 1.5, "Food  x" .. tostring(res_food), 255, 255, 255, 1)
        Game.DebugDrawText(30, 425, 1.5, "Building (" .. tostring(bIndex) .. "/" .. tostring(#buildings) .. "): ".. tostring(res_current_model), 255, 255, 255, 1)

        currentBuilding = buildings[bIndex];
    ]]--


    -- PreviewController_Update()

end

System.LogAlways("Loaded ui-controller ...")
