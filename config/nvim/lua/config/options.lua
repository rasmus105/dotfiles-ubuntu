local opt = vim.opt
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.o.title = true

opt.wrap = false
opt.number = false
opt.relativenumber = true
opt.cursorline = false
opt.scrolloff = 8
opt.statuscolumn = [[%s%C%=%{v:relnum == 0 ? '' : v:relnum} ]]
opt.numberwidth = 1

opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true

opt.termguicolors = true
opt.signcolumn = "auto"
opt.showmatch = true
opt.matchtime = 2
opt.cmdheight = 1
opt.showmode = false
opt.pumheight = 10
opt.pumblend = 10
opt.winblend = 0
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 0
opt.concealcursor = ""
opt.synmaxcol = 300
opt.ruler = false
opt.virtualedit = "block"
opt.winminwidth = 5
opt.winborder = "none"

opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.undofile = true
opt.undolevels = 10000
opt.undodir = vim.fn.expand("~/.vim/undodir")
opt.updatetime = 300
opt.timeoutlen = 150
opt.ttimeoutlen = 0
opt.autoread = true
opt.autowrite = true

opt.hidden = true
opt.errorbells = false
opt.backspace = "indent,eol,start"
opt.autochdir = false
opt.path:append("**")
opt.mouse = "a"
opt.mousescroll = "ver:1,hor:1"
opt.modifiable = true
opt.encoding = "UTF-8"

opt.smoothscroll = true
opt.foldlevel = 99
opt.formatoptions = "jcroqlnt"
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"

opt.splitbelow = true
opt.splitright = true
opt.splitkeep = "cursor"

opt.wildmenu = true
opt.wildmode = "longest:full,full"
opt.wildignore:append({ "*.o", "*.obj", "*.pyc", "*.class", "*.jar" })

opt.diffopt:append("linematch:60")

opt.redrawtime = 10000
opt.maxmempattern = 20000

local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
    vim.fn.mkdir(undodir, "p")
end

opt.laststatus = 3
opt.list = false

local option_modules = vim.fn.readdir(vim.fn.stdpath("config") .. "/lua/config/options", [[v:val =~ '\.lua$']])
table.sort(option_modules)
for _, file in ipairs(option_modules) do
    local module = file:gsub("%.lua$", "")
    require("config.options." .. module)
end
