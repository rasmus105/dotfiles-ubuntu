local map = vim.keymap.set
local functions = require("config.keymaps.functions")

map({ "n", "v", "x" }, "<leader>n", ":norm ", { desc = "enter norm command" })
map({ "n", "v", "x" }, "<leader>q", ":q<CR>", { desc = "quit" })
map({ "n", "v", "x" }, "<leader>x", ":wqa!<CR>", { desc = "force quit all" })
map({ "n", "v", "x" }, "<leader>l", ":update<CR>:source<CR>", { desc = "Update and source lua file" })
map({ "n", "v", "x" }, "<leader>,", ":tabnew<CR>:term<CR>i", { desc = "Open terminal" })
map({ "n", "v", "x" }, "<leader>.", ":edit!<CR>", { desc = "Reload current file" })
map({ "n", "v", "x" }, "<CR>", ":T ", { desc = "Execute terminal command" })
map({ "n", "v", "x" }, "<leader>s", ":wa<CR>", { desc = "Save all files" })

map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")

map("n", "<C-w>h", "5<C-w><")
map("n", "<C-w>l", "5<C-w>>")
map("n", "<C-w>j", "5<C-w>+")
map("n", "<C-w>k", "5<C-w>-")

map("n", "<C-w>H", "<C-w>Hzz")
map("n", "<C-w>L", "<C-w>Lzz")
map("n", "<C-w>J", "<C-w>Jzz")
map("n", "<C-w>K", "<C-w>Kzz")

map("n", "]q", ":cnext<CR>zz")
map("n", "[q", ":cprev<CR>zz")

map("n", "<C-d>", function() vim.cmd("normal! " .. vim.keycode("<C-d>") .. "zz") end, { desc = "Scroll down and center" })
map("n", "<C-u>", function() vim.cmd("normal! " .. vim.keycode("<C-u>") .. "zz") end, { desc = "Scroll up and center" })
map("n", "<C-f>", "<C-f>zz")
map("n", "<C-b>", "<C-b>zz")
map("n", "<C-o>", "<C-o>zz")
map("n", "<C-i>", "<C-i>zz")

map({ "n", "v" }, "<leader>y", '"+y')
map("n", "<leader>Y", '"+Y')
map("n", "<leader>p", '"+p')
map("n", "<leader>d", '"+d')

map("n", "<leader>a", "gg<S-v>G")
map("n", "<leader>/", ":noh<CR>")
map({ "n", "v" }, "q:", "")

map("v", "<", "<gv")
map("v", ">", ">gv")

map("n", "<tab>", functions.previous_tab)
map("n", "<leader><tab>n", ":tabnew<CR>")
map("n", "<leader><tab>q", ":tabclose<CR>")
map("n", "<leader><tab>l", ":tabnext<CR>")
map("n", "<leader><tab>h", ":tabprevious<CR>")
map("n", "<leader><tab>m", "<C-w>T")
for i = 1, 9 do
    map("n", "<leader><tab>" .. i, ":tabn " .. i .. "<CR>")
end

map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

map("n", "<leader>tw", ":set wrap!<CR>")

map("n", "n", "'Nn'[v:searchforward].'zzzv'", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zzzv'", { expr = true, desc = "Prev Search Result" })

map("v", "p", '"_dP')

map("n", "z0", "1z=", { desc = "Fix word under cursor" })

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '>-2<CR>gv=gv")

map("n", "<leader>w", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

map({ "c", "i" }, "<C-e>", "<End>")
map({ "c", "i" }, "<C-a>", "<Home>")
map({ "c", "i" }, "<C-b>", "<Left>")
map({ "c", "i" }, "<C-f>", "<Right>")

map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit Terminal" })
