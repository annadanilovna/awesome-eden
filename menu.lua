--
--
--

local awful         = require("awful")
local beautiful     = require("beautiful")
local freedesktop   = require("freedesktop")
-- local menubar       = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
                      require("awful.hotkeys_popup.keys")

local config        = require("config")
local menu = {}

menu.mainmenu = freedesktop.menu.build {
    before = {
        { "AWESOME", nil, beautiful.awesome_icon },
        { "", nil},
    },
    after = {
        { "", nil},
        { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
        { "quit", function() awesome.quit() end },
    }
}

menu.launcher = awful.widget.launcher({
    image = beautiful.awesome_icon,
    menu = menu.mainmenu })

-- menubar.utils.terminal = config.terminal

return menu
