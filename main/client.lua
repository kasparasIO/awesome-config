local beautiful = require("beautiful")
local awful = require("awful")
local gears = require("gears")
local topbar = require("widgets.topbar.topbar")
require("widgets.bottom-launch.bottom_launcher")

require("widgets.titlebar")

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5" }, s, awful.layout.layouts[1])

  topbar(s)
  -- new topbar
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.primary_light
  c.border_width = 1 end)
client.connect_signal("unfocus", function(c) c.border_width = 0 end)
