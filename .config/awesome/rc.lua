-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")

-- Theme handling library
local beautiful   = require("beautiful")
local config_path = awful.util.getdir("config") .. "/"
local theme_dir   = config_path .. "/themes/"
local theme_collection = {
    "mojave-dark",    -- 1 --
    "mojave-light"    -- 2 --
}
local theme_name = theme_collection[1]

-- {{{ Error handling }}}
--dofile(config_path .. "error.lua")
require("error")

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init( theme_dir .. theme_name .. "/theme.lua" )
terminal = "xst -c st -T Terminal -e zsh"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor
awful.util.terminal = terminal
-- }}}

-- {{{ Custom Local Library
--local layouts  = require("layouts")       -- Workspace Layouts
local helpers  = require("helpers")       -- Helper functions
local menu     = require("menu")          -- Context menu
local wibar    = require("wibar")         -- Top bar
local rules    = require("rules")         -- Window rules
local bindings = require("bindings")      -- Key/Mouse bindings
local signals  = require("signals")
--require("daemons")
require("notifications")
require("widgets/popup")
-- }}}

-- Autorun applications
awful.spawn.with_shell( os.getenv("HOME") .. "/.config/awesome/autorun" )
