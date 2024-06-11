local wezterm = require("wezterm")

local mux = wezterm.mux
-- local act = wezterm.action

wezterm.on("gui-startup", function()
	local tab, pane, window = mux.spawn_window({})
	window:gui_window():maximize()
end)

return {
	font_size = 18,
	-- font = wezterm.font("MonoLisa Nerd Font Mono"),
	scrollback_lines = 10000,
	font = wezterm.font_with_fallback({
		{ family = "Hack Nerd Font Mono" },
		-- { family = "FantasqueSansM Nerd Font", scale = 1.2 },
	}),
	-- leader = { key = "CMD", mods = "CTRL", timeout_milliseconds = 1000 },
}
