local awful     = require("awful")
local beautiful = require("beautiful")
local gears     = require("gears")
local wibox     = require("wibox")
local dpi       = beautiful.xresources.apply_dpi

local helpers   = require("helpers")


local vb_slider = awful.popup {
	widget =
		{
			max_value        = 100,
			value            = 33,
			forced_height    = 15,
			forced_width     = 100,
			--border_width     = 0,
			border_color     = beautiful.border_color .. " 00",
			background_color = beautiful.xcolor8,
			color            = beautiful.xcolor4,
			bar_shape        = helpers.rrect(beautiful.border_radius),
			widget           = wibox.widget.progressbar,
		},
	visible   = false,
	ontop     = true,
	shape     = helpers.rrect(beautiful.border_radius),
	placement = awful.placement.centered,
}

local timer = gears.timer({
		timeout = 1.2,
		callback = function()
			vb_slider.visible = false
		end
})

local _trigger_wibox = function(slider)
	if slider == 'volume'
	then
		vb_slider.widget.color = beautiful.xcolor4
	elseif slider == 'brightness' then
		vb_slider.widget.color = beautiful.xcolor10
	end
	vb_slider.visible = true
	timer:again()
end


awesome.connect_signal("volume::change", function()
	awful.spawn.easy_async("amixer sget Master | grep %", function(o)
		-- Sample output
		-- Mono: Playback 63 [50%] [-32.00dB] [on]
		lv, stat = string.match(o, ".*%[(%d%d?%d?)%%%].*%[(%a*)].*")
		if stat == "on" then
			vb_slider.widget.value = tonumber(lv)
		end
		_trigger_wibox('volume')
	end)
end)

awesome.connect_signal("brightness:change", function()
	awful.spawn.easy_async("light -G", function(o)
		-- Sample output: 43.33
		o = string.match(o, "(%d%d?%d?).*")
		_trigger_wibox('brightness')
		vb_slider.widget.value = tonumber(o)
	end)
end)
