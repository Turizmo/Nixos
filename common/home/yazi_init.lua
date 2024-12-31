function Linemode:mtimev2()
    local time = math.floor(self._file.cha.modified or 0)
    if time > 0 then
        local time_format
        time_format = os.date("%Y-%m-%d %H:%M", time) -- With year
        return ui.Line(string.format(time_format))
    end
    return ui.Line("") -- Return empty if no time exists
end

function Linemode:ctimev2()
    local time = math.floor(self._file.cha.created or 0)
    if time > 0 then
        local time_format
        time_format = os.date("%Y-%m-%d %H:%M", time) -- With year
        return ui.Line(string.format(time_format))
    end
    return ui.Line("") -- Return empty if no time exists
end
