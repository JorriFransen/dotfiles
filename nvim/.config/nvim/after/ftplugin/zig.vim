"    macros: /home/jason/src/my-language/src/main.zig:218:20
set efm=\ \ \ \ %m:\ %f:%l:%c

"/home/jason/src/my-language/src/main.zig:359:22: error: unable to resolve inferred error set
set efm+=%f:%l:%c:\ %t%*[^:]:\ %m

set efm+=%f:%l:%c:\ %m

" /home/jorri/dev/v10/shaders/simple.vert:19: error: 'constructor' : too many arguments
set efm+=%f:%l:\ %m

"[matches anything]
set efm+=%C%m
