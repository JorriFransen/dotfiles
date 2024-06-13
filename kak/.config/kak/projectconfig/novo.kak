declare-option str      novo_build_dir     "build"
declare-option str-list novo_run_args      "../tests/test.no" "-v" "-k"
declare-option str      novo_run_args_post "&& ./test"
declare-option str-list novo_test_args     ""

define-command -override novo-build %{
    write-all
    set global runcmd "meson compile -C %opt{novo_build_dir}"
    run
}

define-command -override novo-clean %{
    write-all
    set global runcmd "meson compile -C %opt{novo_build_dir} --clean"
    run
}

define-command -override novo-run %{
    write-all
    set global runcmd "cd %opt{novo_build_dir} && ./novo %opt{novo_run_args} %opt{novo_run_args_post}"
    run
}

define-command -override novo-test %{
    write-all
    set global runcmd "meson test -C %opt{novo_build_dir} %opt{novo_test_args}"
    run
}

map global normal <F1> %{:novo-build<ret>} -docstring "Build novo"
map global normal <F2> %{:novo-clean<ret>} -docstring "Clean novo"
map global r      r    %{:novo-run<ret>}   -docstring "Run novo"
map global r      t    %{:novo-test<ret>}  -docstring "Test novo"
