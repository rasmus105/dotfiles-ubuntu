local lazy = require("config.lazy")

local function setup()
    lazy.packadd("mini.surround")
    require("mini.surround").setup({
        mappings = {
            add = "zh",
            delete = "ds",
            replace = "zr",
            find = "",
            find_left = "",
            highlight = "",
            suffix_last = "",
            suffix_next = "",
        },
    })
end

lazy.on_vimenter(setup)
