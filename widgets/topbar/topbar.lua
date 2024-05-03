local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local theme = require("theme.theme")
local date = require("widgets.topbar.date")
local taglist = require("widgets.topbar.taglist")
local layout_widget  = require("widgets.topbar.layoutw")
local battery = require("widgets.topbar.baterry")
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
    local _taglist = taglist.new({
        screen = s,
        taglist = { buttons = mytagbuttons },
        tasklist = { buttons = mytasklistbuttons }
    })
    local taglist_container = wibox.container.background(
    wibox.container.margin(_taglist, dpi(16), dpi(16), dpi(4), dpi(4)),
    theme.primary_dark,
    function (cr, w, h)
      gears.shape.rounded_rect(cr, w, h, dpi(18))
    end
  )
    local layoutw = layout_widget(s)


    local wibar = awful.wibar({
        position = "top",
        screen = s,
        stretch = true,
        height = dpi(42),
        bg = theme.bg_normal,
        fg = theme.fg_normal
    })

    -- Setup the wibar
    wibar:setup {
        layout = wibox.layout.align.horizontal,
        expand = "none",
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            {
            widget = wibox.container.margin,
            top = dpi(4),
            bottom = dpi(4),
            {
              widget = wibox.container.margin,
              left = dpi(4),
              {
              layout = wibox.layout.fixed.horizontal,
              taglist_container,
              }
            },
      },
        },
        { -- Middle widgets
           layout = wibox.layout.fixed.horizontal,
           date,
        },
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            battery({
            main_color = theme.primary_light
            }),
            layoutw,
        }
    }

    return wibar
end

return M
