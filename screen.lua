--
-- screen setup
--

local awful      = require("awful")
local beautiful  = require("beautiful")
local revelation = require("revelation")
local config     = require("config")

beautiful.init(string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), config.theme))
revelation.init()

-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s) beautiful.at_screen_connect(s) end)
