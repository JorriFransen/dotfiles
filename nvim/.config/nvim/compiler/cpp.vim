let current_compiler = 'cpp'

CompilerSet makeprg=./.build.sh

" Clang with in source build
CompilerSet errorformat=%E../../%f:%l:%c:%m
CompilerSet errorformat+=%E../%f:%l:%c:%m

" GCC with absolute path
CompilerSet errorformat+=%E%f:%l:%c:%m

