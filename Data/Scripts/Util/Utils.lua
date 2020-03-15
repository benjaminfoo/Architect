---
--- Utility functions for logging
--- Created by Benjamin Foo
--- DateTime: 03.03.2020 01:01
---

-- setup seed for using random rng of lua
current = System.GetCurrTime()
math.randomseed(current)
random = math.random

-- generate a unique ID by using the rng of lua
function uuid()
    local template = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
    return string.gsub(template, '[xy]', function(c)
        v = (c == 'x') and random(0, 15) or random(8, 11)
        return string.format('%x', v)
    end)
end

function print_all_functions(object)
    if not object then
        object = _G
    end

    for key, value in pairs(object) do
        local getKeyType = loadstring("return type(" .. key .. ")")
        if getKeyType() == "function" then
            System.LogAlways("BEGIN FUNC:" .. key)
            local func = loadstring("print_method_args(" .. key .. ")")
            func()
        end
    end
end

function isBlank(value)
    return value == nil or value == ''
end

function toUpper(value)
    if not isBlank(value) then
        -- string.upper fails if passed nil
        return string.upper(value)
    else
        return value
    end
end

function print_methods(object, filter)
    for key, value in pairs(object) do
        if not isBlank(filter) then
            if string.find(toUpper(key), toUpper(filter), 1, true) then
                System.LogAlways(key .. " | " .. value)
            end
        else
            System.LogAlways(key)
        end
    end
end
