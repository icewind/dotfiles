local wezterm = require("wezterm")

local config = wezterm.config_builder()

local is_windows <const> = wezterm.target_triple:find("windows") ~= nil
local is_macos <const> = wezterm.target_triple:find("darwin") ~= nil

if is_windows then
	-- config.default_prog = { "pwsh.exe", "-NoLogo" }
	config.default_domain = "WSL:Ubuntu"
end

config.front_end = "WebGpu"

-- Appearance

config.font = wezterm.font("FiraCode Nerd Font")
config.color_scheme = "Gruvbox dark, pale (base16)"
config.enable_scroll_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = true
config.enable_kitty_keyboard = true
config.allow_win32_input_mode = false

if is_macos then
	config.font_size = 16
end

-- Kanso mist theme
config.force_reverse_video_cursor = true
config.colors = {
	foreground = "#C5C9C7",
	background = "#22262D",

	cursor_bg = "#C5C9C7",
	cursor_fg = "#22262D",
	cursor_border = "#C5C9C7",

	selection_fg = "#C5C9C7",
	selection_bg = "#43464E",

	scrollbar_thumb = "#43464E",
	split = "#43464E",

	ansi = {
		"#22262D",
		"#C4746E",
		"#8A9A7B",
		"#C4B28A",
		"#8BA4B0",
		"#A292A3",
		"#8EA4A2",
		"#a4a7a4",
	},
	brights = {
		"#5C6066",
		"#E46876",
		"#87A987",
		"#E6C384",
		"#7FB4CA",
		"#938AA9",
		"#7AA89F",
		"#C5C9C7",
	},
}

-- Key bindings

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1500 }

config.keys = {
	{
		key = "x",
		mods = "CTRL|SHIFT",
		action = wezterm.action.CloseCurrentPane({ confirm = false }),
	},
	{
		key = "k",
		mods = "CTRL|SHIFT",
		action = wezterm.action.Multiple({
			wezterm.action.ClearScrollback("ScrollbackAndViewport"),
			wezterm.action.SendKey({ key = "L", mods = "CTRL" }),
		}),
	},
	-- Disable debug overlay
	{
		key = "L",
		mods = "CTRL",
		action = wezterm.action.DisableDefaultAssignment,
	},
}

return config
