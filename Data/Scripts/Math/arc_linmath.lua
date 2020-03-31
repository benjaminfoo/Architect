---
--- Author:  Benjamin Foo
---
--- The linmath class contains basic functions for linear algebra
---

-- unit vectors
i = { x = 1, y = 0, z = 0 }
j = { x = 0, y = 1, z = 0 }
k = { x = 0, y = 0, z = 1 }

--
quat_identity = { x = 0, y = 0, z = 0, w = 1 }


-- calculate the cross product of the vectors
-- https://rosettacode.org/wiki/Vector_products#Lua
function Vector_Cross(A, B)
    return { x = A.y * B.z - A.z * B.y,
             y = A.z * B.x - A.x * B.z,
             z = A.x * B.y - A.y * B.x }
end

-- calculate the dot product / scalar quantity
-- https://rosettacode.org/wiki/Vector_products#Lua
function Vector_Dot(A, B)
    return A.x * B.x + A.y * B.y + A.z * B.z
end

-- calculate the scalar triple product
function Vector_ScalarTriple(A, B, C)
    return Vector_Dot(A, Vector_Cross(B, C))
end

-- calculate the vector triple product
function Vector_VectorTriple(A, B, C)
    return Vector_Cross(A, Vector_Cross(B, C))
end

-- calculate the square product of the provided vector
function Vector_SqrMagnitude(newVec)
    return newVec.x * newVec.x + newVec.y * newVec.y + newVec.z * newVec.z
end

-- Get the position on the terrain from the provided vector
-- Example get player position in scene:
function Vector_CalculatePositionFromVector(newVec)

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
function Vector_CalculateNormalFromVector(vec)
    local rayStart = { x = vec.x, y = vec.y, z = vec.z + 50 }
    local rayDir = { x = 0, y = 0, z = -700 }
    local hitCount = Physics.RayWorldIntersection(rayStart, rayDir, 1, ent_terrain + ent_static, nil, nil, g_HitTable);
    if (hitCount > 0) then
        return g_HitTable[1].normal
    else
        return vec
    end
end


-- Inspired by:
-- - https://github.com/topameng/CsToLua/blob/master/tolua/Assets/Lua/Vector3.lua
-- - https://github.com/topameng/CsToLua/blob/master/tolua/Assets/Lua/Quaternion.lua
-- rotate the vector from fromVec to toVec
function Vector_SetFromToRotation(fromVec, toVec)

    local width = { x = 1, y = 0, z = 0 }
    local height = { x = 0, y = 1, z = 0 }
    local identity = { x = 0, y = 0, z = 0, w = 1 }

    local normalizedFrom = NormalizeVector(fromVec)
    local normalizedTo = NormalizeVector(toVec)
    local dotProduct = Vector_Dot(normalizedFrom, normalizedTo)

    if dotProduct > -1 + 1e-6 then
        local s = math.sqrt((1 + dotProduct) * 2)
        local inverse = 1 / s
        local crossP = Vector_Cross(normalizedFrom, normalizedTo)
        identity = { x = (crossP.x * inverse), y = (crossP.y * inverse), z = (crossP.z * inverse), w = (s * 0.5) }
    elseif dotProduct > 1 - 1e-6 then
        identity = { x = 0, y = 0, z = 0, w = 1 }
    else
        local axis = Vector_Cross(width, normalizedFrom)
        if Vector_SqrMagnitude(axis) < 1e-6 then
            axis = Vector_Cross(height, normalizedFrom)
        end
        identity = { x = axis.x, y = axis.y, z = axis.z, w = 0 }
    end

    return identity
end

--
function Quat_Align(newEntity, normal)
    local upZ = { x = 0, y = 0, z = 1 }
    local rotVec = Vector_SetFromToRotation(upZ, normal)
    newEntity:SetAngles({ rotVec.x * 2, rotVec.y * 2, 90 })
end

