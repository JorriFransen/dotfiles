"    macros: /home/jason/src/my-language/src/main.zig:218:20
set efm=\ \ \ \ %m:\ %f:%l:%c

"/home/jason/src/my-language/src/main.zig:359:22: error: unable to resolve inferred error set
set efm+=%f:%l:%c:\ %t%.%#:\ %m

"[matches anything]
set efm+=%C%m
