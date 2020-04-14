local awful      = require("awful")
local beautiful  = require("beautiful")

local tyrannical = require("tyrannical")
--require("tyrannical.shortcut") --optional

local bindings   = require("bindings")

local lain       = require("lain")
local markup     = lain.util.markup
local separators = lain.util.separators

screen_width     = awful.screen.focused().geometry.width
screen_height    = awful.screen.focused().geometry.height


tyrannical.tags = {
  {
    name        = "",
    init        = true,
    exclusive   = false,
    no_focus_stealing_in = false,
    --icon        = "~net.png",                -- Use this icon for the tag (uncomment with a real path)
    screen      = screen.count()>1 and 2 or 1, -- Setup on screen 2 if there is more than 1 screen, else on screen 1
    layout      = awful.layout.suit.max,                 -- Use the max layout
    class = {
      "Opera"         , "Firefox"        , "Next"        , "qutebrowser",
      "Chromium"      , "nightly"        , "Plank"       , "Surf" }
  },
  {
    name        = "​",                   -- Call the tag "Term"
    init        = true,                   -- Load the tag on startup
    exclusive   = true,                   -- Refuse any other type of clients (by classes)
    screen      = {1,2},                  -- Create gnhis tag on screen 1 and screen 2
    layout      = awful.layout.suit.spiral,         -- Use the tile layout
    class       = { --Accept the following classes, refuse everything else (because of "exclusive=true")
      "Alacritty", "kitty", "konsole", "st", "Tilix", "URxvt", "UXTerm", "xst" }
  },
  {
    name        = "Files",
    init        = false,
    exclusive   = true,
    screen      = 1,
    layout      = awful.layout.suit.floating,
    --exec_once   = {"dolphin"}, --When the tag is accessed for the first time, execute this command
    class  = {
      "Thunar", "Konqueror", "dolphin", "ark", "Org.gnome.Nautilus", "emelfm", "Nemo", "pcmanfm-qt" }
  },
  {
    name        = "",
    init        = false, -- This tag wont be created at startup, but will be when one of the
    -- client in the "class" section will start. It will be created on
    -- the client startup screen
    exclusive   = true,
    layout      = awful.layout.suit.max,
    class       = {
      "Assistant"     , "Okular"         , "Evince"    , "EPDFviewer"   , "xpdf",
      "Xpdf"          , "Zeal"           , "Zathura"                            }
  },
  {
    name        = "",
    init        = false,
    exclusive   = true,
    no_focus_stealing_in = true,
    class       = { "KeePassXC" }
  },
  {
    name        = "",
    init        = false,
    exclusive   = true,
    class       = { "mpv" }
  },
  {
    name        = "",
    init        = false,
    exclusive   = true,
    class       = { "Lutris" }
  },
  {
    name        = "",
    init        = false,
    exclusive   = true,
    class       = { "JDownloader", "qBittorrent" }
  },
  {
    name        = "​​​​​​​​", --"",
    init        = false,
    exclusive   = true,
    screen      = 1,
    layout      = awful.layout.suit.max,
    instance    = {"dev", "ops"},         -- Accept the following instances. This takes precedence over 'class'
    class = {
      "Code - OSS", "Emacs", "jetbrains-studio", "QtCreator"}
  },
  {
    name        = "",
    init        = false,
    exclusive   = true,
    class       = { "Franz", "Fractal", "konversation" }
  }
}

-- Ignore the tag "exclusive" property for the following clients (matched by classes)
tyrannical.properties.intrusive = {
  "ksnapshot"     , "pinentry"       , "gtksu"     , "kcalc"        , "xcalc"               ,
  "feh"           , "Gradient editor", "About KDE" , "Paste Special", "Background color"    ,
  "kcolorchooser" , "plasmoidviewer" , "Xephyr"    , "kruler"       , "plasmaengineexplorer",
}

-- Ignore the tiled layout for the matching clients
tyrannical.properties.floating = {
  "MPlayer"      , "pinentry"        , "ksnapshot"  , "pinentry"     , "gtksu"          ,
  "xine"         , "feh"             , "kmix"       , "kcalc"        , "xcalc"          ,
  "yakuake"      , "Select Color$"   , "kruler"     , "kcolorchooser", "Paste Special"  ,
  "New Form"     , "Insert Picture"  , "kcharselect", "mythfrontend" , "plasmoidviewer"
}

-- Make the matching clients (by classes) on top of the default layout
tyrannical.properties.ontop = {
  "Xephyr"       , "ksnapshot"       , "kruler"
}

-- Force the matching clients (by classes) to be centered on the screen on init
tyrannical.properties.placement = {
  dolphin = awful.placement.centered,
  kcalc   = awful.placement.centered,
  mpv     = awful.placement.centered,
  Firefox = awful.placement.centered,
}

tyrannical.properties.fullscreen   = { "mpv" }
tyrannical.properties.skip_taskbar = { "Plank" }
tyrannical.properties.sticky       = { "Plank" }

