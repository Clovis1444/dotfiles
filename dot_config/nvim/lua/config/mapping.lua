-- This module contains all non plugin specific mapping and function to use in it

-- Functions to map
function saveAndFormatFile()
    vim.lsp.buf.format()
    vim.cmd("write")
end

function toggleRelativeNumber()
    vim.opt.relativenumber = not vim.opt.relativenumber:get()
end

-- Custom variable rename function
function LspRename()
    local curr_name = vim.fn.expand("<cword>")
    local value = vim.fn.input("LSP Rename: ", curr_name)
    local lsp_params = vim.lsp.util.make_position_params()

    if not value or #value == 0 or curr_name == value then
        return
    end

    -- request lsp rename
    lsp_params.newName = value
    vim.lsp.buf_request(0, "textDocument/rename", lsp_params, function(_, res, ctx, _)
        if not res then
            return
        end

        -- apply renames
        local client = vim.lsp.get_client_by_id(ctx.client_id)
        vim.lsp.util.apply_workspace_edit(res, client.offset_encoding)

        -- print renames
        local changed_files_count = 0
        local changed_instances_count = 0

        if res.documentChanges then
            for _, changed_file in pairs(res.documentChanges) do
                changed_files_count = changed_files_count + 1
                changed_instances_count = changed_instances_count + #changed_file.edits
            end
        elseif res.changes then
            for _, changed_file in pairs(res.changes) do
                changed_instances_count = changed_instances_count + #changed_file
                changed_files_count = changed_files_count + 1
            end
        end

        -- compose the right print message
        -- Note: using nvim-notify plugin
        vim.notify(
            string.format(
                "Renamed %s instance%s in %s file%s. %s",
                changed_instances_count,
                changed_instances_count == 1 and "" or "s",
                changed_files_count,
                changed_files_count == 1 and "" or "s",
                changed_files_count > 1 and "\nTo save them run ':wa'" or ""
            ),
            "info",
            { title = "LspRename", timeout = 10000 }
        )
    end)
end

-- Mapping
vim.keymap.set("n", "<F2>", ":lua LspRename()<CR>", {})
vim.api.nvim_set_keymap("i", "<C-c>", "<Esc>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<C-s>", ":lua saveAndFormatFile()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-s>", "<Esc>:lua saveAndFormatFile()<CR>a", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F3>", ":lua toggleRelativeNumber()<CR>", { noremap = true, silent = true })
-- Center on cursor after scrolling
vim.api.nvim_set_keymap("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })

-- Move line
vim.api.nvim_set_keymap("n", "<M-k>", ":m -2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<M-Up>", ":m -2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<M-j>", ":m +1<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<M-Down>", ":m +1<CR>", { noremap = true, silent = true })

-- Move selection
vim.api.nvim_set_keymap("x", "<M-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "<M-Up>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "<M-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "<M-Down>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
