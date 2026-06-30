return {
    root_dir = function(bufnr, on_dir)
        local name = vim.api.nvim_buf_get_name(bufnr)
        on_dir(vim.fs.root(name, { "Project.toml", "JuliaProject.toml", ".git" }) or vim.fn.getcwd())
    end,
}
