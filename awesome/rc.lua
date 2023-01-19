pcall(require, "luarocks.loader")
require("awful.autofocus")
require("awful.hotkeys_popup.keys")
local awful = require("awful")
local naughty = require("naughty")

if awesome.startup_errors then
  naughty.notify({ preset = naughty.config.presets.critical,
    title = "Oops, there were errors during startup!",
    text = awesome.startup_errors })
end

do
  local in_error = false
  awesome.connect_signal("debug::error", function(err)
    -- Make sure we don't go into an endless error loop
    if in_error then return end
    in_error = true

    naughty.notify({ preset = naughty.config.presets.critical,
      title = "Oops, an error happened!",
      text = tostring(err) })
    in_error = false
  end)
end

-- global variables



awful.layout.layouts = {
  awful.layout.suit.tile,
  awful.layout.suit.floating,
}

awful.spawn.with_shell("picom --experimental-backends"   	   	  )
awful.spawn.with_shell("~/.config/awesome/mk_touchpad.sh"       )
awful.spawn.with_shell("libinput-gestures-setup autostart start")

require 'theme'
require 'screens'
require 'callbacks'
require 'clients'
require 'keymap'
require 'switcher'
require 'restore_floating_pos'

