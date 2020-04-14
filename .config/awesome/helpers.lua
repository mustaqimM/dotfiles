local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local spawn = require("awful.spawn")

local helpers = {}

-- {{{ Helper functions
function helpers.client_menu_toggle()
    local instance = nil

    return function ()
        if instance and instance.wibox.visible then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({ theme = { width = 250 } })
        end
    end
end


-- Create rounded rectangle shape
helpers.rrect = function(radius)
    return function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, radius)
        --gears.shape.octogon(cr, width, height, radius)
        --gears.shape.rounded_bar(cr, width, height)
    end
end

-- Create rectangle shape
helpers.rect = function()
    return function(cr, width, height)
        gears.shape.rectangle(cr, width, height)
    end
end


-- run a command and execute a function on its output (asynchronous pipe)
-- @param cmd the input command
-- @param callback function to execute on cmd output
-- @return cmd PID
function helpers.async(cmd, callback)
    return spawn.easy_async(cmd,
    function (stdout, stderr, reason, exit_code)
        callback(stdout, exit_code)
    end)
end

-- like above, but call spawn.easy_async with a shell
function helpers.async_with_shell(cmd, callback)
    return spawn.easy_async_with_shell(cmd,
    function (stdout, stderr, reason, exit_code)
        callback(stdout, exit_code)
    end)
end

-- run a command and execute a function on its output line by line
function helpers.line_callback(cmd, callback)
    return spawn.with_line_callback(cmd, {
        stdout = function (line)
            callback(line)
        end,
    })
end


function helpers.colorize_text(text, color)
    return "<span foreground='" .. color .."'>" .. text .. "</span>"
end


-- Helper function that puts a widget inside a box with a specified background color
-- Invisible margins are added so that the boxes created with this function are evenly separated
-- The widget_to_be_boxed is vertically and horizontally centered inside the box
function helpers.create_boxed_widget(widget_to_be_boxed, width, height, bg_color)
    local box_container = wibox.container.background()
    box_container.bg = bg_color
    box_container.forced_height = height
    box_container.forced_width = width
    box_container.shape = helpers.rrect(box_radius)
    -- box_container.shape = helpers.prrect(20, true, true, true, true)
    -- box_container.shape = helpers.prrect(30, true, true, false, true)

    local boxed_widget = wibox.widget {
        -- Add margins
        {
            -- Add background color
            {
                -- Center widget_to_be_boxed horizontally
                nil,
                {
                    -- Center widget_to_be_boxed vertically
                    nil,
                    -- The actual widget goes here
                    widget_to_be_boxed,
                    layout = wibox.layout.align.vertical,
                    expand = "none"
                },
                layout = wibox.layout.align.horizontal,
                expand = "none"
            },
            widget = box_container,
        },
        margins = box_gap,
        color = "#FF000000",
        widget = wibox.container.margin
    }

    return boxed_widget
end

-- }}}

return helpers
