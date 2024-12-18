local wezterm = require 'wezterm'

return {
    font_size = 13.5,
    font = wezterm.font('JetBrains Mono', {}),
    window_background_opacity = 0.95,

    initial_cols = 160,
    initial_rows = 45,

    color_scheme = 'tokyonight_night',
    colors = { background = '#1a1b26' },

    audible_bell = "Disabled",

    use_fancy_tab_bar = false,
    hide_tab_bar_if_only_one_tab = true,
    freetype_load_flags = "NO_HINTING",
    -- freetype_load_flags = "DEFAULT",
    freetype_load_target = "Light",
    -- freetype_load_target = "HorizontalLcd"
    freetype_render_target = "HorizontalLcd",

    enable_wayland = false
}
