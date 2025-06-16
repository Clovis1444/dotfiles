return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("lualine").setup({
            options = {
                theme = "auto",
                -- Use this to enable lualine in buffers when switch focus to Neo-tree
                ignore_focus = { "neo-tree" },
            },
            sections = {
                -- Show filename and filepath relative to pwd
                lualine_c = { "filename", [[vim.fn.expand("%:.")]] },
            },
            -- Add extension for Neo-Tree
            extensions = { "neo-tree" },
        })
    end,
}
