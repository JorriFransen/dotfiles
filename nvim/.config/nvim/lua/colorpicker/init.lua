local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local utils = require "telescope.utils"

local colorschemes = {
    ["tokyonight"] = "tokyonight",
    ["tokyonight-day"] = "tokyonight_day",
    ["tokyonight-moon"] = "tokyonight_moon",
    ["tokyonight-storm"] = "tokyonight_storm",
    ["tokyonight-night"] = "tokyonight_night",
    ["catppuccin-frappe"] = "Catppuccin Frappe",
    ["catppuccin-latte"] = "Catppuccin Latte",
    ["catppuccin-macchiato"] = "Catppuccin Macchiato",
    ["catppuccin-mocha"] = "Catppuccin Mocha",
    ["gruvbox"] = "GruvboxDark",
    ["base16-black-metal-bathory"] = "Black Metal (Bathory) (base16)",
    ["kanagawa"] = "Kanagawa (Gogh)",
    ["everforest"] = "Everforest Dark (Gogh)",
    ["carbonfox"] = "carbonfox",
    ["dawnfox"] = "dawnfox",
    ["nightfox"] = "nightfox",
    ["duskfox"] = "duskfox",
    ["dayfox"] = "dayfox",
    ["terafox"] = "terafox",
    ["nordfox"] = "nordfox",
}

local function getKeys(tab)
    local keys = {}
    for k, v in pairs(tab) do
        keys[#keys + 1] = k
    end
    return keys
end

local colorpicker = function(opts)

    local old_background = vim.o.background;
    local old_color = vim.api.nvim_exec2("colorscheme", { output = true }).output
    local restore = true

    local apply = function()
        local selection = action_state.get_selected_entry()
        if selection == nil then
            utils.__warn_no_selection "colorpicker"
            return
        end
        vim.cmd.colorscheme(selection.value)
    end

    opts = opts or {}
    local picker = pickers.new(opts, {
        prompt_title = "colorpicker",
        finder = finders.new_table {
            results = getKeys(colorschemes)
        },
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                restore = false
                actions.close(prompt_bufnr)
                apply()
            end)

            return true
        end,
        on_complete = { function ()
            apply()
        end },
    })

    -- Restore old colors
    local close_windows = picker.close_windows
    picker.close_windows = function(status)
        close_windows(status)
        if restore then
            vim.o.background = old_background
            vim.cmd.colorscheme(old_color)
        end

    end

    local set_selection = picker.set_selection
    picker.set_selection = function(self, row)
        set_selection(self, row)
        apply()
    end

    picker:find()
end

return {
    colorpicker = colorpicker,
    colorschemes = colorschemes
}
