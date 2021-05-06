local awful     = require("awful")
local beautiful = require("beautiful")
local dpi       = require("beautiful").xresources.apply_dpi
local gears     = require("gears")
local wibox     = require("wibox")

local helpers   = require("helpers")
local signals   = require("signals")

-- local lain      = require("lain")
-- local markup    = lain.util.markup
--local separators = lain.util.separators
--local sound     = lain.widget.alsa

local battery   = require("widgets/upower_battery")
--local weather   = require("widgets/weather")
--local brightness = require("widgets/brightness")
--local timer    = require("widgets/pomodoro")


local taglist_buttons = gears.table.join(
  awful.button({ }, 1, function(t) t:view_only() end),
  awful.button({ modkey }, 1, function(t)
      if client.focus then
        client.focus:move_to_tag(t)
      end
  end),
  awful.button({ }, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, function(t)
      if client.focus then
        client.focus:toggle_tag(t)
      end
  end),
  awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
  awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
  awful.button({ }, 1, function (c)
      if c == client.focus then
        c.minimized = true
      else
        -- Without this, the following
        -- :isvisible() makes no sense
        c.minimized = false
        if not c:isvisible() and c.first_tag then
          c.first_tag:view_only()
        end
        -- This will also un-minimize
        -- the client, if needed
        client.focus = c
        c:raise()
      end
  end),
  awful.button({ }, 3, helpers.client_menu_toggle()),
  awful.button({ }, 4, function ()
      awful.client.focus.byidx(1)
  end),
  awful.button({ }, 5, function ()
      awful.client.focus.byidx(-1)
end))

