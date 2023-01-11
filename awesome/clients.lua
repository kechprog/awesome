local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")

local MODKEY = "Mod1"

CLIENTKEYS = gears.table.join(
  awful.key({ MODKEY, }, "f",
    function(c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end,
    { description = "toggle fullscreen", group = "client" }),

  awful.key({ MODKEY }, "q", function(c) c:kill() end,
    { description = "close", group = "client" }),

  awful.key({ MODKEY, "Control" }, "Return", function(c) c:swap(awful.client.getmaster()) end,
    { description = "move to master", group = "client" }),

  awful.key({ MODKEY, }, "o", function(c) c:move_to_screen() end,
    { description = "move to screen", group = "client" }),

  awful.key({ MODKEY, }, "t", function(c) c.ontop = not c.ontop end,
    { description = "toggle keep on top", group = "client" }),

  awful.key({ MODKEY, }, "n",
    function(c)
      -- The client currently has the input focus, so it cannot be
      -- minimized, since minimized clients can't have the focus.
      c.minimized = true
    end,
    { description = "minimize", group = "client" }),

  awful.key({ MODKEY, }, "m",
    function(c)
      c.maximized = not c.maximized
      c:raise()
    end,
    { description = "(un)maximize", group = "client" }),

  awful.key({ MODKEY, "Control" }, "m",
    function(c)
      c.maximized_vertical = not c.maximized_vertical
      c:raise()
    end,
    { description = "(un)maximize vertically", group = "client" }),

  awful.key({ MODKEY, "Shift" }, "m",
    function(c)
      c.maximized_horizontal = not c.maximized_horizontal
      c:raise()
    end,
    { description = "(un)maximize horizontally", group = "client" })
)

local MOUSE_BUTTONS = gears.table.join(
  awful.button({ MODKEY }, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.move(c)
  end),
  awful.button({ MODKEY, "Shift" }, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.resize(c)
  end)
)



awful.rules.rules = {
  -- All clients will match this rule.
  {
    rule = {},
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus        = awful.client.focus.filter,
      raise        = true,
      keys         = CLIENTKEYS,
      buttons      = MOUSE_BUTTONS,
      screen       = awful.screen.preferred,
      placement    = awful.placement.no_offscreen + awful.placement.under_mouse--+ awful.placement.no_overlap 
    }
  },

  -- Floating clients.
  { rule_any = {
    instance = {
      "DTA", -- Firefox addon DownThemAll.
      "copyq", -- Includes session name in class.
      "pinentry",
    },
    class = {
      "Arandr",
      "Blueman-manager",
      "Gpick",
      "Kruler",
      "MessageWin", -- kalarm.
      "Sxiv",
      "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
      "Wpa_gui",
      "veromix",
      "xtightvncviewer"
    },

    -- Note that the name property shown in xprop might be set slightly after creation of the client
    -- and the name shown there might not match defined rules here.
    name = {
      "Event Tester", -- xev.
    },
    role = {
      "AlarmWindow", -- Thunderbird's calendar.
      "ConfigManager", -- Thunderbird's about:config.
      "pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
    }
  }, properties = { floating = true } },

  -- Add titlebars to normal clients and dialogs
  { rule_any = { type = { "normal", "dialog" }
  }, properties = { titlebars_enabled = true }
  },
}
