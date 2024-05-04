local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local theme = require("theme.theme")
local dpi = beautiful.xresources.apply_dpi

local ICON_DIR = os.getenv("HOME") .. "/.config/awesome/theme/menu/"
local menu_img = ICON_DIR .. "menu.png"
local profile_img = ICON_DIR .. "profile.png"


local function command_buttons()
    return wibox.widget {
        {
            {
                {
                    -- Image widget for restart
                    widget = wibox.widget.imagebox,
                    image = ICON_DIR .. "restart.png",
                    resize = true,
                    forced_width = dpi(48),
                    forced_height = dpi(48),
                },
                -- Place widget to center the imagebox
                layout = wibox.container.place
            },
            buttons = awful.util.table.join(
                awful.button({}, 1, function () awesome.restart() end)
            ),
            widget = wibox.container.margin,
            margins = dpi(4),
        },
        {
          {
              {
                  -- Image widget for sleep
                  widget = wibox.widget.imagebox,
                  image = ICON_DIR .. "sleep.png",
                  resize = true,
                  forced_width = dpi(48),
                  forced_height = dpi(48),
              },
              layout = wibox.container.place
          },
          buttons = awful.util.table.join(
              awful.button({}, 1, function () os.execute("systemctl suspend") end)
          ),
          widget = wibox.container.margin,
          margins = dpi(4)
        },
        {
          {
              {
                  -- Image widget for shut down
                  widget = wibox.widget.imagebox,
                  image = ICON_DIR .. "shut-down.png",
                  resize = true,
                  forced_width = dpi(48),
                  forced_height = dpi(48),
              },
              layout = wibox.container.place
          },
          buttons = awful.util.table.join(
              awful.button({}, 1, function () awesome.quit() end)
          ),
          widget = wibox.container.margin,
          margins = dpi(4)
        },
        layout = wibox.layout.align.horizontal,
        expand = "outside"
    }
end

local function profile()
    return wibox.widget {
        {
            -- Image widget with specified size
            {
                widget = wibox.widget.imagebox,
                image = profile_img,
                resize = true,
                forced_width = dpi(112),
                forced_height = dpi(112)
            },
            -- Text widget
            {
              {
                widget = wibox.container.margin,
                top = dpi(4),
                right = dpi(42),
                {
                    widget = wibox.widget.textbox,
                    text = "Kasparas",
                    align = "center"
                },
              },
              {
                widget = wibox.container.margin,
                top = dpi(8),
                right = dpi(24),
                command_buttons()
              },
                layout = wibox.layout.fixed.vertical,
                spacing = dpi(12),
            },
            layout = wibox.layout.fixed.horizontal,
            forced_width = dpi(420),
            fill_space = true,
        },
        widget = wibox.container.background,
        bg = theme.primary_darkest,
        shape = gears.shape.rounded_rect,
    }
end

local menu_popup = awful.popup {
    widget = {
        {
          {
            widget = wibox.container.margin,
            profile()
          },
            {
                text   = "Item 2",
                widget = wibox.widget.textbox
            },
            layout = wibox.layout.fixed.vertical
        },
        margins = dpi(12),
        widget  = wibox.container.margin
    },
    ontop = true,
    visible = false,
    shape = function (cr, w, h)
    gears.shape.rounded_rect(cr, w, h, dpi(4))
    end
}

local toggle_popup = function()
    if menu_popup.visible then
        menu_popup.visible = false
    else
        menu_popup:move_next_to(mouse.current_widget_geometry)
    end
end

local function menu()
  return {
    {
      {
        widget = wibox.widget.imagebox,
        image =  menu_img,
        resize = true,
        forced_width = dpi(32),
        forced_height = dpi(32)
      },
      widget = wibox.container.place,
    },
    widget = wibox.container.background,
    bg = theme.primary,
    shape = gears.shape.circle,
    buttons = awful.util.table.join(
        awful.button({}, 1, function()
        toggle_popup()
        end)
    )
  }
end

return menu

