local wezterm = require("wezterm")

local mux = wezterm.mux
-- local act = wezterm.action

wezterm.on("gui-startup", function()
	local tab, pane, window = mux.spawn_window({})
	window:gui_window():maximize()
end)

return {
	font_size = 20,
	color_scheme = "iTerm2 Dark Background",
	-- color_scheme = "Night Owl (Gogh)",
	scrollback_lines = 10000,
	use_fancy_tab_bar = false,
	font = wezterm.font_with_fallback({
		{ family = "Hack Nerd Font Mono" },
	}),
	leader = { key = "e", mods = "CTRL", timeout_milliseconds = 1000 },
	keys = {
		-- copy mode
		-------------------------- PANES --------------------------
		{ key = "y", mods = "LEADER", action = wezterm.action.ActivateCopyMode },
		-- split panes
		{
			key = "-",
			mods = "LEADER",
			action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "|",
			mods = "LEADER",
			action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		-- maximize pane
		{
			key = "m",
			mods = "LEADER",
			action = wezterm.action.TogglePaneZoomState,
		},
		-- switch panes
		{ key = "h", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Left") },
		{ key = "j", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Down") },
		{ key = "k", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Up") },
		{ key = "l", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Right") },
		{ key = "x", mods = "LEADER", action = wezterm.action.CloseCurrentPane({ confirm = true }) },
}
