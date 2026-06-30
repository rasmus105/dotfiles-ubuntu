local map = vim.keymap.set
local lazy = require("config.lazy")

local setup = lazy.once("gitsigns", function()
    lazy.packadd("gitsigns.nvim")
    require("gitsigns").setup({
        signcolumn = false,
        current_line_blame = false,
        word_diff = false,
        preview_config = {
            border = "none",
            style = "minimal",
            relative = "cursor",
            row = 0,
            col = 1,
        },
        on_attach = function(bufnr)
            local gitsigns = require("gitsigns")

            local function opts(desc)
                return { buffer = bufnr, desc = desc }
            end

            map("n", "]h", function()
                if vim.wo.diff then
                    vim.cmd.normal({ "]c", bang = true })
                else
                    gitsigns.nav_hunk("next")
                end
            end, opts("Next hunk"))

            map("n", "[h", function()
                if vim.wo.diff then
                    vim.cmd.normal({ "[c", bang = true })
                else
                    gitsigns.nav_hunk("prev")
                end
            end, opts("Previous hunk"))

            map("v", "<leader>s", function()
                gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end, opts("Stage selected lines"))
            map("v", "<leader>r", function()
                gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end, opts("Reset selected lines"))

            map("n", "<leader>gu", gitsigns.undo_stage_hunk, opts("Undo stage hunk"))
            map("n", "<leader>gp", gitsigns.preview_hunk_inline, opts("Preview hunk inline"))

            map("n", "<leader>gb", function()
                gitsigns.blame_line({ full = true })
            end, opts("Blame line"))

            map("n", "<leader>tg", gitsigns.toggle_signs, opts("Toggle git signs"))
            map("n", "<leader>tb", gitsigns.toggle_current_line_blame, opts("Toggle line blame"))
        end,
    })
end)

lazy.on_event({ "BufReadPost", "BufNewFile" }, "Gitsigns", setup, { once = true, schedule = true })
