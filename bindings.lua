--
--
--

local lain          = require("lain")
local awful         = require("awful")
local mytable       = awful.util.table or gears.table -- 4.{0,1} compatibility
local hotkeys_popup = require("awful.hotkeys_popup")
                      require("awful.hotkeys_popup.keys")
local naughty = require("naughty")
local revelation = require("revelation")
--local cyclefocus = require('cyclefocus')

local config  = require("config")
local menu    = require("menu")



local bindings = {}

bindings.mouse = mytable.join(
    awful.button({ }, 3, function () menu.mainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
)

bindings.globalkeys = mytable.join(

    -- System
    awful.key({ "Control" }, "space", function() naughty.destroy_all_notifications() end, {description = "destroy all notifications", group = "awesome"}),
    awful.key({ config.altkey }, "p", function() os.execute("screenshot") end, {description = "take a screenshot", group = "awesome"}),
    awful.key({ config.altkey, "Control" }, "l", function () os.execute(scrlocker) end, {description = "lock screen", group = "awesome"}),
    awful.key({ config.modkey }, "s", hotkeys_popup.show_help, {description="show help", group="awesome"}),
    awful.key({ config.modkey }, "w", function () menu.mainmenu:show() end, {description = "show main menu", group = "awesome"}),
    awful.key({ config.modkey, "Control" }, "r", awesome.restart, {description = "reload awesome", group = "awesome"}),
    awful.key({ config.modkey, "Shift" }, "q", awesome.quit, {description = "quit awesome", group = "awesome"}),
    awful.key({ config.modkey }, "h", function () -- Show/hide wibox
        for s in screen do
                s.mywibox.visible = not s.mywibox.visible
                if s.mybottomwibox then
                    s.mybottomwibox.visible = not s.mybottomwibox.visible
                end
            end
        end, {description = "toggle top bar", group = "awesome"}),

    -- Tag browsing
    awful.key({ config.modkey }, "Left",   awful.tag.viewprev, {description = "view previous", group = "tag"}),
    awful.key({ config.modkey }, "Right",  awful.tag.viewnext, {description = "view next", group = "tag"}),
    awful.key({ config.modkey }, "Escape", awful.tag.history.restore, {description = "go back", group = "tag"}),

    -- Dynamic tagging
    awful.key({ config.modkey, "Shift" }, "n", function () lain.util.add_tag() end, {description = "add new tag", group = "tag"}),
    awful.key({ config.modkey, "Shift" }, "r", function () lain.util.rename_tag() end, {description = "rename tag", group = "tag"}),
    awful.key({ config.modkey, "Shift" }, "Left", function () lain.util.move_tag(-1) end, {description = "move tag to the left", group = "tag"}),
    awful.key({ config.modkey, "Shift" }, "Right", function () lain.util.move_tag(1) end, {description = "move tag to the right", group = "tag"}),
    awful.key({ config.modkey, "Shift" }, "d", function () lain.util.delete_tag() end, {description = "delete tag", group = "tag"}),

    -- Clients
    awful.key({ config.modkey }, "e", revelation,{description = "revelation", group = "client"}),
    awful.key({ config.altkey }, "j", function () awful.client.focus.byidx(1) end, {description = "focus next by index", group = "client"}),
    awful.key({ config.altkey }, "k", function () awful.client.focus.byidx(-1) end, {description = "focus previous by index", group = "client"}),
    awful.key({ config.modkey }, "j",
        function()
            awful.client.focus.global_bydirection("down")
            if client.focus then client.focus:raise() end
        end, {description = "focus down", group = "client"}),
    awful.key({ config.modkey }, "k",
        function()
            awful.client.focus.global_bydirection("up")
            if client.focus then client.focus:raise() end
        end, {description = "focus up", group = "client"}),
    awful.key({ config.modkey }, "h",
        function()
            awful.client.focus.global_bydirection("left")
            if client.focus then client.focus:raise() end
        end, {description = "focus left", group = "client"}),
    awful.key({ config.modkey }, "l",
        function()
            awful.client.focus.global_bydirection("right")
            if client.focus then client.focus:raise() end
        end, {description = "focus right", group = "client"}),

    -- Layout manipulation
    awful.key({ config.modkey, "Shift" }, "j", function () awful.client.swap.byidx(  1) end, {description = "swap with next client by index", group = "client"}),
    awful.key({ config.modkey, "Shift" }, "k", function () awful.client.swap.byidx( -1) end, {description = "swap with previous client by index", group = "client"}),
    awful.key({ config.modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end, {description = "focus the next screen", group = "screen"}),
    awful.key({ config.modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end, {description = "focus the previous screen", group = "screen"}),
    awful.key({ config.modkey }, "u", awful.client.urgent.jumpto, {description = "jump to urgent client", group = "client"}),

    -- new layouts
    awful.key({ config.modkey }, "space", function () awful.layout.inc( 1) end, {description = "select next", group = "layout"}),
    awful.key({ config.modkey, "Shift" }, "space", function () awful.layout.inc(-1) end, {description = "select previous", group = "layout"}),

    -- Launchers
    awful.key({ config.modkey }, "Return", function () awful.spawn(config.terminal) end, {description = "open a terminal", group = "terminal"}),
    -- Copy primary to clipboard (terminals to gtk)
    awful.key({ config.modkey }, "c", function () awful.spawn.with_shell("xsel | xsel -i -b") end, {description = "copy terminal to gtk", group = "terminal"}),
    -- Copy clipboard to primary (gtk to terminals)
    awful.key({ config.modkey }, "v", function () awful.spawn.with_shell("xsel -b | xsel") end, {description = "copy gtk to terminal", group = "terminal"}),

    -- Screen brightness
    awful.key({ config.modkey }, "b", function () os.execute("brightnessctl s +10%") end, {description = "+10%", group = "hotkeys"}),
    awful.key({ config.modkey }, "d", function () os.execute("brightnessctl s 10%-") end, {description = "-10%", group = "hotkeys"}),

    -- ALSA volume control
    awful.key({ config.altkey, "Control" }, "Up",
        function ()
            os.execute(string.format("amixer -q set %s 1%%+", beautiful.volume.channel))
            beautiful.volume.update()
        end, {description = "volume up", group = "hotkeys"}),
    awful.key({ config.altkey, "Control" }, "Down",
        function ()
            os.execute(string.format("amixer -q set %s 1%%-", beautiful.volume.channel))
            beautiful.volume.update()
        end, {description = "volume down", group = "hotkeys"}),
    awful.key({ config.altkey, "Control" }, "m",
        function ()
            os.execute(string.format("amixer -q set %s 100%%", beautiful.volume.channel))
            beautiful.volume.update()
        end, {description = "volume 100%", group = "hotkeys"}),
    awful.key({ config.altkey, "Control" }, "0",
        function ()
            os.execute(string.format("amixer -q set %s 0%%", beautiful.volume.channel))
            beautiful.volume.update()
        end, {description = "volume 0%", group = "hotkeys"}),

    -- Prompt
    awful.key({ config.modkey }, "r", function () awful.screen.focused().mypromptbox:run() end, {description = "run prompt", group = "hotkeys"}))

bindings.clientkeys = mytable.join(
    awful.key({ config.altkey, "Shift" }, "m", lain.util.magnify_client, {description = "magnify client", group = "client"}),
    awful.key({ config.modkey }, "f", function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end, {description = "toggle fullscreen", group = "client"}),
    awful.key({ config.modkey, "Shift" }, "c", function (c) c:kill() end,{description = "close", group = "client"}),
    awful.key({ config.modkey, "Control" }, "space",  awful.client.floating.toggle, {description = "toggle floating", group = "client"}),
    awful.key({ config.modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end, {description = "move to master", group = "client"}),
    awful.key({ config.modkey }, "o", function (c) c:move_to_screen() end, {description = "move to screen", group = "client"}),
    awful.key({ config.modkey }, "t", function (c) c.ontop = not c.ontop end, {description = "toggle keep on top", group = "client"}),
    awful.key({ config.modkey }, "n", function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end, {description = "minimize", group = "client"}),
    awful.key({ config.modkey }, "m", function (c)
            c.maximized = not c.maximized
            c:raise()
        end, {description = "(un)maximize", group = "client"}),
    awful.key({ config.modkey, "Control" }, "m", function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end, {description = "(un)maximize vertically", group = "client"}),
    awful.key({ config.modkey, "Shift" }, "m", function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end, {description = "(un)maximize horizontally", group = "client"})
)

root.buttons(bindings.mouse)
globalkeys = bindings.globalkeys
clientkeys = bindings.clientkeys

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = mytable.join(globalkeys,
        -- View tag only.
        awful.key({ config.modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ config.modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ config.modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ config.modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = mytable.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ config.modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ config.modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)

return bindings
