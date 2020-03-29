---
--- Created by Benjamin Foo
--- DateTime: 04.03.2020 23:09
---
--- The ResourcesControler defines basic and advanced resource operations.
---

-- Every resource should have a use!

-- Wood = can be used for building or crafting
-- Stone = -||-

-- What to do with coal?
-- What to do with linen?
resources = {

    -- basic resources
    wood = 0,
    stone = 0,

    -- basic needs
    food = 0,
    water = 0,

    -- the money of the user, this should be bind to the actuals player value
    groschen = 0,

    -- this can be used for baking bread or other food in kingdom come deliverance
    wheat = 0,

    coal = 0,

    cords = 0,
    linen = 0,

    -- new items
    honey = 0,

    silver = 0,


    -- Other items:
    --  - plants
    --  - potions
    --  - weapons?
    --  - ...
}


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
        System.LogAlways("Warning: \'" .. resourceKind .. "\' not available in resources ...")
    end
    return result
end


-- Lists all resources and their values to the console
function showStats()

    System.LogAlways("")
    System.LogAlways("== Statistics for " .. config.primary_town_name .. " ==")
    System.LogAlways("")

    -- position, if set
    pos = config.primary_town_position
    if (pos == nil and pos.x == nil) then
        System.LogAlways("No valid home / town set, use #setHome(), then show stats again")
    else
        System.LogAlways("Located at: " .. ("x: " .. pos.x .. " | y: " .. pos.y .. " | z: " .. pos.z))
    end

    -- owner settings
    owner = player

    System.LogAlways("")
    System.LogAlways("Owner: " .. owner:GetName())
    System.LogAlways("Money of owner: " .. player.inventory:GetMoney())

    System.LogAlways("")
    System.LogAlways("== Resources == ")
    for key, value in pairs(resources) do
        System.LogAlways("- " .. tostring(key) .. ": " .. tostring(value))
    end

    System.LogAlways("")
    System.LogAlways("== NPCs == ")
    System.LogAlways(".. not implemented yet")

    System.LogAlways("")
    System.LogAlways("== Built constructions == ")
    showAll()

    local generatorEntities = System.GetEntitiesByClass("GeneratorEntity")
    System.LogAlways("")
    System.LogAlways("== Built Generator-Constructions (" .. #generatorEntities .. ") == ")

    System.LogAlways("")
    for index, entity in pairs(generatorEntities) do
        ePos = entity:GetPos()
        System.LogAlways(
                index .. ".) " .. entity:GetName() .. " @ "
                        .. "x: " .. ePos.x .. " | "
                        .. "y: " .. ePos.y .. " | "
                        .. "z: " .. ePos.z
        )

        if entity.Properties.generatorItem ~= nil then
            System.LogAlways(
                    "Produces " .. entity.Properties.generatorItem
                            .. " x" .. entity.Properties.generatorItemAmount
                            .. " every " .. entity.Properties.generatorCooldown .. " seconds "
            )

            System.LogAlways("Produced already: " .. entity.Properties.generatorGeneratedAmount .. "x " .. entity.Properties.generatorItem)
        end

        System.LogAlways("")

    end

end

---
--- possible resources and recipes
---

-- wood
-- stone

---
--- refined resources
---

-- wooden log
-- arrow head

