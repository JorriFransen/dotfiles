local config = wezterm.config_builder();

return {
    color_scheme = 'tokyonight_night',
    colors = { background = '#1a1b26' },
    window_background_opacity = 0.95,
    -- font = wezterm.font('Hack'),

    use_fancy_tab_bar = false,
    hide_tab_bar_if_only_one_tab = true,
    freetype_load_flags = "NO_HINTING",
    -- freetype_load_flags = "DEFAULT",
    freetype_load_target = "Light",
    -- freetype_load_target = "HorizontalLcd"
    freetype_render_target = "HorizontalLcd",

    -- This makes fullscreen work on wayland...
    enable_wayland = false
}
