declare-option str      novo_build_dir "build"
declare-option str-list novo_run_args  "test/test.no" "-v" "-b" "&& ./a.out"
declare-option str-list novo_test_args ""

define-command -override novo-build %{
    write-all
    set global makecmd "meson compile -C %opt{novo_build_dir}"
    make
}

define-command -override novo-clean %{
    write-all
    set global makecmd "meson compile -C %opt{novo_build_dir} --clean"
    make
}

define-command -override novo-run %{
    write-all
    set global makecmd "%opt{novo_build_dir}/novo %opt{novo_run_args}"
    make
}

define-command -override novo-test %{
    write-all
    set global makecmd "meson test -C %opt{novo_build_dir} %opt{novo_test_args}"
    make
}

map global normal <F1> %{:novo-build<ret>} -docstring "Build novo"
map global normal <F2> %{:novo-clean<ret>} -docstring "Clean novo"
map global r      r    %{:novo-run<ret>}   -docstring "Run novo"
map global r      t    %{:novo-test<ret>}  -docstring "Test novo"
