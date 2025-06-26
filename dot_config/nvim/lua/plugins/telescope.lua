return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
            vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
            vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
        end,
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            -- Custom filenameFirst function
            local function filenameFirst(_, path)
                local tail = vim.fs.basename(path)
                local parent = vim.fs.dirname(path)
                if parent == "." then
                    return tail
                end
                return string.format("%s\t\t%s", tail, parent)
            end

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "TelescopeResults",
                callback = function(ctx)
                    vim.api.nvim_buf_call(ctx.buf, function()
                        vim.fn.matchadd("TelescopeParent", "\t\t.*$")
                        vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
                    end)
                end,
            })

            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                },
                defaults = {
                    dynamic_preview_title = true,
                    layout_strategy = "vertical",
                    layout_config = {
                        vertical = {
                            prompt_position = "bottom",
                            preview_cutoff = 1,
                            -- Change the height of Telescope's preview window
                            preview_height = 0.6,
                        },
                    },
                },
                pickers = {
                    git_status = { path_display = filenameFirst },
                    find_files = { path_display = filenameFirst },
                },
            })
            require("telescope").load_extension("ui-select")
        end,
    },
}
