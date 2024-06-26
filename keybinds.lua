local awful = require("awful")
local gears = require("gears")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
local bottom_bar = require("widgets.bottom-launch.bottom_launcher")

local M = {};
local modkey  = "Mod4"

local brightness = 100

local function increment_brightness()
  if brightness < 100 then
    brightness = brightness + 5
    awful.spawn("brightnessctl set "..brightness.."%")
  end
end

local function decrement_brightness()
  if brightness - 5  >= 5 then
    brightness = brightness - 5
    awful.spawn("brightnessctl set "..brightness.."%")
  end
end

M.globalkeys = gears.table.join(
    awful.key(
    { modkey,}, "s", hotkeys_popup.show_help,
    {description="show help", group="awesome"}),

    awful.key({ modkey }, "j",function () awful.client.focus.byidx( 1) end,
    {description = "focus next by index", group = "client"}
    ),

    awful.key({ modkey }, "k", function () awful.client.focus.byidx(-1) end,
    {description = "focus previous by index", group = "client"}
    ),
    -- Layout manipulation
    awful.key({ modkey, "Shift"},"j", function () awful.client.swap.byidx(  1) end,
    {description = "swap with next client by index", group = "client"}),

    awful.key({ modkey, "Shift"}, "k", function () awful.client.swap.byidx( -1) end,
    {description = "swap with previous client by index", group = "client"}),

    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
    {description = "focus the next screen", group = "screen"}),

    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
    {description = "focus the previous screen", group = "screen"}),

    awful.key({}, "Print", function () awful.spawn("flameshot gui") end,
    {description = "take screenshot", group = "custom"}),
    -- Standard program
    awful.key({ modkey}, "Return", function () awful.spawn(terminal) end,
    {description = "open a terminal", group = "launcher"}),

    awful.key({modkey, "Control"}, "b", function() awful.spawn("chromium") end,
    {description = "open browser", group = "custom"}),

    awful.key({modkey, "Control"}, "o", function() 
    if bottom_bar.visible then bottom_bar.visible = false
    else 
      bottom_bar.visible = true
    end
  end,
    {description = "open browser", group = "custom"}),

    awful.key({ modkey, "Control" }, "r", awesome.restart,
    {description = "reload awesome", group = "awesome"}),

    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
    {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey }, "l", function () awful.tag.incmwfact( 0.1) end,
    {description = "increase master width factor", group = "layout"}),

    awful.key({ modkey }, "h", function () awful.tag.incmwfact(-0.1) end,
    {description = "decrease master width factor", group = "layout"}),

    awful.key({ modkey, "Shift"}, "m", function () awful.tag.incnmaster( 1, nil, true) end,
    {description = "increase the number of master clients", group = "layout"}),

    awful.key({ modkey, "Shift"}, "l",function () awful.tag.incnmaster(-1, nil, true) end,
    {description = "decrease the number of master clients", group = "layout"}),

    awful.key({ modkey, "Control" }, "h", function () awful.tag.incncol( 1, nil, true) end,
    {description = "increase the number of columns", group = "layout"}),

    awful.key({ modkey, "Control" }, "l", function () awful.tag.incncol(-1, nil, true) end,
    {description = "decrease the number of columns", group = "layout"}),

    awful.key({ modkey }, "space", function () awful.layout.inc(1) end,
    {description = "select next", group = "layout"}),

    awful.key({ modkey, "Shift"}, "space", function () awful.layout.inc(-1) end,
    {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
    {description = "restore minimized", group = "client"}),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end,
    {description = "show the menubar", group = "launcher"}),

    awful.key({modkey, "Shift"}, "=", function () increment_brightness() end,
    {description = "increment brightness", group = "custom"}),

    awful.key({modkey, "Shift"}, "-", function () decrement_brightness() end,
    {description = "decrement brightness", group = "custom"})

)

M.clientkeys = gears.table.join(
    awful.key({modkey, "Shift"}, "f",
        function (c)
            c:raise()
        end,
    {description = "toggle fullscreen", group = "client"}),

    awful.key({ modkey, "Control" }, "w", function (c) c:kill()  end,
    {description = "close", group = "client"}),

    awful.key({ modkey }, "f",  awful.client.floating.toggle                     ,
    {description = "toggle floating", group = "client"}),

    awful.key({ modkey, "Shift" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
    {description = "move to master", group = "client"}),

    awful.key({modkey}, "t",function (c) c.ontop = not c.ontop end,
    {description = "toggle keep on top", group = "client"}),

    awful.key({modkey}, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
    {description = "minimize", group = "client"}),

    awful.key({modkey}, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end,
        {description = "(un)maximize", group = "client"}),

    awful.key({ modkey, "Shift" }, "v",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end,
        {description = "(un)maximize vertically", group = "client"}),

    awful.key({ modkey, "Shift" }, "h",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end,
        {description = "(un)maximize horizontally", group = "client"})
)
return M

