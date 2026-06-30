vim.pack.add({
    -- General Utils
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },

    -- File
    { src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" },
    { src = "https://github.com/mikavilpas/yazi.nvim" },

    -- Searching & Replacing
    { src = "https://github.com/ibhagwan/fzf-lua" },
    { src = "https://github.com/MagicDuck/grug-far.nvim" },

    -- Editor improvements
    { src = "https://github.com/nvim-mini/mini.surround" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
    { src = "https://github.com/esmuellert/codediff.nvim" },
    { src = "https://github.com/saecki/crates.nvim" },

    -- LSP
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
    { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
    { src = "https://github.com/Saghen/blink.cmp", version = vim.version.range("^1") },
    { src = "https://github.com/mrcjkb/rustaceanvim" },

    -- Debugging
    { src = "https://github.com/mfussenegger/nvim-dap" },
    { src = "https://github.com/igorlfs/nvim-dap-view", version = vim.version.range("^1") },

    -- Snippets
    { src = "https://github.com/L3MON4D3/LuaSnip" },

    -- Colorschemes & Visuals
    { src = "https://github.com/nvim-mini/mini.icons" },
    { src = "https://github.com/nvim-mini/mini.cursorword" },
    { src = "https://github.com/dchinmay2/alabaster.nvim" },
    { src = "https://github.com/folke/which-key.nvim" },
    { src = "https://github.com/nvim-lualine/lualine.nvim" },

    -- Colorschemes
    { src = "https://github.com/ellisonleao/gruvbox.nvim" },

    -- Testing
    { src = "https://github.com/rasmus105/test-runner.nvim" },
})
