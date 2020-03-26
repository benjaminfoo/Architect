---
--- Created by Benjamin Foo
--- DateTime: 04.03.2020 23:09
---
--- UIController handles the drawing of the user-interface
---

res_current_model = "none"

function UIController_Init()
    System.LogAlways("Init ui-controller")
end

bUpdateActive = true

currentSpeed = 0
maxSpeed = 5
minSpeed = 0.1

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


    rayCastHitOnUpdate()

    if bUpdateActive then

        --[[
        p = player:GetPos()

        c = System.GetViewCameraDir()

        local from = player:GetPos();
        from.z = from.z + 1.615;

        local hitDownToBottom = {};
        local hitsDownToBottom = Physics.RayWorldIntersection(from, {x=0,y=0,z=-5}, 10, ent_all, player.id, nil, hitDownToBottom);


        local frontData = {};
        camView = vecScale(System.GetViewCameraDir(),10)
        newCamView = {
            camView.x,
            camView.y,
            camView.z
        }
        local frontHits = Physics.RayWorldIntersection(from, newCamView, 10, ent_all, player.id, previewModelEntity.id, frontData);


        if(frontHits <= 0) then
            return
        end



        up = {
            p.x + c.x * 0.2,
            p.y + c.y * 0.2,
            -- p.z + c.z * 0
            hitDownToBottom[1].pos.z
        }

        player:SetPos(up)

        previewModelEntity:SetPos(hitData[1].pos)
        local up = player:GetAngles()
        up = { up.x, up.y, up.z }
        previewModelEntity:SetAngles(up)
        System.LogAlways("HA")
        ]]


    end

end

System.LogAlways("Loaded ui-controller ...")
