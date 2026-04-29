require("grug-far").setup()
vim.keymap.set("n", "<leader>z", function()
	require("grug-far").open()
end, { desc = "Search & Replace" })
