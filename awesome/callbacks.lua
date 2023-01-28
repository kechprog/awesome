local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
-- local client = awful.client

client.connect_signal("manage", function(c)
  -- Set the windows at the slave,
  -- i.e. put it at the end of others instead of setting it master.
  -- if not awesome.startup then awful.client.setslave(c) end

  if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
    -- Prevent clients from being unreachable after screen count changes.
    awful.placement.no_offscreen(c)
  end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)

  local buttons = gears.table.join(
    awful.button({}, 1, function()
      c:emit_signal("request::activate", "titlebar", { raise = true })
      awful.mouse.client.move(c)
    end),
    awful.button({}, 3, function()
      c:emit_signal("request::activate", "titlebar", { raise = true })
      awful.mouse.client.resize(c)
    end)
  )

  local padding = 3
  local spacing = 7

  awful.titlebar(c, {
    position = "left",
    size     = 26,
  }):setup {
    { -- TOP
      wibox.container.margin(
        awful.titlebar.widget.closebutton(c),
        padding, padding, spacing + 4, spacing / 2),
      wibox.container.margin(
        awful.titlebar.widget.minimizebutton(c),
        padding, padding, spacing / 2, spacing / 2),
      wibox.container.margin(
        awful.titlebar.widget.maximizedbutton(c),
        padding, padding, spacing / 2, spacing),

      align  = "top",
      layout = wibox.layout.fixed.vertical,
    },

    { -- MIDDLE
      buttons = buttons,
      align   = "center",
      layout  = wibox.layout.flex.vertical
    },

    { -- BOTTOM
      wibox.container.margin(
        awful.titlebar.widget.stickybutton(c),
        padding, padding, spacing, spacing+5),
      align = "bottom",
      layout = wibox.layout.fixed.vertical(),
    },

    -- GLOBAL
    layout = wibox.layout.align.vertical
  }

  if awful.layout.get() == awful.layout.suit.tile then
    awful.titlebar.hide(c, "left")
  end

end)

-- focus follows mouse
client.connect_signal("mouse::enter", function(c)
  c:emit_signal("request::activate", "mouse_enter", { raise = true })
end)




client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
