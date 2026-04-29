require("yazi").setup({
	floating_window_scaling_factor = 1,
	yazi_floating_window_zindex = 1,
	yazi_floating_window_border = "none", -- Remove border for true fullscreen
})
vim.keymap.set("n", "<leader>-", ":Yazi<CR>", { desc = "Toggle Yazi" })
