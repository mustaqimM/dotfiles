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
      "Chromium", "Firefox", "Next", "Nightly", "Plank", "qutebrowser", "Surf" },
    instance = { "mpvstream" }
  },
  {
    name        = "​",                   -- Call the tag "Term"
    init        = true,                   -- Load the tag on startup
    exclusive   = true,                   -- Refuse any other type of clients (by classes)
    screen      = {1,2},                  -- Create gnhis tag on screen 1 and screen 2
    layout      = awful.layout.suit.spiral,         -- Use the tile layout
    class       = { --Accept the following classes, refuse everything else (because of "exclusive=true")
      "Alacritty", "kitty", "konsole", "st", "Tilix", "URxvt", "UXTerm", "xst", "feh", "sxiv" }
  },
  {
    name        = "Files",
    init        = false,
    exclusive   = true,
    screen      = 1,
    layout      = awful.layout.suit.floating,
    --exec_once   = {"dolphin"}, --When the tag is accessed for the first time, execute this command
    class  = {
      "Thunar", "dolphin", "Org.gnome.Nautilus", "Nemo", "pcmanfm-qt" }
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
      "Xpdf"          , "Zeal"           , "Zathura", "com.github.johnfactotum.Foliate" }
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
    --no_tag_deselect=true,
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
    no_focus_stealing_in = true,
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
      "Code - OSS", "Emacs", "jetbrains-studio", "jetbrains-webstorm", "QtCreator"}
  },
  {
    name        = "",
    init        = false,
    exclusive   = true,
    class       = { "Franz", "Fractal", "konversation", "nheko" }
  },
  {
    name        = "",
    init        = false,
    exclusive   = true,
    class       = { "Gramps" }
  }
}

-- Ignore the tag "exclusive" property for the following clients (matched by classes)
tyrannical.properties.intrusive = {
  "AboutKDE", "Backgroundcolor", "Gradienteditor", "gtksu", "kcalc",
  "kcolorchooser", "kruler", "ksnapshot", "PasteSpecial", "pinentry",
  "plasmaengineexplorer", "plasmoidviewer", "Surf", "xcalc", "Xephyr" }

-- Ignore the tiled layout for the matching clients
tyrannical.properties.floating = {
  "gtksu", "InsertPicture", "kcalc", "kcharselect", "kcolorchooser", "kmix",
  "kruler", "ksnapshot", "MPlayer", "mythfrontend", "NewForm", "PasteSpecial",
  "pinentry", "pinentry", "plasmoidviewer", "SelectColor$", "xcalc", "xine", "yakuake" }

-- Make the matching clients (by classes) on top of the default layout
tyrannical.properties.ontop = {
  "Xephyr"       , "ksnapshot"       , "kruler"
}

-- Force the matching clients (by classes) to be centered on the screen on init
tyrannical.properties.placement = {
  dolphin = awful.placement.centered,
  kcalc   = awful.placement.centered,
  --mpv     = awful.placement.centered,
  Firefox = awful.placement.centered,
}

tyrannical.properties.fullscreen   = { "mpv" }
tyrannical.properties.skip_taskbar = { "Plank" }
tyrannical.properties.sticky       = { "Plank" }

tyrannical.settings.block_children_focus_stealing = true --Block popups ()
tyrannical.settings.group_children = false --Force popups/dialogs to have the same tags as the parent client


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
        "New tag",
        "Welcome to Android Studio"
      },
      role = {
        "AlarmWindow",  -- Thunderbird's calendar.
        "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
      },
      type = {
        -- "dialog",
      },
  },
    properties = { floating = true, titlebars_enabled = false },
    callback = function (c)
      --c:geometry({ width = 505, height = 206 })
      awful.placement.centered(c, { honor_workarea=true })
    end
  },

  { rule_any = { role = { "GtkFileChooserDialog", "gimp-file-open" } },
    callback = function (c)
      c:geometry({ width = 1024, height = 506 })
      awful.placement.top(c, { honor_workarea=true })
    end
  },

  { rule = { role = "PictureInPicture" },
    properties = { floating = true, sticky = true, skip_taskbar = true },
    callback = function (c) awful.placement.bottom_right(c) end },
  { rule_any = { name = "Firefox Safe Mode", "Refresh Firefox",
                 "Extension: (Tree Style Tab) - Close tabs? - Mozilla Firefox" },
    properties = { width = 505, height = 206, floating = true },
    callback = function (c) awful.placement.centered(c) end
  },

  { rule_any = { class = { "dolphin", "Org.gnome.Nautilus" } },
    properties = { width = screen_width * 0.85, height = screen_height * 0.75 },
    callback = function (c) awful.placement.centered(c) end
  },

  { rule_any = { name = { "KeePassXC - Browser Access Request", "Confirm Removal",
                          "Auto-Type - KeePassXC", "KeePassXC: Overwrite existing key?",
                          "Confirm Remove TOTP Settings", "Timed Password", "Confirm remove",
                          "Delete entry?", "Move entry to recycle bin?",
                          "KeePassXC: New key association request", "KeePassXC: Update Entry",
                          "Setup TOTP", "Download Favicons", "win0" } },
    --type = { "dialog" },
    properties = { sticky = true },
    callback = function (c)
      awful.placement.centered(c)
      c:geometry({ width = 505, height = 206 }) end },
  { rule = { class = "KeePassXC" },
    properties = { width = screen_width * 0.70, height = screen_height * 0.75 },
    callback = function (c) awful.placement.centered(c) end
  },

  { rule = { instance = "mpvstream" },
    properties = { floating = true, sticky = true, skip_taskbar = true, width = 500, height = 300 },
    callback = function (c)
      --c:geometry({ width = 500, height = 300 })
      awful.placement.bottom_right(c) end
  },

  { rule_any = { name = { "Upload to Imgur", "Tip of the Day - Gramps"} },
    properties = {
                   titlebars_enabled = false,
                   floating = true, sticky = true },
    callback = function (c)
      c:geometry({ width = 520, height = 330 })
      awful.placement.centered(c) end
  },

  { rule = { class = "feh" },
    properties = { fullscreen = false, titlebars_enabled = false,
                   floating = true, border_width = 0 },
    callback = function (c)
      c:geometry({ width = 1024, height = 576 })
      awful.placement.centered(c) end
  },

  { rule = { class = "nheko" },
    properties = { fullscreen = false, titlebars_enabled = false,
                   floating = true, border_width = 0 },
    callback = function (c)
      awful.placement.centered(c) end
  },

  { rule = { class = "jetbrains-studio",
             name="^win[0-9]+$" },
    properties = {
      placement = awful.placement.no_offscreen,
      titlebars_enabled = false
    }
  },

  { rule_any = { name = { "Close Query — Konversation", "Configure — Konversation",
                          "Close Tab — Konversation", "Leave Channel — Konversation",
                          "Disconnect From Server — Konversation", "Server List — Konversation",
                          "Join Channel — Konversation" } },
    --type = { "dialog" },
    properties = { sticky = true },
    callback = function (c)
      awful.placement.centered(c)
      -- c:geometry({ width = 505, height = 206 })
    end
  },

}
-- }}}
