return {
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
            vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", {})
            vim.keymap.set("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>", {})

            vim.keymap.set("n", "<M-=>", ":Gitsigns nav_hunk next<CR>", {})
            vim.keymap.set("n", "<M-->", ":Gitsigns nav_hunk prev<CR>", {})
        end,
    },
    -- Important: lazygit cli should be installed
    -- Note: to enable syntax highlight in lazygit setup Delta. See:
    -- https://github.com/dandavison/delta
    -- https://github.com/jesseduffield/lazygit/blob/master/docs/Custom_Pagers.md
    {
        "kdheepak/lazygit.nvim",
        lazy = true,
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        -- setting the keybinding for LazyGit with 'keys' is recommended in
        -- order to load the plugin when the command is run for the first time
        keys = {
            { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
        },
    },
}
