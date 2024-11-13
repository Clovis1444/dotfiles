-- This module contains all non plugin specific mapping and function to use in it

-- Functions to map
function saveAndFormatFile()
	vim.lsp.buf.format()
	vim.cmd("write")
end

function toggleRelativeNumber()
	vim.opt.relativenumber = not vim.opt.relativenumber:get()
end

-- Mapping
vim.api.nvim_set_keymap("i", "<C-c>", "<Esc>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<C-s>", ":lua saveAndFormatFile()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-s>", "<Esc>:lua saveAndFormatFile()<CR>a", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F3>", ":lua toggleRelativeNumber()<CR>", { noremap = true, silent = true })
-- Center on cursor after scrolling
vim.api.nvim_set_keymap("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })
