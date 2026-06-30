local lazy = require("config.lazy")

lazy.packadd("gruvbox.nvim")
lazy.packadd("alabaster.nvim")

require("gruvbox").setup({
    terminal_colors = true,
    undercurl = true,
    underline = true,
    bold = true,
    italic = { strings = false, emphasis = true, comments = true, operators = false, folds = true },
    strikethrough = true,
    invert_selection = false,
    invert_signs = false,
    invert_tabline = false,
    invert_intend_guides = false,
    inverse = false,
    contrast = "",
    palette_overrides = {},
    dim_inactive = false,
    transparent_mode = false,
    overrides = {
        Normal = { bg = "#292522" },
        DiffAdd = { bg = "#3d4220" },
        DiffDelete = { bg = "#4a2828" },
        DiffChange = { bg = "#3a3520" },
        DiffText = { bg = "#5c5020", fg = "#ebdbb2" },
        CodeDiffLineInsert = { bg = "#2a3525" },
        CodeDiffLineDelete = { bg = "#3a2525" },
        CodeDiffCharInsert = { bg = "#3d4a2a" },
        CodeDiffCharDelete = { bg = "#4a3030" },
        Search = { reverse = true },
        IncSearch = { reverse = true },
        CurSearch = { reverse = true },
    },
})

pcall(vim.cmd, "colorscheme gruvbox")
