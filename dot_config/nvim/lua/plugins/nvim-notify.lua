return {
    "rcarriga/nvim-notify",
    config = function()
        vim.notify = function(msg, ...)
            -- Note: silence this annoying warning
            -- Source: https://github.com/jose-elias-alvarez/null-ls.nvim/issues/428
            if msg:match("warning: multiple different client offset_encodings") then
                return
            end

            require("notify")(msg, ...)
        end

        require("notify").setup()
    end,
}
