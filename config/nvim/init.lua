---- Configuration ----
require("config.options")     -- vim options (i.e. vim.opt.*)
require("config.vim-keymaps") -- vim native keymaps
require("config.vim-pack")
require("config.colorscheme") -- colorscheme configuration and setup
require("config.lsp")         -- LSP setup, configuration and keymaps
require("config.autocmds")    -- Useful autocommands

---- Iterate over all lua files in lua/plugins and import them ----
for _, file in ipairs(vim.fn.readdir(vim.fn.stdpath("config") .. "/lua/plugins", [[v:val =~ '\.lua$']])) do
    local module = file:gsub("%.lua$", "")
    require("plugins." .. module)
end
