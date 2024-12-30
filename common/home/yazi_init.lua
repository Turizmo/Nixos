function Linemode:mtimev2()
    local current_year = os.date("%Y") -- Get the current year as a string
    local time = math.floor(self._file.cha.modified or 0)
    if time > 0 then
        local file_year = os.date("%Y", time) -- Get the file's year
        local time_format
        if file_year == current_year then
            time_format = os.date("%d/%b %H:%M", time) -- Without year
        else
            time_format = os.date("%d/%b/%Y %H:%M", time) -- With year
        end
        return ui.Line(string.format(time_format))
    end
    return ui.Line("") -- Return empty if no time exists
end

function Linemode:ctimev2()
    local current_year = os.date("%Y") -- Get the current year as a string
    local time = math.floor(self._file.cha.created or 0)
    if time > 0 then
        local file_year = os.date("%Y", time) -- Get the file's year
        local time_format
        if file_year == current_year then
            time_format = os.date("%d/%b %H:%M", time) -- Without year
        else
            time_format = os.date("%d/%b/%Y %H:%M", time) -- With year
        end
        return ui.Line(string.format(time_format))
    end
    return ui.Line("") -- Return empty if no time exists
end
