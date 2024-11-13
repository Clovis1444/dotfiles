-- DEPENDANCY: nerd font for icon support
-- font: https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip

return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function()
        -- Focus Neotree
        vim.keymap.set('n', '<C-n>', ':Neotree focus reveal<CR>', {})
        --vim.keymap.set('n', '<C-n>', ':wincmd p<CR>', {})
        -- Enable/disable sidebar
        vim.keymap.set('n', '<C-A-n>', ':Neotree toggle reveal<CR>', {})
    end
}
