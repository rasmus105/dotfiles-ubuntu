local map = vim.keymap.set
local lazy = require("config.lazy")

vim.g.autoformat = true

local function toggle_autoformat()
    vim.g.autoformat = not vim.g.autoformat
    local status = vim.g.autoformat and "enabled" or "disabled"
    print("Auto-formatting " .. status)
end

for _, key in ipairs({ "grr", "grn", "gra", "gri", "grt", "grx" }) do
    pcall(vim.keymap.del, "n", key)
end

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        local opts = { buffer = ev.buf, nowait = true }
        local client = vim.lsp.get_client_by_id(ev.data.client_id)

        if client and client.name == "tinymist" then
            vim.schedule(function()
                if vim.api.nvim_buf_is_valid(ev.buf) and vim.bo[ev.buf].filetype == "typst" then
                    vim.bo[ev.buf].formatexpr = ""
                end
            end)
        end

        map("n", "<leader>te", function()
            vim.diagnostic.enable(not vim.diagnostic.is_enabled())
        end, { buffer = ev.buf, desc = "Toggle Diagnostics" })
        map("n", "<leader>tf", toggle_autoformat, { buffer = ev.buf, desc = "Toggle auto-format" })

        map("n", "K", vim.lsp.buf.hover, opts)
        map("n", "gk", vim.lsp.buf.signature_help, opts)
        map("n", "gD", vim.lsp.buf.declaration, opts)
        map("n", "gi", vim.lsp.buf.implementation, opts)

        map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        map("n", "<leader>cr", vim.lsp.buf.rename, opts)
        if client and client.name == "zls" then
            map("n", "<leader>cf", function()
                vim.lsp.buf.code_action({
                    context = { only = { "source.fixAll" } },
                    apply = true,
                })
            end, { buffer = ev.buf, desc = "ZLS fix all" })
        end
        map("n", "<leader>f", function()
            vim.lsp.buf.format({ async = true })
        end, opts)

        map("n", "<leader>ch", ":LspClangdSwitchSourceHeader<CR>")
        map("n", "gl", vim.diagnostic.open_float, { buffer = ev.buf, desc = "Show diagnostic as float" })

        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = ev.buf,
            callback = function()
                if vim.g.autoformat then
                    vim.lsp.buf.format({ async = false, id = ev.data.client_id })
                end
            end,
        })
    end,
})

local setup_lsp = lazy.once("lsp", function()
    lazy.packadd("nvim-lspconfig")
    lazy.packadd("mason.nvim")
    lazy.packadd("mason-lspconfig.nvim")
    lazy.packadd("mason-tool-installer.nvim")

    require("mason").setup()
    require("mason-lspconfig").setup({
        automatic_enable = {
            exclude = {
                "julials",
                "rust_analyzer",
            },
        },
    })
    vim.lsp.enable("julials")

    require("mason-tool-installer").setup({
        ensure_installed = {
            "clangd",
            "julials",
            "lua_ls",
            "zls",
            "tinymist",
            "marksman",
            "codelldb",
            "clang-format",
            "stylua",
            "shellcheck",
            "shfmt",
        },
    })

    require("plugins.luasnip").setup()
    lazy.packadd("blink.cmp")

    require("blink.cmp").setup({
        fuzzy = { implementation = "prefer_rust_with_warning" },
        signature = { enabled = true },
        snippets = { preset = "luasnip" },
        keymap = {
            preset = "default",
            ["<C-p>"] = { "select_prev", "fallback" },
            ["<C-n>"] = { "select_next", "fallback" },
            ["<C-k>"] = { "select_prev", "fallback" },
            ["<C-j>"] = { "select_next", "fallback" },
            ["<C-l>"] = { "snippet_forward", "fallback" },
            ["<C-h>"] = { "snippet_backward", "fallback" },
            ["<C-g>"] = { "accept", "fallback" },
            ["<C-c>"] = { "cancel", "fallback" },
            ["<C-e>"] = false,
            ["<C-a>"] = false,
            ["<C-f>"] = false,
            ["<C-b>"] = false,
            ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
        },
        appearance = {
            use_nvim_cmp_as_default = false,
            nerd_font_variant = "mono",
        },
        completion = {
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 0,
                window = {
                    border = "none",
                },
            },
        },
        sources = { default = { "lsp", "snippets" } },
        cmdline = {
            enabled = true,
            completion = { menu = { auto_show = false } },
            keymap = {
                ["<C-p>"] = { "select_prev", "fallback" },
                ["<C-n>"] = { "select_next", "fallback" },
                ["<C-k>"] = { "select_prev", "fallback" },
                ["<C-j>"] = { "select_next", "fallback" },
                ["<C-g>"] = { "accept", "fallback" },
                ["<C-c>"] = { "cancel", "fallback" },
                ["<C-e>"] = false,
                ["<C-a>"] = false,
                ["<C-f>"] = false,
                ["<C-b>"] = false,
                ["<C-Space>"] = { "show", "fallback" },
            },
        },
    })

    vim.schedule(function()
        if next(vim.lsp._enabled_configs) then
            vim.cmd.doautoall("nvim.lsp.enable FileType")
        end
    end)
end)

lazy.on_event({ "BufReadPost", "BufNewFile" }, "Lsp", setup_lsp, { once = true, schedule = true })
lazy.on_event({ "InsertEnter", "CmdlineEnter" }, "LspImmediate", setup_lsp, { once = true })

vim.api.nvim_create_user_command("LspSetup", setup_lsp, { desc = "Load LSP and completion plugins" })
