-- Calendar.GetWorldHourOfDay
-- Returns hour of current day. Range is <0,24) The number is float.

-- Calendar.GetGameTime()
-- Returns game time (whole seconds from start of level)

function GetCurrentTime()
    local CURRENT_GAMETIME_IN_SECONDS = Calendar.GetWorldTime()
    local CURRENT_DAYS = math.floor(CURRENT_GAMETIME_IN_SECONDS / TIME_DAY_DURATION)
    local CURRENT_HOURS = (CURRENT_GAMETIME_IN_SECONDS / TIME_HOURS * TIME_HOURS) % TIME_HOURS -- = 60 * 60 = 3600
    local CURRENT_MINUTES = (CURRENT_GAMETIME_IN_SECONDS / TIME_SECONDS) % TIME_MINUTES
    local CURRENT_SECONDS = CURRENT_GAMETIME_IN_SECONDS % TIME_SECONDS
    log(string.format("Day 2d - %.2d:%.2d", CURRENT_DAYS, CURRENT_HOURS, CURRENT_MINUTES, CURRENT_SECONDS))
end
