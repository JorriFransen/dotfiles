
evaluate-commands %sh{
  # We're assuming the default bundle_path here...
  plugins="$kak_config/bundle"
  mkdir -p "$plugins"
  [ ! -e "$plugins/kak-bundle" ] && \
    git clone -q https://github.com/jdugan6240/kak-bundle "$plugins/kak-bundle"
  printf "%s\n" "source '$plugins/kak-bundle/rc/kak-bundle.kak'"
}
bundle-noload kak-bundle https://github.com/jdugan6240/kak-bundle

bundle kakoune-palette 'https://github.com/Delapouite/kakoune-palette'
# bundle kak-ansi 'https://github.com/eraserhd/kak-ansi'
bundle active-window.kak 'https://github.com/greenfork/active-window.kak'
# bundle explain-shell.kak 'https://github.com/ath3/explain-shell.kak'

# bundle kakoune-smooth-scroll 'https://github.com/caksoylar/kakoune-smooth-scroll' %{
#     set-option global scroll_keys_normal <c-b> <c-d> <c-u> <pageup> <pagedown> ( ) m M <a-semicolon> <percent> n <a-n> N <a-N> u U
#     set-option global scroll_keys_goto g k j e .
#     set-option global scroll_keys_object B { } p i
#     hook global WinCreate [^*].* %{ hook -once window WinDisplay .* %{ smooth-scroll-enable } }
# }

# bundle auto-pairs.kak 'https://github.com/alexherbo2/auto-pairs.kak' %{
bundle auto-pairs.kak 'git clone -b user-mode-semicolon-fix https://github.com/jorrifransen/auto-pairs.kak' %{
    enable-auto-pairs
}

# bundle kakboard 'https://github.com/lePerdu/kakboard' %{
    # hook global WinCreate .* %{ kakboard-enable }
# }
