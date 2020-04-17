-- -*- eval: (rainbow-mode); -*-

local theme_assets = require("beautiful.theme_assets")
local xresources   = require("beautiful.xresources")
local dpi          = xresources.apply_dpi

local gears = require("gears")
local gfs   = gears.filesystem

local helpers     = require("helpers")
local themes_path = gfs.get_themes_dir()
local theme_name  = "mojave"

local icon_path          = themes_path .. theme_name .. "/icons/"
local layout_icon_path   = icon_path .. "layouts/"
local taglist_icon_path  = icon_path .. "taglist/"
local titlebar_icon_path = icon_path .. "titlebar/"

local theme = {}

theme.font        = "Noto Sans 8.5"
theme.font_mono   = "Iosevka Medium"
theme.font_notif  = "SF Pro Display"
theme.font_icon   = "FantasqueSansMono Nerd Font"
theme.font_awe    = "Font Awesome 5 Pro"
theme.font_file   = "file-icons"

theme.wallpaper   = os.getenv("HOME") .. "/Pictures/Wallpapers/" .. "MK1-Dark.png"

theme.xbackground = "#17191a"
theme.xforeground = "#c5c8c6"
theme.xcolor0     = "#17191a"
theme.xcolor1     = "#c66666"
theme.xcolor2     = "#b5bd68"
theme.xcolor3     = "#f2a272"
theme.xcolor4     = "#8897f4"
theme.xcolor5     = "#c574dd"
theme.xcolor6     = "#79e6f3"
theme.xcolor7     = "#fdfdfd"
theme.xcolor8     = "#414458"
theme.xcolor9     = "#ff4971"
theme.xcolor10    = "#f0c674"
theme.xcolor11    = "#ff8037"
theme.xcolor12    = "#6eaaff"
theme.xcolor13    = "#b043d1"
theme.xcolor14    = "#3fdcee"
theme.xcolor15    = "#b4b7b4"

-- Set some colors that are used frequently as local variables
local accent_color    = theme.xcolor14
local focused_color   = theme.xcolor14
local unfocused_color = theme.xcolor7
local urgent_color    = theme.xcolor12

theme.bg_normal       = "#222222"
theme.bg_focus        = theme.xbackground
theme.bg_urgent       = urgent_color
theme.bg_minimize     = "#444444"
theme.bg_systray      = theme.bg_normal

theme.fg_normal       = "#b4b7b4"
theme.fg_focus        = "#ffffff"
theme.fg_urgent       = "#ffffff"
theme.fg_minimize     = theme.xcolor8

theme.useless_gap     = dpi(0)
--theme.systray_icon_spacing = 0

-- This could be used to manually determine how far away from the
-- screen edge the bars / notifications should be.
theme.screen_margin   = dpi(3)
theme.border_width    = dpi(0)
theme.border_radius   = dpi(8)            -- Rounded corners
theme.border_normal   = theme.xcolor0
theme.border_focus    = theme.xbackground
theme.border_marked   = theme.xcolor9
theme.border_color    = theme.xcolor9

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:

theme.taglist_bg_focus         = theme.xcolor0 .. "00"
theme.taglist_bg_urgent        = theme.xcolor0 .. "00"
theme.taglist_fg_urgent        = urgent_color
theme.taglist_spacing          = dpi(0)

theme.tasklist_disable_icon    = false
theme.tasklist_plain_task_name = false
theme.tasklist_bg_normal       = theme.xcolor0 .. "00"
theme.tasklist_fg_normal       = unfocused_color
theme.tasklist_bg_focus        = theme.xcolor0 .. "00"
theme.tasklist_bg_minimize     = theme.xcolor0 .. "00"
theme.tasklist_fg_minimize     = theme.fg_minimize
theme.tasklist_bg_urgent       = theme.xcolor0 .. "00"
theme.tasklist_fg_urgent       = urgent_color
--theme.tasklist_spacing         = dpi(50)
--theme.tasklist_align           = "center"

-- Generate taglist squares:
--local taglist_square_size = dpi(5)
--theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
--    taglist_square_size, theme.fg_normal
--)
--theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
--    taglist_square_size, theme.fg_normal
--)

theme.titlebar_bg_focus        = theme.xbackground

theme.prompt_font              = theme.font_mono

