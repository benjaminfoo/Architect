---
--- Created by Benjamin Foo
--- DateTime: 04.03.2020 23:09
---
--- The ResourcesControler defines basic and advanced resource operations.
---

resources = {
    wood = 0,
    stone = 0,

    food = 0,
    water = 0,

    money = 0,

    -- Other items:
    --  - plants
    --  - potions
    --  - weapons?
    --  - ...
}


-- TODO: remove in game
LogAlways = print


--
function modifyResourceByAmount(resourceKind, amount)
    if (resourceExist(resourceKind)) then
        resources[resourceKind] = resources[resourceKind] + amount
    end
end


-- checks if the given kind of resource exists within the set of resources
function resourceExist(resourceKind)
    result = false
    if resources[resourceKind] ~= nil then
        result = true
    else
        LogAlways("Warning: \'" .. resourceKind .. "\' not available in resources ...")
    end
    return result
end


-- Lists all resources and their values to the console
function showRes()
    LogAlways("")
    LogAlways("== Resources == ")
    LogAlways("Wood\t" .. " " .. resources.wood)
    LogAlways("Stone\t" .. " " .. resources.stone)
    LogAlways("Food\t" .. " " .. resources.food)
    LogAlways("Water\t" .. " " .. resources.water)
    LogAlways("Money\t" .. " " .. resources.money)
end


-- TODO: some simple tests
--[[
modifyResourceByAmount("wood", 33)
modifyResourceByAmount("stone", 18)
modifyResourceByAmount("food", 5)
modifyResourceByAmount("water", 40)
modifyResourceByAmount("money", -20)
modifyResourceByAmount("honey :3", -20)

-- show the resources
showRes()

]]
