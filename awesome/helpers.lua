---@diagnostic disable: undefined-global
local awful = require("awful")

M = {}

function M.focus_to(direction)
  return function()
    awful.client.focus.bydirection(direction)
    local c = client.focus
    c:raise()
    if mouse.object_under_pointer() ~= c then
      local geometry = c:geometry()
      local x = geometry.x + geometry.width / 2
      local y = geometry.y + geometry.height / 2
      mouse.coords({ x = x, y = y }, true)
    end
  end
end

-- changes layout of a current tag
function M.toggle_state()
  local tag = client.focus and client.focus.first_tag or nil
  if tag == nil then
    awful.layout.inc(1)
    return
  end
  for _, c in ipairs(tag:clients()) do
    M.toggle_titlebar(c)
  end
  awful.layout.inc(1)
end

function M.toggle_titlebar(c)
  -- get a tag on which the client is
  local layout = awful.layout.getname(awful.layout.get(c.screen))

  -- send a notification with the layout name
  if layout == "floating" then
    awful.titlebar.hide(c, "left")
  else
    awful.titlebar.show(c, "left")
  end
end

return M
