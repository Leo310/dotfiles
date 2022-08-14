RC={} -- global namespace, on top before require any modules
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

require("main.error-handling")

RC.vars = require("main.user-variables")
modkey = RC.vars.modekey

local main = {
	layouts = require("main.layouts"),
	tags = require("main.tags"),
	menu = require("main.menu"),
	rules = require("main.rules")
}

RC.layouts = main.layouts()
RC.tags = main.tags()
RC.mainmenu = awful.menu({items = main.menu()})
RC.launcher = awful.widget.launcher({image = beautiful.awesome_icon, menu = RC.mainmenu})

-- Custom Local Library: Keys and Mouse Binding
local binding = {
  globalbuttons = require("binding.globalbuttons"),
  clientbuttons = require("binding.clientbuttons"),
  globalkeys    = require("binding.globalkeys"),
  bindtotags    = require("binding.bindtotags"),
  clientkeys    = require("binding.clientkeys")
}
-- Mouse and Key bindings
RC.globalkeys = binding.globalkeys()
RC.globalkeys = binding.bindtotags(RC.globalkeys)

-- Set root
root.buttons(binding.globalbuttons())
root.keys(RC.globalkeys)

awful.rules.rules = main.rules(binding.clientkeys(), binding.clientbuttons())

require("main.signals")

-- Themes define colours, icons, font and wallpapers.
beautiful.init("/home/leo/.config/awesome/theme.lua")

require("deco.statusbar")
--
--
-- My Shiet
awful.util.spawn("picom -b")
