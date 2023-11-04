-- Pull in the wezterm API
local wezterm = require("wezterm")
-- local nvim_integration = require("nvim-integration") only required without using tmux

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- wezterm.gui is not available to the mux server, so take care to
-- do something reasonable when this config is evaluated by the mux
local function get_appearance()
	if wezterm.gui then
		return wezterm.gui.get_appearance()
	end
	return "Dark"
end

if get_appearance():find("Dark") then
	config.color_scheme = "Dracula"
else
	config.color_scheme = "Edge Light (base16)"
	-- config.color_scheme = "Dracula"
end

config.font = wezterm.font("Fira Code")

-- config.keys = nvim_integration.keys

config.window_background_opacity = 0.8
config.macos_window_background_blur = 20
-- config.disable_default_key_bindings = true
config.keys = {
	{ key = "f", mods = "CMD", action = wezterm.action({ SendString = "\x02f" }) },
	{ key = "u", mods = "CMD", action = wezterm.action({ SendString = '\x02"' }) },
	{ key = "o", mods = "CMD", action = wezterm.action({ SendString = "\x02%" }) },
	{ key = "f", mods = "CMD", action = wezterm.action({ SendString = "\x02f" }) },
	{ key = "f", mods = "CMD|SHIFT", action = wezterm.action({ SendString = "\x03\x5b\x2f" }) },
	{ key = "g", mods = "CMD", action = wezterm.action({ SendString = "\x02g" }) },
	{ key = "j", mods = "CMD", action = wezterm.action({ SendString = "\x02\x54" }) },
	{ key = "k", mods = "CMD", action = wezterm.action({ SendString = "\x02s" }) },
	{ key = "l", mods = "CMD", action = wezterm.action({ SendString = "\x02L" }) },
	{ key = "s", mods = "CMD", action = wezterm.action({ SendString = "\x1b\x3a\x77\x0a" }) },
	{ key = "t", mods = "CMD", action = wezterm.action({ SendString = "\x02c" }) },
	{ key = "w", mods = "CMD", action = wezterm.action({ SendString = "\x02x" }) },
	{ key = "z", mods = "CMD", action = wezterm.action({ SendString = "\x02z" }) },
	{ key = "Tab", mods = "CTRL", action = wezterm.action({ SendString = "\x02n" }) },
	{ key = "Grave", mods = "CTRL", action = wezterm.action({ SendString = "\x02p" }) },
	{ key = "Comma", mods = "CMD", action = wezterm.action({ SendString = "\x02," }) },
	{ key = "Period", mods = "CMD", action = wezterm.action({ SendString = "\x02:" }) },
	{ key = "1", mods = "CMD", action = wezterm.action({ SendString = "\x021" }) },
	{ key = "2", mods = "CMD", action = wezterm.action({ SendString = "\x022" }) },
	{ key = "3", mods = "CMD", action = wezterm.action({ SendString = "\x023" }) },
	{ key = "4", mods = "CMD", action = wezterm.action({ SendString = "\x024" }) },
	{ key = "5", mods = "CMD", action = wezterm.action({ SendString = "\x025" }) },
	{ key = "6", mods = "CMD", action = wezterm.action({ SendString = "\x026" }) },
	{ key = "7", mods = "CMD", action = wezterm.action({ SendString = "\x027" }) },
	{ key = "8", mods = "CMD", action = wezterm.action({ SendString = "\x028" }) },
	{ key = "9", mods = "CMD", action = wezterm.action({ SendString = "\x029" }) },
}

local tmux = {}
if wezterm.target_triple == "aarch64-apple-darwin" then
	tmux = { "/opt/homebrew/bin/tmux", "new", "-As0" }
else
	tmux = { "tmux", "new", "-As0" }
end

config.default_prog = tmux

config.hide_tab_bar_if_only_one_tab = true

-- This is where you actually apply your config choices

-- and finally, return the configuration to wezterm
return config
