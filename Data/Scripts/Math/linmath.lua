---
--- Created by Benjamin Foo
--- DateTime: 04.03.2020 23:09
---
--- The linmath class contains basic functions for linear algebra
---


-- calculate the cross product of the vector
-- https://rosettacode.org/wiki/Vector_products#Lua
function Cross(A, B)
    return { x = A.y * B.z - A.z * B.y,
             y = A.z * B.x - A.x * B.z,
             z = A.x * B.y - A.y * B.x }
end

-- calculate the dot product / scalar quantity
-- https://rosettacode.org/wiki/Vector_products#Lua
function Dot(A, B)
    return A.x * B.x + A.y * B.y + A.z * B.z
end

-- calculate the scalar triple product
function ScalarTriple(A, B, C)
    return Dot(A, Cross(B, C))
end

-- calculate the vector triple product
function VectorTriple(A, B, C)
    return Cross(A, Cross(B, C))
end

-- calculate the square product of the provided vector
function SqrMagnitude(newVec)
    return newVec.x * newVec.x + newVec.y * newVec.y + newVec.z * newVec.z
end

-- Get the position on the terrain from the provided vector
-- Example get player position in scene:
---- System.LogAlways(tostring(GetTerrainPosFromVec(player:GetWorldPos())))
function CalculatePositionFromVector(newVec)
    -- System.LogAlways("CalculatePositionFromVector()")

    -- setup raycast conditions - start & end vector of the ray intersection
    local rayStart = { x = newVec.x, y = newVec.y, z = newVec.z + 50 }
    local rayDir = { x = 0, y = 0, z = -700 }

    if ent_terrain == nil then
        ent_terrain = 256
    end

    if ent_static == nil then
        ent_static = 1
    end

    -- execute raycasting
    local hitCount = Physics.RayWorldIntersection(rayStart, rayDir, 1, ent_terrain + ent_static, nil, nil, g_HitTable);
    if (hitCount > 0) then
        return g_HitTable[1].pos
    else
        return newVec
    end

end

-- Get the normal on the terrain from the provided vector
-- TODO: refactor into common method for raycasting
function CalculateNormalFromVector(vec)
    local rayStart = { x = vec.x, y = vec.y, z = vec.z + 50 }
    local rayDir = { x = 0, y = 0, z = -700 }
    local hitCount = Physics.RayWorldIntersection(rayStart, rayDir, 1, ent_terrain + ent_static, nil, nil, g_HitTable);
    if (hitCount > 0) then
        return g_HitTable[1].normal
    else
        return vec
    end
end

-- https://github.com/topameng/CsToLua/blob/master/tolua/Assets/Lua/Quaternion.lua
function SetFromToRotation(fromVec, toVec)

    local v3_right = { x = 1, y = 0, z = 0 }
    local v3_forward = { x = 0, y = 1, z = 0 }
    local identity = { x = 0, y = 0, z = 0, w = 1 }

    local v0 = NormalizeVector(fromVec)
    local v1 = NormalizeVector(toVec)
    local d = Dot(v0, v1)

    if d > -1 + 1e-6 then
        local s = math.sqrt((1 + d) * 2)
        local invs = 1 / s
        local c = Cross(v0, v1)
        identity = { x = (c.x * invs), y = (c.y * invs), z = (c.z * invs), w = (s * 0.5) }
    elseif d > 1 - 1e-6 then
        identity = { x = 0, y = 0, z = 0, w = 1 }
    else
        local axis = Cross(v3_right, v0)
        if SqrMagnitude(axis) < 1e-6 then
            axis = Cross(v3_forward, v0)
        end
        identity = { x = axis.x, y = axis.y, z = axis.z, w = 0 }
    end

    return identity
end

function AlignEntityToSurface(newEntity, normal)
    local up = { x = 0, y = 0, z = 1 }
    local rotVec = SetFromToRotation(up, normal)
    --ent:SetAngles({x*2,y*2,z*2})
    newEntity:SetAngles({ rotVec.x * 2, rotVec.y * 2, 90 })
end

