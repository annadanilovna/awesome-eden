--
-- awesome wm config
-- abstracted out to several smaller files to make the whole process a bit
-- less daunting
--
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

require("config")    -- configuration variables
require("menu")      -- app menu
require("startup")   -- startup tasks
require("screen")    -- screen & theme initialization
require("bindings")  -- keyboard and mouse bindings
require("rules")     -- rules
require("signals")   -- signals
require("titlebar")  -- application titlebar
