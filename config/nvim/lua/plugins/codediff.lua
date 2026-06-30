local lazy = require("config.lazy")

local codediff_config = {
    highlights = {
        line_insert = "DiffAdd",
        line_delete = "DiffDelete",
    },
    explorer = {
        view_mode = "tree",
    },
    keymaps = {
        view = {
            quit = "q",
            toggle_explorer = "<leader>e",
            focus_explorer = "<leader>b",
            next_hunk = "]h",
            prev_hunk = "[h",
            next_file = "]f",
            prev_file = "[f",
        },
        explorer = {
            select = "<CR>",
            hover = "K",
            refresh = "R",
        },
    },
}

local load_codediff = lazy.once("codediff", function()
    lazy.packadd("codediff.nvim")
    lazy.del_user_command("VscodeDiff")

    require("codediff.config").setup(codediff_config)
    require("codediff.ui.highlights").setup()
end)

lazy.on_cmd("CodeDiff", load_codediff)

vim.api.nvim_create_user_command("CodeDiffStandalone", function(opts)
    local group = vim.api.nvim_create_augroup("CodeDiffStandalone", { clear = true })
    vim.g.codediff_standalone = true

    vim.api.nvim_create_autocmd("TabClosed", {
        group = group,
        callback = function()
            vim.schedule(function()
                if vim.g.codediff_standalone and vim.fn.tabpagenr("$") == 1 then
                    vim.g.codediff_standalone = false
                    vim.cmd("qa")
                end
            end)
        end,
    })

    load_codediff()
    vim.api.nvim_cmd({ cmd = "CodeDiff", args = opts.fargs }, {})
end, { nargs = "*", desc = "Open CodeDiff as a standalone session" })
