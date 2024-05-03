local awful = require("awful")
local gears = require("gears")
local theme = require("theme.theme")
local beautiful = require("beautiful")
local wibox = require("wibox")


local dpi = beautiful.xresources.apply_dpi

local M = wibox.widget.textclock("%H:%M")
M.font = "RobotoMono Nerd Font 16"

local calendar = awful.widget.calendar_popup.year({
  spacing = dpi(3.5),
  style_year = {
    bg_color = theme.primary,
    padding = dpi(1),
  },
  style_yearheader = {
    border_width = 0,
    padding = dpi(8)
  },
  style_header = {
    border_width = 0
  },
  style_month = {
    bg_color = theme.bg_normal,
    border_width = 0,
    padding = dpi(4),
  },
  style_weekday = {
    bg_color = theme.primary,
    padding = dpi(6),
    border_width = 0,
    shape = function (cr, width, height)
      gears.shape.rounded_rect(cr, width, height, 4)
    end
  },
  style_normal = {
    bg_color = theme.primary_dark,
    border_width = 0,
    padding = dpi(6),
    shape = function (cr, width, height)
      gears.shape.rounded_rect(cr, width, height, 4)
    end
  },
  style_focus = {
    bg_color = theme.primary_light,
    border_width = 0,
    padding = dpi(6),
    shape = function (cr, width, height)
      gears.shape.rounded_rect(cr, width, height, 4)
    end
  }
})
calendar:attach(M, "tc",{on_hover = false})

return M
