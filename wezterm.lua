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

	-- Pane navigation without prefix (tmux: Alt + arrows)
	{
		key = "LeftArrow",
		mods = "ALT",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "RightArrow",
		mods = "ALT",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		key = "UpArrow",
		mods = "ALT",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		key = "DownArrow",
		mods = "ALT",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},

	-- Tab navigation without prefix (tmux: Ctrl+Shift + arrows)
	{
		key = "LeftArrow",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	{
		key = "RightArrow",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivateTabRelative(1),
	},

	-- Send prefix when leader pressed twice (tmux: bind C-a send-prefix)
	{
		key = "a",
		mods = "LEADER|CTRL",
		action = wezterm.action.SendKey({ key = "a", mods = "CTRL" }),
	},

	-- Splits, inherit current pane cwd (tmux: " = down, % = right)
	-- SHIFT required because " and % are Shift+' / Shift+5
	{
		key = '"',
		mods = "LEADER|SHIFT",
		action = wezterm.action.SplitPane({ direction = "Down" }),
	},
	{
		key = "%",
		mods = "LEADER|SHIFT",
		action = wezterm.action.SplitPane({ direction = "Right" }),
	},

	-- Tab management under leader (tmux defaults)
	{
		key = "c",
		mods = "LEADER",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "n",
		mods = "LEADER",
		action = wezterm.action.ActivateTabRelative(1),
	},
	{
		key = "p",
		mods = "LEADER",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	{
		key = "&",
		mods = "LEADER",
		action = wezterm.action.CloseCurrentTab({ confirm = true }),
	},

	-- Pane management under leader (tmux defaults)
	{
		key = "x",
		mods = "LEADER",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
	{
		key = "z",
		mods = "LEADER",
		action = wezterm.action.TogglePaneZoomState,
	},
	{
		key = "LeftArrow",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "RightArrow",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		key = "UpArrow",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		key = "DownArrow",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
}

-- Select tab by index (tmux: leader + 1..9, base-index 1)
for i = 1, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = wezterm.action.ActivateTab(i - 1),
	})
end

return config
