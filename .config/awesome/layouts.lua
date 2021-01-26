local awful = require("awful")

local l = awful.layout.suit

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    l.max,
    l.spiral,
    l.max,
    l.max.fullscreen,
    l.fair,
    l.floating,
    l.spiral,
    l.spiral.dwindle,
    l.max,
    l.magnifier,
    l.corner.nw,
    -- l.corner.ne,
    -- l.corner.sw,
    -- l.corner.se,
}

return l
