local function cmd(_cmd)
   vim.cmd.wa()
   vim.cmd("botright copen")
   vim.cmd("AsyncRun " .. _cmd)
end

local function in_map(key, fn)
   vim.keymap.set('i', key, fn);
   vim.keymap.set('n', key, fn);
end
local function n_map(key, fn)
   vim.keymap.set('n', key, fn);
end

local common_options = " "
function Default_Common_Options() common_options = " -Dglfw_window_api=x11 " end
function Set_Common_Options()
   vim.ui.input({prompt = "common_options=", default=common_options},
                  function(input) common_options = input end)
end

Default_Common_Options()

in_map('<F1>', function() cmd("zig build" .. common_options .. " run") end);
in_map('<F2>', function() cmd("zig build" .. common_options .. " clean") end);
-- in_map('<F3>', Build_And_Test);
in_map('<F4>', function() vim.cmd('AsyncStop') end);
n_map('<leader>cbe', Set_Common_Options);
n_map('<leader>cbd', Default_Common_Options);

-- vim.api.nvim_create_autocmd("BufWritePost", { pattern = '*.zig', command = 'silent !zig fmt <afile>'})

