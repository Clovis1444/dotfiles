vim.cmd.colorscheme "habamax"

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Use system clipboard
vim.opt.clipboard = "unnamedplus"

-- Syntax highlighting
vim.opt.syntax = "enable"

-- Move lines on Alt
vim.keymap.set("n", "<A-Up>", ":move -2<CR>==", { noremap = true, silent = true })
vim.keymap.set("n", "<A-Down>", ":move +1<CR>==", { noremap = true, silent = true })
vim.keymap.set("v", "<A-Up>", ":move '<-2<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("v", "<A-Down>", ":move '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("i", "<A-Up>", "<Esc>:move -2<CR>==gi", { noremap = true, silent = true })
vim.keymap.set("i", "<A-Down>", "<Esc>:move +1<CR>==gi", { noremap = true, silent = true })

vim.keymap.set("n", "<A-k>", ":move -2<CR>==", { noremap = true, silent = true })
vim.keymap.set("n", "<A-j>", ":move +1<CR>==", { noremap = true, silent = true })
vim.keymap.set("v", "<A-k>", ":move '<-2<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("v", "<A-j>", ":move '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("i", "<A-k>", "<Esc>:move -2<CR>==gi", { noremap = true, silent = true })
vim.keymap.set("i", "<A-j>", "<Esc>:move +1<CR>==gi", { noremap = true, silent = true })
