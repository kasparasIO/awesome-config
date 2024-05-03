local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local function constrain_icon(widget)
  return {
    {
      widget,
      strategy = 'exact',
      widget = wibox.container.constraint,
      height = dpi(22),
      width = dpi(22)
    },
    widget = wibox.container.place,
  }
end

local function M(s)
  return constrain_icon(awful.widget.layoutbox(s))
end

return M
