--[[
--
-- an awesome desktop widget
--]]

local awful    = require("awful")
local theme    = require("beautiful")
local wibox    = require("wibox")
local os       = require("os")
local gears    = require("gears")

local desktop = {}


local screen = screen
local pos_props = {
    pos = { 
        x = 200, 
        y = 200
    },
    margin = { 
        x = 0, 
        y = 20 
    }
}

local label_props = {
    widget = wibox.widget.textbox,
    align = "left",
    forced_width = 200, 
    forced_height = 40,
} 

local common_props = { 
    screen = s, 
    bg = gears.color.transparent, 
    visible = true, 
    type = "desktop", 
    width = label_props.width, 
    height = label_props.height,
} -- add x, y later

--[[ 
-- start adding stuff
-- final format:
--
--      welcome, <username> to <hostname>.
--      it is <hh:mm> on <dw, mn d, yyyy>
-
--      statistics:
--      load: <load>, mem: <mem>
--      net in: <##>, out: <##>
--      the battery is at <dd>
--      kbd lang: <lang>, 
--      volume: <vol>
--]]


user_name = os.execute("whoami")
sys_name  = os.execute("hostname")

welcome_props = label_props
welcome_props.text = string.format("welcome %s to %s", user_name, sys_name)
welcome_widget = wibox.widget(label_props)

welcome_container = wibox(common_props)
welcome_container:set_widget(welcome_widget)

return desktop
