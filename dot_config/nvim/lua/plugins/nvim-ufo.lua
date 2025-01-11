return {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    lazy = false,
    config = function()
        -- disable numbers
        vim.o.foldcolumn = "auto:9" -- '0' is not bad
        vim.o.foldlevel = 99  -- Using ufo provider need a large value, feel free to decrease the value
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true
        vim.o.foldmethod = "manual"
        -- set folding symbols
        vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep:│,foldclose:]]

        -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
        -- 'zC'/'zO' - close/open single block
        vim.keymap.set("n", "zR", require("ufo").openAllFolds)
        vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

        -- IMPORTANT: MUST add the following capabilities to lsp=config.lua
        -- using Option 2: nvim lsp as LSP client
        -- Tell the server the capability of foldingRange,
        -- Neovim hasn't added foldingRange to default capabilities, users must add it manually
        require("ufo").setup({
            -- IMPORTANT: Edit the following property to disable auto closing some blocks
            -- Default value: {"imports", "comment", "region"}
            close_fold_kinds_for_ft = {
                default = {},
                -- json = { "array" },
                -- c = { "comment", "region" },
            },
        })
    end,
}
