
-- local wezterm = require 'wezterm'

local config = wezterm.config_builder();

config.color_scheme = 'tokyonight_night'
config.colors = { background = '#1a1b26' }
config.window_background_opacity = 0.95
-- config.font = wezterm.font('Hack')

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.freetype_load_flags = "NO_HINTING"
-- config.freetype_load_flags = "DEFAULT"
config.freetype_load_target = "Light"
-- config.freetype_load_target = "HorizontalLcd"
config.freetype_render_target = "HorizontalLcd"



return config
