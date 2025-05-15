local wezterm = require("wezterm")

local config = wezterm.config_builder()

local is_windows <const> = wezterm.target_triple:find("windows") ~= nil
local is_macos <const> = wezterm.target_triple:find("darwin") ~= nil

if is_windows then
	-- config.default_prog = { "pwsh.exe", "-NoLogo" }
	config.default_domain = "WSL:Ubuntu"
end

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
