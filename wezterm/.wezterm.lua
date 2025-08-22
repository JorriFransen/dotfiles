local wezterm = require 'wezterm'
local mux = wezterm.mux
local act = wezterm.action;
local config = wezterm.config_builder()

config.enable_csi_u_key_encoding = true

config.font_size = 14.5
config.font = wezterm.font_with_fallback {
    'IBM Plex Mono',
    'Cascadia Code',
    'Zenbones Mono',
    'JetBrains Mono',
    'Noto Color Emoji',
    'DengXian',
}
-- config.window_background_opacity = 0.95

-- config.initial_cols = 80
-- config.initial_rows = 24
config.initial_cols = 120
config.initial_rows = 35


local cs_filename = os.getenv("XDG_CONFIG_HOME").."/wezterm/colorscheme"
assert(cs_filename)
wezterm.add_to_config_reload_watch_list(cs_filename)
local file = io.open(cs_filename, "r")
-- wezterm.log_error("cs file: " .. cs_filename)
if file then
    local scheme = file:read("*a");
    config.color_scheme = scheme
    -- wezterm.log_error("Read colorscheme: '" .. scheme .. "'")
    file:close()
else
    config.color_scheme = "tokyonight_night"
end

config.audible_bell = "Disabled"

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.freetype_load_flags = "NO_HINTING"
-- freetype_load_flags = "DEFAULT"
config.freetype_load_target = "Light"
-- freetype_load_target = "HorizontalLcd
config.freetype_render_target = "HorizontalLcd"

config.enable_wayland = false


config.pane_focus_follows_mouse = true
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }

-- config.unix_domains = { { name = "unix", }, }
config.default_gui_startup_args = {}

wezterm.on("update-right-status", function(window, _) window:set_right_status(window:active_workspace()) end)

-- config.leader = { key = ' ', mods = 'ALT', timeout_milliseconds = 2000, }
config.keys = {

    -- { key = '\\', mods = 'LEADER', action = act.SplitPane { direction = 'Right', size = { Percent = 50 }}},
    -- { key = '-', mods = 'LEADER', action = act.SplitPane { direction = 'Down', size = { Percent = 50 }}},
    --
    -- { key = ';', mods = 'LEADER', action = act.ActivatePaneDirection("Prev") },
    -- { key = 'o', mods = 'LEADER', action = act.ActivatePaneDirection("Next") },

}

return config
