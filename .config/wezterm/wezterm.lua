local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux
-- local keys = require("keys")

local config = {}
-- Use config builder object if possible
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- Settings
-- config.color_scheme = "iTerm2 Dark Background"
config.color_scheme = "Tokyo Night"
config.font = wezterm.font_with_fallback({
	{ family = "Hack Nerd Font Mono" },
})
-- config.window_background_opacity = 0.9
config.window_decorations = "RESIZE"
config.window_close_confirmation = "AlwaysPrompt"
config.scrollback_lines = 3000
config.default_workspace = "home"
config.font_size = 18

-- Dim inactive panes
config.inactive_pane_hsb = {
	saturation = 0.24,
	brightness = 0.5,
}

-- Keys
-- config.leader = { key = "e", mods = "CTRL", timeout_milliseconds = 1000 }
-- config.keys = keys

-- config.key_tables = {
-- 	resize_pane = {
-- 		{ key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },
-- 		{ key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },
-- 		{ key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },
-- 		{ key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },
-- 		{ key = "Escape", action = "PopKeyTable" },
-- 		{ key = "Enter", action = "PopKeyTable" },
-- 	},
-- 	move_tab = {
-- 		{ key = "h", action = act.MoveTabRelative(-1) },
-- 		{ key = "j", action = act.MoveTabRelative(-1) },
-- 		{ key = "k", action = act.MoveTabRelative(1) },
-- 		{ key = "l", action = act.MoveTabRelative(1) },
-- 		{ key = "Escape", action = "PopKeyTable" },
-- 		{ key = "Enter", action = "PopKeyTable" },
-- 	},
-- }

-- Tab bar
-- reference:
-- https://github.com/theopn/dotfiles/tree/25b85936ef3e7195a0f029525f854fdb915b9f90/wezterm
config.use_fancy_tab_bar = false
config.status_update_interval = 1000

wezterm.on("update-right-status", function(window, pane)
	local stat = window:active_workspace()
	if window:active_key_table() then
		stat = window:active_key_table()
	end
	if window:leader_is_active() then
		stat = "LDR"
	end
	local date = wezterm.strftime("%a %b %-d %H:%M ")

	window:set_right_status(wezterm.format({
		{
			Text = wezterm.nerdfonts.oct_table
				.. "  "
				.. stat
				.. " | "
				-- .. wezterm.nerdfonts.md_folder
				-- .. "  "
				-- .. string.gsub(pane:get_current_working_dir(), "(.*[/\\])(.*)", "%2")
				.. wezterm.nerdfonts.fa_code
				.. " "
				.. string.gsub(pane:get_foreground_process_name(), "(.*[/\\])(.*)", "%2")
				.. " | "
				.. wezterm.nerdfonts.fa_clock_o
				.. " "
				.. date
				.. "",
		},
	}))
end)

wezterm.on("gui-startup", function()
	local tab, pane, window = mux.spawn_window({})
	window:gui_window():maximize()
end)
return config
