
package.loaded.net_widgets = nil

local net_widgets = {
    indicator   = require("widgets.net_widgets.indicator"),
    wireless    = require("widgets.net_widgets.wireless"),
    internet    = require("widgets.net_widgets.internet")
}

return net_widgets