theme.hotkeys_font             = theme.font_mono .. " 10"
theme.hotkeys_description_font = theme.font_notif .. " 11"
theme.hotkeys_shape            = helpers.rrect(theme.border_radius or 8)
theme.hotkeys_border_color     = theme.xcolor8 .. "00"
theme.hotkeys_border_width     = 2
theme.hotkeys_group_margin     = 25

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Position: bottom_left, bottom_right, bottom_middle,
--         top_left, top_right, top_middle
theme.notification_position      = "top_right" -- BUG: some notifications appear at top_right regardless
theme.notification_border_width  = dpi(0)
theme.notification_border_radius = theme.border_radius
theme.notification_border_color  = theme.xcolor10
theme.notification_bg            = theme.xbackground
theme.notification_fg            = theme.xcolor7
theme.notification_crit_bg       = bg_urgent
theme.notification_crit_fg       = theme.xcolor11
theme.notification_icon_size     = dpi(50)
--theme.notification_height        = dpi(80)
--theme.notification_width         = dpi(300)
theme.notification_margin        = dpi(15)
theme.notification_opacity       = 1
theme.notification_font          = theme.font_notif .. " 9.5"
theme.notification_padding       = theme.screen_margin * 2
theme.notification_spacing       = theme.screen_margin * 2
theme.notification_max_width     = dpi(400)

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_bg_focus              = theme.xcolor12 .. "0D"
theme.menu_fg_focus              = theme.xcolor7
theme.menu_bg_normal             = theme.xbackground
theme.menu_fg_normal             = theme.xcolor7
theme.menu_border_color          = theme.xbackground
theme.menu_submenu_icon          = icon_path.."submenu.png"
theme.menu_height                = dpi(30)
theme.menu_width                 = dpi(180)
theme.menu_border_radius         = theme.border_radius

theme.snap_bg                    = theme.xcolor14 .. "2F"
theme.snap_border_width          = 2
theme.snapper_gap                = 5

-- Define the image to load
theme.titlebar_close_button_normal              = titlebar_icon_path.."close_normal.png"
theme.titlebar_close_button_focus               = titlebar_icon_path.."close_focus.png"
theme.titlebar_close_button_normal_hover        = titlebar_icon_path.."close_hover.png"
theme.titlebar_close_button_normal_press        = titlebar_icon_path.."close_press.png"

theme.titlebar_minimize_button_normal           = titlebar_icon_path.."minimize_normal.png"
theme.titlebar_minimize_button_focus            = titlebar_icon_path.."minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive     = titlebar_icon_path.."ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive      = titlebar_icon_path.."ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active       = titlebar_icon_path.."ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active        = titlebar_icon_path.."ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive    = titlebar_icon_path.."sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive     = titlebar_icon_path.."sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active      = titlebar_icon_path.."sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active       = titlebar_icon_path.."sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive  = titlebar_icon_path.."floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive   = titlebar_icon_path.."floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active    = titlebar_icon_path.."floating_normal_active.png"
theme.titlebar_floating_button_focus_active     = titlebar_icon_path.."floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = titlebar_icon_path.."maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = titlebar_icon_path.."maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active   = titlebar_icon_path.."maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active    = titlebar_icon_path.."maximized_focus_active.png"

-- You can use your own layout icons like this:
theme.layout_fairh       = layout_icon_path.."fairhw.png"
theme.layout_fairv       = layout_icon_path.."fairvw.png"
theme.layout_floating    = layout_icon_path.."floatingw.png"
theme.layout_magnifier   = layout_icon_path.."magnifierw.png"
theme.layout_max         = layout_icon_path.."maxw.png"
theme.layout_fullscreen  = layout_icon_path.."fullscreenw.png"
theme.layout_tilebottom  = layout_icon_path.."tilebottomw.png"
theme.layout_tileleft    = layout_icon_path.."tileleftw.png"
theme.layout_tile        = layout_icon_path.."tilew.png"
theme.layout_tiletop     = layout_icon_path.."tiletopw.png"
theme.layout_spiral      = layout_icon_path.."spiralw.png"
theme.layout_dwindle     = layout_icon_path.."dwindlew.png"
theme.layout_cornernw    = layout_icon_path.."cornernww.png"
theme.layout_cornerne    = layout_icon_path.."cornernew.png"
theme.layout_cornerw     = layout_icon_path.."cornerww.png"
theme.layout_cornere     = layout_icon_path.."cornerew.png"
theme.layout_cornersw    = layout_icon_path.."cornersww.png"
theme.layout_cornerse    = layout_icon_path.."cornersew.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.fg_focus, theme.bg_focus
)

theme.launcher_icon        = theme.awesome_icon --icon_path .. "awesome_iconw.png"--"wibar/void_w.png"
theme.widget_ac            = icon_path .. "wibar/ac.png"
theme.widget_battery       = icon_path .. "wibar/battery.png"
theme.widget_battery_low   = icon_path .. "wibar/battery_low.png"
theme.widget_battery_empty = icon_path .. "wibar/battery_empty.png"
theme.widget_mem           = icon_path .. "wibar/ac.png"
theme.volhigh              = icon_path .. "wibar/volume-high.png"
theme.vollow               = icon_path .. "wibar/volume-low.png"
theme.volmed               = icon_path .. "wibar/volume-medium.png"
theme.volmutedblocked      = icon_path .. "wibar/volume-muted-blocked.png"
theme.volmuted             = icon_path .. "wibar/volume-muted.png"
theme.voloff               = icon_path .. "wibar/volume-off.png"
-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = "Papirus-Dark"


return theme


-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