tyrannical.settings.block_children_focus_stealing = true --Block popups ()
tyrannical.settings.group_children = true --Force popups/dialogs to have the same tags as the parent client


-- {{{ Rules
awful.rules.rules = {
  -- All clients will match this rule.
  { rule = { },
    properties = {
      size_hints_honor = false,             -- Remove gaps
      border_width     = beautiful.border_width,
      border_color     = beautiful.border_normal,
      focus            = awful.client.focus.filter,
      raise            = true,
      keys             = bindings.clientkeys,
      buttons          = bindings.mouse.clientbuttons,
      screen           = awful.screen.preferred,
      placement        = awful.placement.no_overlap+awful.placement.no_offscreen
    }
  },

  { rule_any = {
      instance = {
        "DTA",       -- Firefox addon DownThemAll.
        "copyq",     -- Includes session name in class.
        "Kupfer.py",
        "Browser",   -- Firefox dialog
        "Places",    -- Firefox Library
        "Dialog",    -- Firefox save
      },
      class = {
        "Arandr",
        "Gpick",
        "Kruler",
        "MessageWin",  -- kalarm.
        "Sxiv",
        "Wpa_gui",
        "pinentry",
        "veromix",
        "xtightvncviewer"
      },
      name = {
        "Event Tester",  -- xev.
        "Delete Permanently",
        "New tag"
      },
      role = {
        "AlarmWindow",  -- Thunderbird's calendar.
        "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
      },
      type = {
        "dialog",
      },
  },
    properties = { floating = true, titlebars_enabled = false },
    callback = function (c)
      --c:geometry({ width = 505, height = 206 })
      awful.placement.centered(c, { honor_workarea=true })
    end
  },

  { rule = { role = "PictureInPicture" },
    properties = { floating = true, sticky = true, skip_taskbar = true },
    callback = function (c) awful.placement.bottom_right(c) end },
  { rule = { name = "Firefox Safe Mode" },
    properties = { width = 505, height = 206, floating = true },
    callback = function (c) awful.placement.centered(c) end },

  { rule_any = { class = { "dolphin", "Org.gnome.Nautilus" } },
    properties = { width = screen_width * 0.85, height = screen_height * 0.75 },
    callback = function (c) awful.placement.centered(c) end
  },

  { rule_any = { name = { "KeePassXC-Browser Confirm Access", "Confirm Removal",
                          "Auto-Type - KeePassXC", "KeePassXC: Overwrite existing key?",
                          "Confirm Remove TOTP Settings", "Timed Password", "Confirm remove",
                          "Delete entry?", "Move entry to recycle bin?",
                          "KeePassXC: New key association request", "KeePassXC: Update Entry",
                          "Setup TOTP" } },
    --type = { "dialog" },
    properties = { sticky = true },
    callback = function (c)
      awful.placement.centered(c)
      c:geometry({ width = 505, height = 206 }) end },
  { rule = { class = "KeePassXC" },
    properties = { width = screen_width * 0.70, height = screen_height * 0.75 },
    callback = function (c) awful.placement.centered(c) end
  },

  { rule = { class = "mpv" },
    properties = { fullscreen = true, titlebars_enabled = false,
                   floating = true, border_width = 0 } },

  { rule = { name = "Upload to Imgur" },
    properties = { width = 700, height = 400,
                   titlebars_enabled = false,
                   floating = true, sticky = true },
    callback = function (c)
      awful.placement.centered(c) end },
}
-- }}}

--    -- Application specific rules
--    --{ rule = { name = "Awesome drawin" },
--    --properties = { width = 505,
--    --               height = 306 },
--    --},
--    { rule = { name = "Extension: (Aria2 Download Manager Integration) - Download Panel - Mozilla Firefox"},
--      properties = { width = 505,
--                     height = 206 },
--      callback = function (c)
--        awful.placement.centered(c) end },
--
--    { rule = { class = "feh" },
--      properties = { fullscreen = false, titlebars_enabled = false,
--                     floating = true, border_width = 0 },
--      callback = function (c)
--          c:geometry({ width = 1024, height = 576 })
--          awful.placement.centered(c) end },
  --
--    { rule = { name = "Upload to Imgur" },
--      properties = { width = 700, height = 400,
--                     titlebars_enabled = false,
--                     floating = true,
--      },
--      callback = function (c)
--        awful.placement.centered(c) end },

--    { rule = { class = "Gramps" },
--      properties = { titlebars_enabled = false } },
--    { rule = { name = "Tip of the Day - Gramps" },
--      callback = function (c)
--        awful.placement.centered(c) end },
--
--    { rule = { class = "Plank" },
--      properties = {
--          border_width = 0,
--          floating = true,
--          sticky = true,
--          ontop = false,
--          focusable = false,
--          below = true,
--          skip_taskbar = true
--      }
--    },
