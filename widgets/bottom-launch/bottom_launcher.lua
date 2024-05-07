local awful = require("awful")
local theme = require("theme.theme")
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")
local dpi = beautiful.xresources.apply_dpi

local ICON_DIR = os.getenv("HOME") .. "/.config/awesome/theme/bottom_bar/"

local function bottom_buttons()
    return wibox.widget {
        {
            {
                {
                    widget = wibox.widget.imagebox,
                    image = ICON_DIR .. "chromium.png",
                    resize = true,
                    forced_width = dpi(48),
                    forced_height = dpi(48),
                },
                layout = wibox.container.place
            },
            buttons = awful.util.table.join(
                awful.button({}, 1, function () awful.spawn("chromium") end)
            ),
            widget = wibox.container.margin,
            margins = dpi(4),
        },
        {
          {
              {
                  widget = wibox.widget.imagebox,
                  image = ICON_DIR .. "inode-directory.svg",
                  resize = true,
                  forced_width = dpi(48),
                  forced_height = dpi(48),
              },
              layout = wibox.container.place
          },
          buttons = awful.util.table.join(
              awful.button({}, 1, function () awful.spawn("nemo") end)
          ),
          widget = wibox.container.margin,
          margins = dpi(4)
        },
        {
          {
              {
                  -- Image widget for shut down
                  widget = wibox.widget.imagebox,
                  image = ICON_DIR .. "libreoffice-main.png",
                  resize = true,
                  forced_width = dpi(48),
                  forced_height = dpi(48),
              },
              layout = wibox.container.place
          },
          buttons = awful.util.table.join(
              awful.button({}, 1, function () awful.spawn("libreoffice") end)
          ),
          widget = wibox.container.margin,
          margins = dpi(8)
        },
        {
          {
              {
                  -- Image widget for shut down
                  widget = wibox.widget.imagebox,
                  image = ICON_DIR .. "sound.svg",
                  resize = true,
                  forced_width = dpi(48),
                  forced_height = dpi(48),
              },
              layout = wibox.container.place
          },
          buttons = awful.util.table.join(
              awful.button({}, 1, function () awful.spawn("pavucontrol") end)
          ),
          widget = wibox.container.margin,
          margins = dpi(8)
        },
         layout = wibox.layout.fixed.horizontal,
         spacing = dpi(46)
    }
end
local M = awful.popup{
  widget = {
    {
      widget = wibox.container.background,
      bg = theme.primary_darkest,
      {
          widget = wibox.container.margin,
          bottom_buttons(),
          left = dpi(12),
          right = dpi(12)
      },
    },
    layout = wibox.layout.fixed.horizontal
  },
  visible = true,
  bg = theme.bg_normal,
  shape = function (cr, w, h)
    gears.shape.rounded_rect(cr, w, h, dpi(16))
  end,
  placement = awful.placement.bottom,
  ontop = true
}

return M