awful.screen.connect_for_each_screen(function(s)
    --tags = {
    --    names = { " ", " ", " ", "龎 ", " ", "  ", " ", " " }
    --}
    ---- Each screen has its own tag table.
    --for s = 1, screen.count() do
    --    tags[s] = awful.tag(tags.names, s, awful.layout.layouts)
    --end

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                            awful.button({ }, 1, function () awful.layout.inc( 1) end),
                            awful.button({ }, 3, function () awful.layout.inc(-1) end),
                            awful.button({ }, 4, function () awful.layout.inc( 1) end),
                            awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist_buttons, { font = beautiful.font_notif .. " 11" })

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
      screen = s,
      filter = awful.widget.tasklist.filter.currenttags,
      buttons = tasklist_buttons,
      style = {
        font = beautiful.font_notif .. " 10",
        align = "center",
      },
      widget_template = {
        {
          {
            id     = 'clienticon',
            widget = awful.widget.clienticon,
          },
          margins = 3,
          widget  = wibox.container.margin
        },
        {
          {
            id     = 'text_role',
            widget = wibox.widget.textbox,
          },
          widget  = wibox.container.background,
        },
        nil,
        create_callback = function(self, c, index, objects)
          self:get_children_by_id('clienticon')[1].client = c
        end,
        widget  = wibox.layout.align.horizontal,
      },
    }

    -- Create a textclock widget
    mytextclock = wibox.widget.textclock("%a %d %b %H:%M") -- %a %Y-%m-%d %H:%M %Z


    local interval = 15

    -- Net
    -- local netdowninfo = wibox.widget.textbox()
    -- local netdowninfo = lain.widget.net {
    --    -- iface = "wlp2s0",
    --    units = 1024,
    --    notify = off,
    --    settings = function()
    --      widget:set_markup(markup.fontfg(beautiful.font_notif .. " 9", beautiful.fg_normal, "" .. net_now.received))
    --      --netdowninfo:set_markup(markup.fontfg(beautiful.font, "#87af5f", net_now.received .. " "))
    --    end
    -- }

    -- local mem = lain.widget.mem {
    --   timeout = 7,
    --   settings = function()
    --     local mem = string.format("%.2f", mem_now.used / 1024)
    --     widget:set_markup("" ..mem.. "GB")
    --   end
    -- }

    -- Battery
    bat = battery()
   
    -- local temp = lain.widget.temp({
    --     settings = function ()
    --       widget:set_markup(markup.font(beautiful.font, "" .. coretemp_now .. "° "))
    --     end
    -- })

    -- ALSA volume
    --local volicon = wibox.widget.textbox()
    --beautiful.volume = lain.widget.alsabar({
    --    --togglechannel = "IEC958,3",
    --    notification_preset = { font = "Monospace 12", fg = beautiful.fg_normal },
    --    settings = function()
    --      local index, perc = "", tonumber(volume_now.level) or 0

    --      if volume_now.status == "off" then
    --        index = "volmutedblocked"
    --      else
    --        if perc <= 5 then
    --          --index = "volmuted"
    --          volicon:set_markup(markup.fontfg(beautiful.font_icon, "#aaaaaa", "奄"))
    --        elseif perc <= 25 then
    --          --index = "vollow"
    --          volicon:set_markup(markup.fontfg(beautiful.font_icon, "#aaaaaa", "墳"))
    --        elseif perc <= 75 then
    --          --index = "volmed"
    --          volicon:set_markup(markup.fontfg(beautiful.font_icon, "#aaaaaa", "墳"))
    --        else
    --          --index = "volhigh"
    --          volicon:set_markup(markup.fontfg(beautiful.font_icon, "#aaaaaa", "奄ﱛ"))
    --        end
    --      end

    --      --volicon:set_markup(markup.fontfg(beautiful.font_icon, "#aaaaaa", "墳"))
    --    end
    --})
    --volicon:buttons(my_table.join (
    --          awful.button({}, 1, function()
    --            awful.spawn(string.format("%s -e alsamixer", awful.util.terminal))
    --          end),
    --          awful.button({}, 2, function()
    --            os.execute(string.format("%s set %s 100%%", beautiful.volume.cmd, beautiful.volume.channel))
    --            beautiful.volume.notify()
    --          end),
    --          awful.button({}, 3, function()
    --            os.execute(string.format("%s set %s toggle", beautiful.volume.cmd, beautiful.volume.togglechannel or beautiful.volume.channel))
    --            beautiful.volume.notify()
    --          end),
    --          awful.button({}, 4, function()
    --            os.execute(string.format("%s set %s 1%%+", beautiful.volume.cmd, beautiful.volume.channel))
    --            beautiful.volume.notify()
    --          end),
    --          awful.button({}, 5, function()
    --            os.execute(string.format("%s set %s 1%%-", beautiful.volume.cmd, beautiful.volume.channel))
    --            beautiful.volume.notify()
    --          end)
    --))

    -- local myredshift = wibox.widget{
    --   checked      = false,
    --   check_color  = "#EB8F8F",
    --   border_color = "#EB8F8F",
    --   border_width = 1,
    --   shape        = gears.shape.square,
    --   widget       = wibox.widget.checkbox
    -- }
    -- local myredshift_text = wibox.widget{
    --   align  = "center",
    --   widget = wibox.widget.textbox,
    -- }
    -- local myredshift_stack = wibox.widget{
    --   myredshift,
    --   myredshift_text,
    --   layout = wibox.layout.stack
    -- }
    -- lain.widget.contrib.redshift:attach(
    --   myredshift,
    --   function (active)
    --     if active then
    --       myredshift_text:set_markup(markup(beautiful.bg_normal, "<b>R</b>"))
    --     else
    --       myredshift_text:set_markup(markup(beautiful.fg_normal, "R"))
    --     end
    --     myredshift.checked = active
    --   end
    -- )

    --weather_lain = lain.widget.weather({
    --city_id = 953781,
    --notification_preset = { font = beautiful.font_notif, fg = beautiful.fg_normal },
    --weather_na_markup = markup.fontfg(beautiful.font .. " 9", "#eca4c4", "N/A"),
    --settings = function()
    --  descr = weather_now["weather"][1]["description"]:lower()
    --  units = math.floor(weather_now["main"]["temp"])
    --  widget:set_markup(markup.fontfg(beautiful.font_notif .. " 9", beautiful.xforeground, descr .. "|".. units .. "°C"))
    --end
    --})

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
      layout = wibox.layout.align.horizontal,
      { -- Left widgets
        layout = wibox.layout.fixed.horizontal,
        --{ -- Make mylauncher image margin smaller
        --  widget = wibox.container.margin,
        --  margins=5,
        --  mylauncher
        --},
        --wibox.widget.textbox('┊ '),
        s.mytaglist,
        s.mypromptbox,
      },
      s.mytasklist, -- Middle widget

        { -- Right widgets
          layout = wibox.layout.fixed.horizontal,
          -- {
          --   widget = wibox.container.margin,
          --   margins=4,
          --   netdowninfo,
          -- },
          --separators.arrow_left(beautiful.bg_focus, "#ffffff"),
          --separators.arrow_left("#ffffff", beautiful.bg_focus),
          {widget=wibox.container.margin,margins=4,mem},
          -- wibox.widget.textbox('  '),
          -- temp,
          bat,
          -- {
          --   widget=wibox.container.margin,
          --   margins=3,
          --   temp
          -- },
          -- {
          --   widget=wibox.container.margin,
          --   bat
          -- },
          --{widget=wibox.container.margin,margins=0,weather_lain},
          --volicon,
          --{widget=wibox.container.margin,margins=3,myredshift},
          {
            widget=wibox.container.margin,
            margins=4,
            wibox.widget.systray(),
          },
          mytextclock,
          --brightness
          --{widget=wibox.container.margin,margins=0,brightness},
          --timer,
          {
            widget = wibox.container.margin,
            margins=4,
            s.mylayoutbox
          },
        }
    }
end)
