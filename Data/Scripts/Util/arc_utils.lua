---
--- Author:  Benjamin Foo
---
--- Description
--- Utility functions

-- Time related constants

-- The seconds per minute
TIME_SECONDS = 60

-- The minutes per hour
TIME_MINUTES = 60

-- The hours per day
TIME_HOURS = 24

-- The days per week
TIME_DAYS_PER_WEEK = 7

-- The days per year
TIME_DAYS_PER_YEAR = 365

-- = 60 * 60 * 24 = 86400
TIME_DAY_DURATION = 86400


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

-- checks if a table tab contains a value val
function contains (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end
