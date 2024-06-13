local wezterm = require("wezterm")

local act = wezterm.action

local cfg = {
	-- {
	-- 	key = "a",
	-- 	mods = "LEADER",
	-- 	action = act.ActivateKeyTable({
	-- 		name = "activate_pane",
	-- 		timeout_milliseconds = 1000,
	-- 	}),
	-- },
	-------------------------- PANES --------------------------
	-- copy mode
	{ key = "y", mods = "LEADER", action = wezterm.action.ActivateCopyMode },
	-- show command launcher pane
	{ key = "=", mods = "LEADER", action = wezterm.action.ShowLauncher },
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
		action = wezterm.action.SpawnCommandInNewTab({
			args = { "/opt/homebrew/bin/lazygit" },
		}),
	},
	-- {
	-- 	-- not working idkw
	-- 	key = "t",
	-- 	mods = "LEADER",
	-- 	-- action = wezterm.action.SpawnCommandInNewWindow({
	-- 	action = wezterm.action.SpawnCommandInNewTab({
	-- 		args = { "/opt/homebrew/bin/taskwarrior-tui" },
	-- 	}),
	-- },
	{
		key = "q",
		mods = "LEADER",
		action = wezterm.action.SpawnCommandInNewTab({
			args = { "/opt/homebrew/bin/nnn" },
		}),
	},
	{
		key = "i",
		mods = "LEADER",
		action = wezterm.action.SpawnCommandInNewTab({
			args = { "/opt/homebrew/bin/lazydocker" },
		}),
	},
	{
		key = ";",
		mods = "LEADER",
		action = wezterm.action.SpawnCommandInNewTab({
			args = { "/opt/homebrew/bin/gh", "dash" },
		}),
	},
	{
		key = "b",
		mods = "LEADER",
		action = wezterm.action.SpawnCommandInNewWindow({
			args = { "/opt/homebrew/bin/htop" },
		}),
	},
	{
		-- TODO: try to add a callback function to spawn
		-- it in fullscreen
		key = "b",
		mods = "LEADER",
		action = wezterm.action.SpawnCommandInNewWindow({
			args = { "ping", "www.google.com" },
			-- position = {
			-- 	x = 500,
			-- 	y = 300,
			-- 	-- origin = "ScreenCoordinateSystem",
			-- },
		}),
	},
	-------------------------- WORKSPACES --------------------------
	-- {
	-- 	key = "=",
	-- 	mods = "LEADER",
	-- 	action = act.ShowLauncherArgs({
	-- 		flags = "LAUNCH_MENU_ITEMS",
	-- 	}),
	-- },
	{
		key = "w",
		mods = "LEADER",
		action = act.ShowLauncherArgs({
			flags = "FUZZY|WORKSPACES",
		}),
	},
	-- The wezterm.action.ShowTabNavigator is an alternative to ShowLauncherArgs
	-- But I don't like it
	-- { key = "s", mods = "LEADER", action = wezterm.action.ShowTabNavigator },
	{
		key = "s",
		mods = "LEADER",
		action = act.ShowLauncherArgs({
			flags = "FUZZY|TABS",
		}),
	},
	{
		key = "a",
		mods = "LEADER",
		action = act.SwitchToWorkspace({
			name = "scratchpad",
		}),
	},
	{
		key = "u",
		mods = "CTRL|SHIFT",
		action = act.SwitchToWorkspace({
			name = "monitoring",
			spawn = {
				args = { "top" },
			},
		}),
	},
	-- {
	-- --already exists with CMD+t
	-- 	key = "t",
	-- 	mods = "LEADER",
	-- 	action = act.SpawnTab("CurrentPaneDomain"),
	-- },
}

-- -- use leader + number to switch panes
for i = 1, 9 do
	table.insert(cfg, {
		key = tostring(i),
		mods = "LEADER",
		action = act.ActivateTab(i - 1),
	})
end

return cfg
