local awful     = require("awful")
local beautiful = require("beautiful")
local gears     = require("gears")
local menubar   = require("menubar")
local naughty   = require("naughty")
local wibox     = require("wibox")

local helpers   = require("helpers")

local lain       = require("lain")
local revelation = require("widgets/revelation")
revelation.init()

require("awful.hotkeys_popup.keys")
local hotkeys_popup = require("awful.hotkeys_popup").widget

--custom_hotkeys_popup_list = {
--    labels = {
--        Mod4="⌘",
--        Mod1="Alt",
--        Escape="Esc",
--        Insert="Ins",
--        Delete="Del",
--        Backspace="BackSpc",
--        Return="Enter",
--        Next="PgDn",
--        Prior="PgUp",
--        ['#108']="Alt Gr",
--        Left='←',
--        Up='↑',
--        Right='→',
--        Down='↓',
--        ['#67']="F1",
--        ['#68']="F2",
--        ['#69']="F3",
--        ['#70']="F4",
--        ['#71']="F5",
--        ['#72']="F6",
--        ['#73']="F7",
--        ['#74']="F8",
--        ['#75']="F9",
--        ['#76']="F10",
--        ['#95']="F11",
--        ['#96']="F12",
--        ['#10']="1",
--        ['#11']="2",
--        ['#12']="3",
--        ['#13']="4",
--        ['#14']="5",
--        ['#15']="6",
--        ['#16']="7",
--        ['#17']="8",
--        ['#18']="9",
--        ['#19']="0",
--        ['#20']="-",
--        ['#21']="=",
--        Control="Ctrl",
--        XF86AudioPrev="",
--        XF86AudioPlay="",
--        XF86AudioNext=""
--    },
--}
--custom_hotkeys_popup = hotkeys_popup.new(custom_hotkeys_popup_list)

local bindings = {}

modkey = "Mod4"
alt    = "Mod1"

-- {{{ Mouse bindings
bindings.mouse = {
    global = gears.table.join(
        awful.button({ }, 3, function() helpers.async_with_shell("jgmenu_run", function(out) end) end),
        awful.button({ }, 4, awful.tag.viewnext),
        awful.button({ }, 5, awful.tag.viewprev)
    ),

    clientbuttons = gears.table.join(
        awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
        awful.button({ modkey }, 1, awful.mouse.client.move),
        awful.button({ modkey }, 3, awful.mouse.client.resize)
    )
}
-- }}}

-- {{{ Key bindings
bindings.globalkeys = gears.table.join(
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
        {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "Left",   function () awful.tag.incmwfact(-0.01)    end,
        {description = "Decrease Tile Size", group = "tag"}),
    awful.key({ modkey,           }, "Right",  function () awful.tag.incmwfact( 0.01)    end,
        {description = "Increase Tile Size", group = "tag"}),
    awful.key({ modkey,        }, "Tab", awful.tag.history.restore,
        {description = "go back", group = "tag"}),
    awful.key({ modkey,           }, "e", revelation, { description = "exposé view of all clients", group = "client" }),
    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    --awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
    --    {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
        {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
        {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
        {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
        {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
        {description = "jump to urgent client", group = "client"}),
    awful.key({ alt,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
        {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
        {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
        {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
        {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
        {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
        {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
        {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
        {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
        {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
        {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
        {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
        function ()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                client.focus = c
                c:raise()
            end
        end,
        {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ modkey }, "r", function () awful.screen.focused().mypromptbox:run() end,
        {description = "run prompt", group = "launcher"}),

    awful.key({ modkey }, "x",
        function ()
            awful.prompt.run {
                prompt       = "Run Lua code: ",
                textbox      = awful.screen.focused().mypromptbox.widget,
                exe_callback = awful.util.eval,
                history_path = awful.util.get_cache_dir() .. "/history_eval"
            }
        end,
        {description = "lua execute prompt", group = "awesome"}),

    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end,
        {description = "show the menubar", group = "launcher"}),

    awful.key({ alt }, "space",
        function()
            helpers.async('rofi -show', function(out) end)
        end, {description = "rofi launcher", group = "launcher"}
    ),

    -- Brightness
    awful.key({ }, "XF86MonBrightnessDown",
        function()
            helpers.async("light -U 3%", function()
                              awesome.emit_signal("brightness:change")
            end)
        end, { description = "Decrease Brightness", group = "hotkeys" }),
    awful.key({ "Control" }, "XF86MonBrightnessDown",
        function()
            helpers.async("light -U 20%", function()
                              awesome.emit_signal("brightness:change")
            end)
        end, { description = "Decrease Brightness by 20%", group = "hotkeys" }),

    awful.key({ }, "XF86MonBrightnessUp",
        function ()
            helpers.async("light -A 3%", function()
                              awesome.emit_signal("brightness:change")
            end)
        end, { description = "Increase Brightness", group = "hotkeys" }),
    awful.key({ "Control" }, "XF86MonBrightnessUp",
        function ()
            helpers.async("light -A 20%", function()
                              awesome.emit_signal("brightness:change")
            end)
        end, { description = "Increase Brightness by 20%", group = "hotkeys" }),

    -- Volume control
    awful.key({ }, "XF86AudioLowerVolume", function()
            helpers.async("pactl -- set-sink-volume 0 -5%", function(out)
                              awesome.emit_signal("volume::change") end)
                                           end,
        { description = "Decrease Volume", group = "hotkeys" }
    ),
    awful.key({ }, "XF86AudioRaiseVolume", function()
            helpers.async("pactl -- set-sink-volume 0 +5%", function(out)
                              awesome.emit_signal("volume::change") end)
                                           end,
        { description = "Increase Volume", group = "hotkeys" }),

    -- Printscreen
    awful.key({  }, "Print",
        function ()
            helpers.async("flameshot gui -p '/home/mustaqim/Pictures/Screenshots'", function(out) end)
        end, { description = "Printscreen", group = "hotkeys"}),

    awful.key({ modkey }, "y", function ()
            helpers.async_with_shell("mpv --x11-name=mpvstream $(xclip -selection clipboard -o)", function(out) end) end,
        { description = "Play clipboard content with mpv", group = "hotkeys"})

    -- awful.key({ modkey }, "z", function ()
    --         -- awful.spawn.easy_async_with_shell("XF86Sleep") end,
    --     { description = "Sleep", group = "hotkeys"})

    -- Toggle redshift with Mod+Shift+t
    --awful.key({ modkey, "Shift" }, "t", function () lain.widget.contrib.redshift:toggle() end)
)

bindings.clientkeys = gears.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Control"   }, "w",      function (c) c:kill()                         end,
        {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
        {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
        {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
        {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
        {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"}),
    awful.key({ modkey, }, "c", awful.placement.centered,{
            description = "centre floating window", group = "client"}),

    awful.key({ modkey, "Control" }, "t",
        awful.titlebar.toggle,
        {description = "toggle title bar", group = "client"}),


    awful.key({ modkey, "Shift" }, "s",
        function (c) c.sticky = not c.sticky  end,
        {description = "sticky client", group = "client"}),

    awful.key({ modkey }, "a",
        function (c)
            c.floating = not c.floating
            c.width = c.screen.geometry.width*3/5
            c.x = c.screen.geometry.x+(c.screen.geometry.width/5)
            c.height = c.screen.geometry.height * 0.93
            c.y = c.screen.geometry.height* 0.04
    end)

)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    bindings.globalkeys = gears.table.join(
        bindings.globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
            function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
            function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end,
            {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end


-- Set keys
root.buttons(bindings.mouse.global)
root.keys(bindings.globalkeys)
-- }}}

return bindings
