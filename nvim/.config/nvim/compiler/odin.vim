let current_compiler = 'odin'

CompilerSet makeprg=make

CompilerSet errorformat=[%f(%l:%c)]%m,%f(%l:%c)%m

" Clang with in source build
"CompilerSet errorformat=%E../../%f:%l:%c:%m
"CompilerSet errorformat+=%E../%f:%l:%c:%m

" GCC with absolute path
"CompilerSet errorformat+=%E%f:%l:%c:%m

