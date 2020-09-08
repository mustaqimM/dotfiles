local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local helpers  = require("helpers")

local signals = {}
-- {{{ Signals

-- Signal function to execute when a new client appears.
client.connect_signal(
   "manage",
   function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end
      if awesome.startup and
         not c.size_hints.user_position
      and not c.size_hints.program_position then
         -- Prevent clients from being unreachable after screen count changes.
         awful.placement.no_offscreen(c)
      end
   end
)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            client.focus = c
            c:raise()
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            client.focus = c
            c:raise()
            awful.mouse.client.resize(c)
        end)
    )

    -- TODO: Put multiple widgets into a single margin container
    awful.titlebar(c, {size=24}) : setup {
        { -- Left
            { widget = wibox.container.margin,
              margins=5,
              awful.titlebar.widget.closebutton(c)
            },
            { widget = wibox.container.margin,
              margins=5,
              awful.titlebar.widget.maximizedbutton(c)
            },
            { widget = wibox.container.margin,
              margins=5,
              awful.titlebar.widget.minimizebutton(c)
            },
            layout = wibox.layout.fixed.horizontal()
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
        --    { widget = wibox.container.margin,
        --      margins=4,
        --      awful.titlebar.widget.floatingbutton(c)
        --    },
        --    { widget = wibox.container.margin,
        --      margins=4,
        --      awful.titlebar.widget.stickybutton(c)
        --    },
        --    { widget = wibox.container.margin,
        --      margins=4,
        --      awful.titlebar.widget.ontopbutton(c)
        --    },
            { widget = wibox.container.margin,
              margins=4,
              awful.titlebar.widget.iconwidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
        and awful.client.focus.filter(c) then
        client.focus = c
    end
end)

--function relativeMove(c, x, y)
--    local g = c:geometry()
--    g.x = g.x + x
--    g.y = g.y + y
--    c:geometry(g)
--end

-- Set/Change tasklist application icons
client.connect_signal("manage",
    function(c)
        local t = {}
        t["Alacritty"]   = "/usr/share/pixmaps/Alacritty.svg"
        t["Code - OSS"]  = "/usr/share/icons/Papirus-Dark/64x64/apps/vscodium.svg"
        t["Franz"]       = "/usr/share/icons/Papirus-Dark/64x64/apps/franz.svg"
        t["Fractal"]     = "/usr/share/icons/hicolor/scalable/apps/org.gnome.Fractal.svg"
        -- t["Firefox"]     = "/home/mustaqim/.mozilla/firefox/chrome/firefox.png"
        t["JDownloader"] = "/usr/share/icons/Papirus-Dark/64x64/apps/jdownloader.svg"
        t["Keybase"]     = "/usr/share/icons/Papirus-Dark/64x64/apps/keybase.svg"
        t["KeePassXC"]   = "/usr/share/icons/Papirus-Dark/64x64/apps/keepassxc.svg"
        t["Nightly"]     = "/usr/share/icons/Papirus-Dark/64x64/apps/org.mozilla.FirefoxNightly.svg"
        t["Next"]        = "/usr/share/icons/hicolor/128x128/apps/next.png"
        t["st"]          = "/usr/share/icons/Papirus-Dark/64x64/apps/st.svg"
        t["URxvt"]       = "/usr/share/icons/Papirus-Dark/64x64/apps/urxvt.svg"
        t["UXTerm"]      = "/usr/share/icons/Papirus-Dark/64x64/apps/utilities-terminal.svg"

        local icon = t[c.class]
        if not icon then
            return
        end
        icon = gears.surface(icon)
        c.icon = icon and icon._native or nil
    end
)

function set_wallpaper(s)
    --local instance = nil
    --return function()
        -- Wallpaper
        if beautiful.wallpaper then
            local wallpaper = beautiful.wallpaper
            -- If wallpaper is a function, call it with the screen
            if type(wallpaper) == "function" then
                wallpaper = wallpaper(s)
            end
            gears.wallpaper.maximized(wallpaper, s, true)
        end
    --end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen( function(s)
        set_wallpaper(s)

        -- if awful.screen.focused().tags == nil then
        --     s.mywibox = awful.wibar({ position = "bottom", screen = s })
        -- end

        -- Rounded corners
        screen[s]:connect_signal
        ('arrange',
         function(s)
             for _, c in pairs(s.clients) do
                 if beautiful.border_radius ~= 0 and
                     (s.selected_tag.layout.name == 'max' or c.fullscreen)
                 --and (#s.tiled_clients == 1)
                 then
                     c.shape = helpers.rect()
                 else
                     if c.type == ("floating" or "skip_taskbar" or "modal") or
                         s.selected_tag.layout.name == 'floating'
                     then
                         c.shape = helpers.rrect(beautiful.border_radius) end
                 end
             end
        end)
end)


-- Disconnect the default handler for resize requests
--client.disconnect_signal("request::geometry", awful.ewmh.client_geometry_requests)
---- Connect our own handler
--client.connect_signal("request::geometry", function(c, context, hints)
--    if c.instance ~= "mpvstream" then
--        c.width = 500
--        c.height = 300
--    end
--    awful.ewmh.client_geometry_requests(c, context, hints)
--end)

--client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
--client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

return signals

-- }}}
