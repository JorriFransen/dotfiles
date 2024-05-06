
hook global BufCreate .*\.(no) %{ set-option buffer filetype novo }


hook global WinSetOption filetype=novo %{
    require-module novo

    set-option window comment_line '// '
    set-option window static_words %opt{novo_static_words}

    hook -once -always window WinSetOption filetype=.* %{ remove-hooks window novo-.+ }
}

hook -group novo-highlight global WinSetOption filetype=novo %{
    add-highlighter window/novo ref novo
    hook -once -always window WinSetOption filetype=.* %{ remove-highlighter window/novo }
}

provide-module novo %§

# Highlighters
add-highlighter shared/novo regions
add-highlighter shared/novo/code default-region group
add-highlighter shared/novo/string region %{(?<!')(?<!'\\)"} %{(?<!\\)(?:\\\\)*"} fill string
add-highlighter shared/novo/char region %{'} %{'} fill string
add-highlighter shared/novo/comment region %{//} $ fill comment

add-highlighter shared/novo/code/ regex "#" 0:meta
add-highlighter shared/novo/code/ regex "-?([0-9_]*\.(?!0[xXbB]))?\b([0-9_]+|0[xX][0-9a-fA-F_]*\.?[0-9a-fA-F_]+|0[bb][01_]+)([ep]-?[0-9_]+)?[fFlLuUi]*\b" 0:value

evaluate-commands %sh{
    keywords="return|if|else|for|while|break|continue"
    directives="foreign"
    types="void|bool|string|cstring|cchar|u8|u16|u32|u64|s8|s16|s32|s64|int|r32|r64"
    values="true|false|null"

    printf %s\\n "declare-option str-list novo_static_words ${keywords} ${directives} ${types} ${values}" | tr '|' ' '

    printf %s  "
        add-highlighter shared/novo/code/ regex \b(${keywords})\b 0:keyword
        add-highlighter shared/novo/code/ regex \b(${directives})\b 0:meta
        add-highlighter shared/novo/code/ regex \b(${types})\b 0:type
        add-highlighter shared/novo/code/ regex \b(${values})\b 0:value
    "
}

§
