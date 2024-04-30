local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

local tasklist_buttons = gears.table.join(
  awful.button({ }, 1, function (c)
    if c == client.focus then
      c.minimized = true
    else
      c:emit_signal(
        "request::activate",
        "tasklist",
        {raise = true}
      )
    end
  end))

local function create_tasklist(s)
    return awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        widget_template = {
            {
                {
                    {
                        id = 'icon_role',
                        widget = wibox.widget.imagebox,
                        forced_height = 22,
                        forced_width = 22,
                    },
                      widget = wibox.container.place,
                      halign = "center",
                      valign = "center",
                },
                  {
                      margins = 4,
                      widget = wibox.container.margin,
                  },
                {
                    id = 'text_role',
                    widget = wibox.widget.textbox,
                },
                layout = wibox.layout.fixed.horizontal,
            },
            left  = 12,
            right = 12,
            widget = wibox.container.margin
        }
    }
end

return create_tasklist
