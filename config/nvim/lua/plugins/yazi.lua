local lazy = require("config.lazy")

local setup = lazy.once("yazi", function()
    lazy.packadd("plenary.nvim")
    lazy.packadd("yazi.nvim")
    require("yazi").setup({
        floating_window_scaling_factor = 1,
        yazi_floating_window_zindex = 1,
        yazi_floating_window_border = "none",
    })
end)

lazy.on_cmd("Yazi", setup)

vim.keymap.set("n", "<leader>-", function()
    setup()
    vim.cmd.Yazi()
end, { desc = "Toggle Yazi" })
