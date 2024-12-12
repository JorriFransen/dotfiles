local function cmd(_cmd)
   vim.cmd.wa()
   vim.cmd("botright copen")
   vim.cmd("AsyncRun " .. _cmd)
end

local function in_map(key, fn)
   vim.keymap.set('i', key, fn)
   vim.keymap.set('n', key, fn)
end
local function n_map(key, fn)
   vim.keymap.set('n', key, fn)
end

local build_options = " "
function Default_Build_Options() build_options = " -Dvulkan_verbose=true " end
function Set_Build_Options()
   vim.ui.input({prompt = "build_options=", default=string.sub(build_options, 2, string.len(build_options) - 1)},
      function(input) if input then build_options = " " .. input .. " " end end)
end
Default_Build_Options()

local run_options = " "
function Default_Run_Options() run_options = " --glfw-window-api x11 " end
function Set_Run_Options()
   vim.ui.input({prompt = "run_options=", default=string.sub(run_options, 2, string.len(run_options) - 1)},
      function(input) if input then run_options = " " .. input .. " " end end)
end
Default_Run_Options()

in_map('<F1>', function() cmd("zig build" .. build_options .. "run --" .. run_options) end)
in_map('<F2>', function() cmd("zig build" .. build_options .. "clean") end)
-- in_map('<F3>', Build_And_Test)
in_map('<F4>', function() vim.cmd('AsyncStop') end)

n_map('<leader>sbo', Set_Build_Options)
n_map('<leader>dbo', Default_Build_Options)

n_map('<leader>sro', Set_Run_Options)
n_map('<leader>dro', Default_Run_Options)

vim.api.nvim_create_autocmd("BufWritePost", { pattern = '*.zig', command = 'silent !zig fmt <afile>'})

