---@diagnostic disable: need-check-nil, unused-local, unused-function

local naughty = require("naughty")

local exec = function(command)
  local handle = io.popen(command)
  local result = handle:read("*a")
  handle:close()
  return result
end

local M = {}

local function display_volume(volume)
  naughty.notify({
    title = "VOLUME",
    text = tostring(volume),
    timeout = M.TIME_OUT
  })
end

local function display_brightness(brightness)
  naughty.notify({
    title = "VOLUME",
    text = tostring(brightness),
    timeout = M.TIME_OUT
  })
  for s in screen do
    local pb = s.brightness_progressbar
    pb:set_value(brightness)
  end

end

------------------------
----      LIB       ----
------------------------


-- TODO:
---- NOTIFICATION FOR EACH ONE ----
---- REST OF FUNCTION KEYS     ----

M.VOL_DELTA        = 10
M.BRIGHTNESS_DELTA = 6
M.TIME_OUT         = 1.3

function M.vol_up()
  local vol = tonumber(exec("pamixer --get-volume"))
  if vol == 100 then display_volume(vol); return end
  vol = vol + M.VOL_DELTA
  exec("pamixer --set-volume " .. vol)
  display_volume(vol)
end

function M.vol_down()
  local vol = tonumber(exec("pamixer --get-volume"))
  if vol == 0 then display_volume(vol); return end
  vol = vol - M.VOL_DELTA
  exec("pamixer --set-volume " .. vol)
  display_volume(vol)
end

function M.vol_toggle_mute()
  local result = exec("pamixer --toggle-mute")
  local mute = exec("pactl get-sink-mute @DEFAULT_SINK@ | grep -oP '(?<=Mute: ).*'")

  if mute == "yes\n" then
    display_volume("mute")
  else
    display_volume("NOT mute")
  end
end

function M.get_current_brightness()
  local brightness = exec("cat /sys/class/backlight/amdgpu_bl0/brightness")
  brightness = math.floor(tonumber(brightness) / 255 * 100)
  return brightness
end

function M.brightness_up()
  exec("light -As sysfs/backlight/amdgpu_bl0 " .. M.BRIGHTNESS_DELTA)
  local brightness = exec("cat /sys/class/backlight/amdgpu_bl0/brightness")
  brightness = math.floor(tonumber(brightness) / 255 * 100)
  display_brightness(brightness)
end

function M.brightness_down()
  exec("light -Us sysfs/backlight/amdgpu_bl0 " .. M.BRIGHTNESS_DELTA)
  local brightness = exec("cat /sys/class/backlight/amdgpu_bl0/brightness")
  brightness = math.floor(tonumber(brightness) / 255 * 100)
  display_brightness(brightness)
end

function M.toggle_touchpad()
  local enabled = exec("xinput list-props 11 | grep 'Device Enabled (.*):.*1'")
  if not (enabled == "") then
    display_volume("Disabled")
    exec "xinput disable 11"
  else
    display_volume("Enabled")
    exec "xinput enable 11"
  end
end

-- TODO: EVERYTHING BELOW
function M.toggle_camera()
end

function M.screenshot()
end

function M.toggle_supermenu()
end

function M.lock_screen()
end

return M
