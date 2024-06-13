local wezterm = require("wezterm")
local keys = require("keys")

local act = wezterm.action
local mux = wezterm.mux
-- local act = wezterm.action

-- wezterm.on("mux-startup", function()
-- 	local tab, pane, window = mux.spawn_window({})
-- 	window:gui_window():maximize()
-- end)
--
wezterm.on("gui-startup", function()
	local tab, pane, window = mux.spawn_window({})
	window:gui_window():maximize()
end)

-- wezterm.on("update-right-status", function(window, pane)
-- 	local name = window:active_key_table()
-- 	if name then
-- 		name = "TABLE: " .. name
-- 	end
-- 	window:set_right_status(name or "")
-- end)

local config = {
	font_size = 20,
	color_scheme = "iTerm2 Dark Background",
	-- color_scheme = "Night Owl (Gogh)",
	scrollback_lines = 10000,
	use_fancy_tab_bar = false,
	font = wezterm.font_with_fallback({
		{ family = "Hack Nerd Font Mono" },
	}),
	leader = { key = "e", mods = "CTRL", timeout_milliseconds = 1000 },
	keys = keys,
}

return config
