-- warps the player to the raycasts hit
---- massive cheat, not included by default - but its fun :)
function warpTo(newPos)
    System.LogAlways("# warpTo start")

    local origin = player:GetPos();
    origin.z = origin.z + 1.615;

    local direction = System.GetViewCameraDir();
    direction = vecScale(direction, 250);

    local skip = player.id;

    local hitData = {};
    local hitCount = Physics.RayWorldIntersection(origin, direction, 10, ent_all, skip, nil, hitData);

    --[[
        System.LogAlways("hits=" .. tostring(hits))
        System.LogAlways("found ent=" .. tostring(hitData[1].pos.x))
        System.LogAlways("found ent=" .. tostring(hitData[1].pos.y))
        System.LogAlways("found ent=" .. tostring(hitData[1].pos.z))
    ]]

    if hitCount > 0 then
        local entity = hitData[1]
        player:SetWorldPos(entity.pos)
    end

    System.LogAlways("# warpTo end")
end
