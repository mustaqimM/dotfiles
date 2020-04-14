local awful = require("awful")
local beautiful = require("beautiful")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() return false, hotkeys_popup.show_help end},
   { "manual", terminal .. " -e man awesome", beautiful.manual_icon },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end}
}

mymainmenu = awful.menu({ items =
                            { { "awesome", myawesomemenu, beautiful.awesome_icon },
                              { "open terminal", terminal},
                              { "file manager", "dolphin" }
                            }
})

mylauncher = awful.widget.launcher({ image = beautiful.launcher_icon,
                                     menu = mymainmenu })
-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}
