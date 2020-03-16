-- Calendar.GetWorldHourOfDay
-- Returns hour of current day. Range is <0,24) The number is float.

-- Calendar.GetGameTime()
-- Returns game time (whole seconds from start of level)


function getTime()
    local gameTimeInSeconds = Calendar.GetWorldTime()
    local days = math.floor(gameTimeInSeconds / TIME_DAY_DURATION)
    local hours = (gameTimeInSeconds / TIME_HOURS * TIME_HOURS) % TIME_HOURS -- = 60 * 60 = 3600
    local minutes = (gameTimeInSeconds / TIME_SECONDS) % TIME_MINUTES
    local seconds = gameTimeInSeconds % TIME_SECONDS
    local time = string.format("days=%.3d time=%.2d:%.2d:%.2d speed=%d paused=%s",
            days, hours, minutes, seconds, Calendar.GetWorldTimeRatio(), tostring(Calendar.IsWorldTimePaused()))
    log(time)
end
