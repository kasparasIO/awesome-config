local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local theme = require("theme.theme")
local date = require("widgets.topbar.date")
local fancy_taglist = require("widgets.topbar.taglist") -- Assuming this is the correct path to your fancy_taglist module
local dpi = beautiful.xresources.apply_dpi

local function M (s)
    -- Define taglist and tasklist buttons if not defined elsewhere
    local mytagbuttons = awful.util.table.join(
        awful.button({}, 1, function(t) t:view_only() end),
        awful.button({modkey}, 1, function(t)
            if client.focus then
                client.focus:move_to_tag(t)
            end
        end)
    )

    local mytasklistbuttons = awful.util.table.join(
        awful.button({}, 1, function(c)
            if c == client.focus then
                c.minimized = true
            else
                c:emit_signal("request::activate", "tasklist", {raise = true})
            end
        end)
    )

    -- Initialize the fancy taglist for this screen
    local new_taglist = fancy_taglist.new({
        screen = s,
        taglist = { buttons = mytagbuttons },
        tasklist = { buttons = mytasklistbuttons }
    })
    local margin_taglist = wibox.container.margin(new_taglist, dpi(8), dpi(8))
    local taglist = wibox.container.background(
    margin_taglist,
    theme.primary_dark,
    function (cr, w, h)
      gears.shape.rounded_rect(cr, w, h, dpi(18))
    end
  )


    local wibar = awful.wibar({
        position = "top",
        screen = s,
        stretch = true,
        height = dpi(36),
        bg = theme.bg_normal,
        fg = theme.fg_normal
    })

    -- Setup the wibar
    wibar:setup {
        layout = wibox.layout.align.horizontal,
        expand = "outside",
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            {
              widget = wibox.container.margin,
              left = dpi(4),
              {
              layout = wibox.layout.fixed.horizontal,
              taglist,
              }
            },
        },
        { -- Middle widgets
            layout = wibox.layout.flex.horizontal,
            date,
        },
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
        }
    }

    return wibar
end

return M
