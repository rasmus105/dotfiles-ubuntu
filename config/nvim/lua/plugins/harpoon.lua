local map = vim.keymap.set
local lazy = require("config.lazy")

local harpoon
local harpoon_list

local setup = lazy.once("harpoon", function()
    lazy.packadd("plenary.nvim")
    lazy.packadd("harpoon")

    harpoon = require("harpoon")
    harpoon.setup({
        settings = {
            save_on_toggle = true,
            sync_on_ui_close = true,
        },
    })

    harpoon_list = harpoon:list()

    harpoon:extend(require("harpoon.extensions").builtins.highlight_current_file())

    local orig_ui_toggle = harpoon.ui.toggle_quick_menu
    harpoon.ui.toggle_quick_menu = function(...)
        orig_ui_toggle(...)

        local win = vim.api.nvim_get_current_win()
        local buf = vim.api.nvim_win_get_buf(win)
        local bufname = vim.api.nvim_buf_get_name(buf)

        if bufname:match("harpoon") then
            for i = 1, 9 do
                map("n", tostring(i), function()
                    harpoon_list:select(i)
                end, { buffer = buf, noremap = true, silent = true })
            end
        end
    end

    return harpoon, harpoon_list
end)

map("n", "<leader>h", function()
    local _, list = setup()
    list:add()
end)

map("n", "<S-h>", function()
    local hp, list = setup()
    hp.ui:toggle_quick_menu(list)
end)

for i = 1, 9 do
    map("n", "<leader>" .. i, function()
        local _, list = setup()
        list:select(i)
    end)
end
