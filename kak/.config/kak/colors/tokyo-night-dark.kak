# palette

declare-option str tokyo_bg_dark 'rgb:16161e'
declare-option str tokyo_bg 'rgb:1a1b26'
declare-option str tokyo_bg_highlight 'rgb:292e42'
declare-option str tokyo_terminal_black 'rgb:414868'
declare-option str tokyo_fg 'rgb:c0caf5'
declare-option str tokyo_fg_dark 'rgb:a9b1d6'
declare-option str tokyo_fg_gutter 'rgb:3b4261'
declare-option str tokyo_dark3 'rgb:545c7e'
declare-option str tokyo_comment 'rgb:565f89'
declare-option str tokyo_dark5 'rgb:737aa2'
declare-option str tokyo_blue0 'rgb:3d59a1'
declare-option str tokyo_blue 'rgb:7aa2f7'
declare-option str tokyo_cyan 'rgb:7dcfff'
declare-option str tokyo_blue1 'rgb:2ac3de'
declare-option str tokyo_blue2 'rgb:0db9d7'
declare-option str tokyo_blue5 'rgb:89ddff'
declare-option str tokyo_blue6 'rgb:b4f9f8'
declare-option str tokyo_blue7 'rgb:394b70'
declare-option str tokyo_magenta 'rgb:bb9af7'
declare-option str tokyo_magenta2 'rgb:ff007c'
declare-option str tokyo_purple 'rgb:9d7cd8'
declare-option str tokyo_orange 'rgb:ff9e64'
declare-option str tokyo_yellow 'rgb:e0af68'
declare-option str tokyo_green 'rgb:9ece6a'
declare-option str tokyo_green1 'rgb:73daca'
declare-option str tokyo_green2 'rgb:41a6b5'
declare-option str tokyo_teal 'rgb:1abc9c'
declare-option str tokyo_red 'rgb:f7768e'
declare-option str tokyo_red1 'rgb:db4b4b'

# code

set-face global value "%opt{tokyo_orange}"
set-face global type "%opt{tokyo_blue1}"
set-face global variable "%opt{tokyo_fg}"
set-face global module "%opt{tokyo_green}"
set-face global function "%opt{tokyo_blue1}"
set-face global identifier "%opt{tokyo_magenta}"
set-face global string "%opt{tokyo_green}"
set-face global error "%opt{tokyo_fg}"
set-face global keyword "%opt{tokyo_magenta}"
set-face global operator "%opt{tokyo_fg_dark}"
set-face global attribute "%opt{tokyo_orange}"
set-face global bracket "%opt{tokyo_fg_dark}+b"
set-face global arguement "%opt{tokyo_fg_dark}"
set-face global comma "%opt{tokyo_fg_dark}"
set-face global constant "%opt{tokyo_fg_dark}+b"
set-face global comment "%opt{tokyo_comment}+i"
set-face global documentation "%opt{tokyo_comment}+i"
set-face global docstring "%opt{tokyo_comment}+i"
set-face global docstring "%opt{tokyo_blue2}"
set-face global meta "%opt{tokyo_cyan}"
set-face global builtin "%opt{tokyo_blue6}+b"

# text

set-face global title "%opt{tokyo_magenta}"
set-face global header "%opt{tokyo_blue1}"
set-face global bold "%opt{tokyo_magenta}"
set-face global italic "%opt{tokyo_magenta}"
set-face global mono "%opt{tokyo_green}"
set-face global block "%opt{tokyo_blue1}"
set-face global link "%opt{tokyo_green}"
set-face global bullet "%opt{tokyo_green}"
set-face global list "%opt{tokyo_fg_dark}"

# kakoune UI

set-face global Default "%opt{tokyo_fg_dark},%opt{tokyo_bg}"
set-face global PrimarySelection "%opt{tokyo_bg},%opt{tokyo_blue2}"
set-face global SecondarySelection "%opt{tokyo_comment},%opt{tokyo_blue2}"
set-face global PrimaryCursor "%opt{tokyo_bg},%opt{tokyo_fg_dark}"
set-face global SecondaryCursor "%opt{tokyo_bg},%opt{tokyo_blue6}"
set-face global PrimaryCursorEol "%opt{tokyo_bg},%opt{tokyo_blue2}"
set-face global SecondaryCursorEol "%opt{tokyo_bg},%opt{tokyo_blue1}"
set-face global LineNumbers "%opt{tokyo_dark5},%opt{tokyo_bg}"
set-face global LineNumberCursor "%opt{tokyo_blue2},%opt{tokyo_bg}+b"
set-face global LineNumbersWrapped "%opt{tokyo_dark5},%opt{tokyo_bg}+i"
set-face global MenuForeground "%opt{tokyo_bg_dark},%opt{tokyo_blue}+b"
set-face global MenuBackground "%opt{tokyo_blue},%opt{tokyo_bg_dark}"
set-face global MenuInfo "%opt{tokyo_blue1},%opt{tokyo_bg_dark}"
set-face global Information "%opt{tokyo_fg},%opt{tokyo_bg_highlight}"
set-face global Error "%opt{tokyo_red},%opt{tokyo_bg_dark}"
set-face global DiagnosticError "%opt{tokyo_fg}"
set-face global DiagnosticWarning "%opt{tokyo_blue2}"
set-face global StatusLine "%opt{tokyo_blue},%opt{tokyo_bg_dark}"
set-face global StatusLineMode "%opt{tokyo_fg},%opt{tokyo_fg_gutter}+b"
set-face global StatusLineInfo "%opt{tokyo_blue},%opt{tokyo_fg_gutter}"
set-face global StatusLineValue "%opt{tokyo_fg},%opt{tokyo_fg_gutter}"
set-face global StatusCursor "%opt{tokyo_bg_highlight},%opt{tokyo_fg_dark}"
set-face global Prompt StatusLine
set-face global MatchingChar "%opt{tokyo_blue1},%opt{tokyo_bg}"
set-face global Whitespace "%opt{tokyo_bg_dark},%opt{tokyo_bg}+f"
set-face global WrapMarker Whitespace
set-face global BufferPadding "%opt{tokyo_dark5},%opt{tokyo_bg}"
set-face global Search "%opt{tokyo_fg_dark},%opt{tokyo_bg_dark}"

# kak-lsp
set-face global InlayHint "+d@type"
# set-face global parameter "+i@variable"
set-face global parameter "%opt{tokyo_orange}"
set-face global enum "%opt{tokyo_red}"
set-face global InlayDiagnosticError "%opt{tokyo_red}"
set-face global InlayDiagnosticWarning "%opt{tokyo_red}"
set-face global InlayDiagnosticInfo "%opt{tokyo_red}"
set-face global InlayDiagnosticHint "%opt{tokyo_red}"
set-face global LineFlagError "%opt{tokyo_red}"
set-face global LineFlagWarning "%opt{tokyo_red}"
set-face global LineFlagInfo "%opt{tokyo_red}"
set-face global LineFlagHint "%opt{tokyo_red}"
set-face global DiagnosticError ",,%opt{tokyo_red}+c"
set-face global DiagnosticWarning ",,%opt{tokyo_red}+c"
set-face global DiagnosticInfo ",,%opt{tokyo_red}+c"
set-face global DiagnosticHint ",,%opt{tokyo_red}+c"

face global hlsearch "default,%opt{tokyo_fg_gutter}@Default"
face global cursorline "default,%opt{tokyo_bg_dark}"

face global namespace "%opt{tokyo_cyan}"
face global function "%opt{tokyo_blue}"
face global property "%opt{tokyo_green1}"
face global enumMember "%opt{tokyo_orange}"


