local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")

local url  = "https://api.darksky.net/forecast/"
local api  = "f65c650b61b69a2d31c0362020fe6b94"
lat = os.getenv("LOCATION_LAT")
lon = os.getenv("LOCATION_LON")
local loc  = { lat = "-26.3919", lon = "27.8531" }
local unit = "si"

local weather_icon = wibox.widget {
    font = beautiful.font_awe .. " 11",
    text = "",
    valign = 'center',
    widget = wibox.widget.textbox
}

local weather_desc = wibox.widget {
    font = beautiful.font_notif .. " 9",
    text = " ",
    valign = 'center',
    widget = wibox.widget.textbox
}

local weather_temp = wibox.widget {
    font = beautiful.font_notif .. " 8",
    text = " ",
    valign = 'center',
    widget = wibox.widget.textbox
}

local weather = wibox.widget {
    weather_icon,
    weather_desc,
    weather_temp,
    layout = wibox.layout.fixed.horizontal
}

local get_weather = [[ bash -c '
    URL="]]..url..[["
    API="]]..api..[["
    LAT="]]..loc["lat"]..[["
    LON="]]..loc["lon"]..[["
    UNIT="]]..unit..[["

    weather=$(curl -sf "$URL$API/$LAT,$LON?$UNIT")

    if [ ! -z "$weather" ]; then
        weather_icon=$(echo $weather | jq '.currently.icon')
        weather_summary=$(echo $weather | jq '.currently.summary')
        weather_temp=$(echo $weather | jq '.currently.temperature')

        echo "$weather_icon"
        echo "$weather_summary"
        echo "$weather_temp"
    fi
']]

local function update_weather(icon, summary, temp)
    if string.find(icon, "clear%-day") then
        weather_icon.markup = " "
    elseif string.find(icon, "clear%-night") then
        weather_icon.markup = " "
    elseif string.find(icon, "rain") then
        weather_icon.markup = " "
    elseif string.find(icon, "snow") then
        weather_icon.markup = "  "
    elseif string.find(icon, "sleet") then
        weather_icon.markup = "  "
    elseif string.find(icon, "wind") then
        weather_icon.markup = "  "
    elseif string.find(icon, "fog") then
        weather_icon.markup = "  "
    elseif string.find(icon, "partly%-cloudy%-day") then
        weather_icon.markup = "  "
    elseif string.find(icon, "partly%-cloudy%-night") then
        weather_icon.markup = " "
    elseif string.find(icon, "hail") then
        weather_icon.markup = "  "
    elseif string.find(icon, "thunderstorm") then
        weather_icon.markup = "  "
    elseif string.find(icon, "tornado") then
        weather_icon.markup = " "
    elseif string.find(icon, "cloudy") then
        weather_icon.markup = ""
    else
        weather_icon.markup = " "
    end

    summary = string.lower(summary)
    weather_desc.markup = " " ..summary.. "|"
    weather_temp.markup = temp .. '<span></span>'

end

awful.widget.watch(get_weather, 2700,
    function(widget, stdout)
        wd = {}
        for line in stdout:gmatch("[^\n]+") do
            line = string.gsub(line, "\"", "")
            wd[#wd +1] = line
        end

        local w_icon = wd[1]
        local w_summary = wd[2]
        local w_temp = math.floor(wd[3])

        update_weather(w_icon, w_summary, w_temp)
end)

return weather

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
