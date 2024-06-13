local wezterm = require("wezterm")

local mux = wezterm.mux
-- local act = wezterm.action

wezterm.on("gui-startup", function()
	local tab, pane, window = mux.spawn_window({})
	window:gui_window():maximize()
end)

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
		-- spawn menu
		{
			key = "g",
			mods = "LEADER",
			-- action = wezterm.action.SpawnCommandInNewWindow({
			action = wezterm.action.SpawnCommandInNewTab({
				args = { "/opt/homebrew/bin/lazygit" },
			}),
		},
		{
			key = "t",
			mods = "LEADER",
			-- action = wezterm.action.SpawnCommandInNewWindow({
			action = wezterm.action.SpawnCommandInNewTab({
				args = { "/opt/homebrew/bin/taskwarrior-tui" },
			}),
		},
		{
			key = "q",
			mods = "LEADER",
			-- action = wezterm.action.SpawnCommandInNewWindow({
			action = wezterm.action.SpawnCommandInNewTab({
				args = { "/opt/homebrew/bin/nnn" },
			}),
		},
		{
			key = "i",
			mods = "LEADER",
			-- action = wezterm.action.SpawnCommandInNewWindow({
			action = wezterm.action.SpawnCommandInNewTab({
				args = { "/opt/homebrew/bin/lazydocker" },
			}),
		},
		{
			key = ";",
			mods = "LEADER",
			-- action = wezterm.action.SpawnCommandInNewWindow({
			action = wezterm.action.SpawnCommandInNewTab({
				args = { "/opt/homebrew/bin/gh", "dash" },
			}),
		},
		{
			key = "b",
			mods = "LEADER",
			-- action = wezterm.action.SpawnCommandInNewWindow({
			action = wezterm.action.SpawnCommandInNewWindow({
				args = { "/opt/homebrew/bin/htop" },
			}),
		},
		{
			-- TODO: try to add a callback function to spawn
			-- it in fullscreen
			key = "b",
			mods = "LEADER",
			-- action = wezterm.action.SpawnCommandInNewWindow({
			action = wezterm.action.SpawnCommandInNewWindow({
				args = { "ping", "www.google.com" },
				position = {
					x = 500,
					y = 300,
				},
			}),
		},
	},
}

return config
