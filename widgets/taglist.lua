local awful = require("awful");
local gears = require("gears");

local taglist_buttons = gears.table.join(
  awful.button({ }, 1, function(t) t:view_only() end)
)

local function create_taglist(s)
return awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
        style = {
        bg = "#000000"
    }
    }
end

return create_taglist
