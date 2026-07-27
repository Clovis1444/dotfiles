-- [Plugins]
-- TODO(clovis): add LSP support
-- TODO(clovis): add org mode support

-- Dependency programs: fzf, fd, rg, bat, delta
vim.pack.add({
    -- Dependency plugins
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/nvim-tree/nvim-web-devicons",
    "https://github.com/rafamadriz/friendly-snippets",

    -- Theme
    "https://github.com/catppuccin/nvim",

    -- Keybinds hints
    "https://github.com/folke/which-key.nvim",

    -- Session manager
    "https://github.com/rmagatti/auto-session",

    -- File explorer
    "https://github.com/stevearc/oil.nvim",
    -- File picker.
    "https://github.com/ibhagwan/fzf-lua",
    "https://github.com/ingur/fzf-oil.nvim",

    -- Buffer manager
    "https://github.com/j-morano/buffer_manager.nvim",

    -- Completion
    {
        src = "https://github.com/saghen/blink.cmp",
        version = vim.version.range("^1")
    },

    -- Magit like git client
    "https://github.com/NeogitOrg/neogit",

    -- Compile Mode for nvim
    "https://github.com/ej-shafran/compile-mode.nvim",

    -- Status line
    "https://github.com/nvim-lualine/lualine.nvim",
    -- Dashboard
    "https://github.com/nvimdev/dashboard-nvim",

    -- Qol plugins
    "https://github.com/folke/todo-comments.nvim",
})
--

-- [Functions]
open_config_in_oil = function()
    vim.cmd("Oil " .. vim.fn.stdpath("config"))
end
open_config_file = function()
    vim.cmd("edit " .. vim.fn.stdpath("config") .. "/init.lua")
end

open_buffer_manager = function()
    require("buffer_manager.ui").toggle_quick_menu()
end

cmp_auto_show = function()
    if vim.g.cmp_auto_show == nil then
        vim.g.cmp_auto_show = false
    end
    return vim.g.cmp_auto_show
end
toggle_cmp_auto_show = function()
    vim.g.cmp_auto_show = not vim.g.cmp_auto_show
    print("vim.g.cmp_auto_show = ", cmp_auto_show())
end
toggle_line_number = function()
    vim.opt.number = not vim.opt.number:get()
    print("vim.opt.number = ", vim.opt.number:get())
end
toggle_relative_number = function()
    vim.opt.relativenumber = not vim.opt.relativenumber:get()
    print("vim.opt.relativenumber = ", vim.opt.relativenumber:get())
end
--

-- [Plugins setup]
require("dashboard").setup({
    theme = "doom",
    config = {
        center = {
          {
            icon = "󱋡 ",
            icon_hl = "Title",
            desc = "Recently opened files",
            desc_hl = "String",
            key = "1",
            key_hl = "Number",
            key_format = " %s",
            action = "FzfLua oldfiles"
          },
          {
            icon = "󰙰 ",
            icon_hl = "Title",
            desc = "Reload last session",
            desc_hl = "String",
            key = "2",
            key_hl = "Number",
            key_format = " %s",
            action = "AutoSession restore",
          },
          {
            icon = "󰱼 ",
            icon_hl = "Title",
            desc = "Select session",
            desc_hl = "String",
            key = "3",
            key_hl = "Number",
            key_format = " %s",
            action = "AutoSession search",
          },
          {
            icon = "󱁻 ",
            icon_hl = "Title",
            desc = "Open nvim config file",
            desc_hl = "String",
            key = "4",
            key_hl = "Number",
            key_format = " %s",
            action = open_config_file,
          },
          {
            icon = "󱁿 ",
            icon_hl = "Title",
            desc = "Open nvim config",
            desc_hl = "String",
            key = "5",
            key_hl = "Number",
            key_format = " %s",
            action = open_config_in_oil,
          },
        },
    },
})

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
require("auto-session").setup({
    auto_restore = false,
    cwd_change_handling = true,
})

require("which-key").setup()

require("oil").setup({
    buf_options = {
        buflisted = true,
    },
    view_options = {
        show_hidden = true,
    },
    columns = {
        "icon",
        "permissions",
        "size",
        "mtime",
    },
    watch_for_changes = true,

    float = require("fzf-oil").float,
    preview_win = require("fzf-oil").preview_win,
})

local fzf_oil = require("fzf-oil").setup()

require("fzf-lua").setup({
    defaults = {
        hidden = true,
        no_ignore = true,
    },
})

require("buffer_manager").setup({
    focus_alternate_buffer = true,
})

require('blink.cmp').setup({
    completion = {
        trigger = { show_in_snippet = false },
        menu = { auto_show = cmp_auto_show },
    },
    keymap = { preset = "super-tab" },
    cmdline = {
        keymap = { preset = 'inherit' },
        completion = { menu = { auto_show = true } },
    },
})

vim.g.compile_mode = {
    default_command = "",
    focus_compilation_buffer = true,
}

local lualine_cfg = require("lualine").get_config()
lualine_cfg.sections.lualine_c = {
    { "filename", path = 1 }
}
require("lualine").setup(lualine_cfg)
require("todo-comments").setup({
    -- Custom keywords
    keywords = {
        IMPORTANT = { icon = " ", color = "hint" },
    },
    highlight = {
        -- NOTE: vim regex
        pattern = {
            [[.*<(KEYWORDS)\s*:]], -- default
            [[.*<(KEYWORDS)\s*\([^\)]*\)\s*:]], -- "KEYWORD(author): ..."
        },
    },
    search = {
        -- NOTE: ripgrep regex
        pattern = [[\b(KEYWORDS)\s*(\([^)]*\))?\s*:]], -- default + "KEYWORD(author): ..."
    },
})
--

-- [Editor]
vim.cmd.colorscheme "catppuccin-nvim"

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.wrap = true

-- Use system clipboard
vim.opt.clipboard = "unnamedplus"

-- Syntax highlighting
vim.opt.syntax = "enable"
--

-- [Bindings]
vim.g.mapleader = ' '

local wk = require("which-key")
wk.add({
    -- Buffer
    {"<leader>b", group = "Buffer"},
    {"<leader>bb", open_buffer_manager, desc = "Open buffer manager", mode = "n"},
    {"<leader>bn", "<cmd>bnext<cr>", desc = "Next buffer", mode = "n"},
    {"<leader>bp", "<cmd>bprev<cr>", desc = "Prev buffer", mode = "n"},
    {"<leader>bk", "<cmd>bd<cr>", desc = "Kill buffer", mode = "n"},
    {"<leader>bK", "<cmd>bd!<cr>", desc = "Kill buffer without saving", mode = "n"},
    {"<leader>bs", "<cmd>w<cr>", desc = "Save buffer", mode = "n"},
    {"<leader>bS", "<cmd>wa<cr>", desc = "Save all buffers", mode = "n"},
    {"<leader>b/", "<cmd>FzfLua blines<cr>", desc = "Search in current buffer", mode = "n"},

    -- Window
    {"<leader>w", group = "Window"},
    {"<leader>ws", "<cmd>sp<cr>", desc = "Horizontal window split", mode = "n"},
    {"<leader>wv", "<cmd>vs<cr>", desc = "Vercital window split", mode = "n"},
    {"<leader>wq", "<cmd>q<cr>", desc = "Close window", mode = "n"},
    {"<leader>wQ", "<cmd>q!<cr>", desc = "Close window without saving", mode = "n"},
    {"<leader>wx", "<C-w>o", desc = "Close all other windows", mode = "n"},

    {"<leader>wj", "<C-w>j", desc = "Focus down window", mode = "n"},
    {"<leader>w<Down>", "<C-w>j", desc = "Focus down window", mode = "n"},
    {"<leader>wk", "<C-w>k", desc = "Focus up window", mode = "n"},
    {"<leader>w<Up>", "<C-w>k", desc = "Focus up window", mode = "n"},
    {"<leader>wh", "<C-w>h", desc = "Focus left window", mode = "n"},
    {"<leader>w<Left>", "<C-w>h", desc = "Focus left window", mode = "n"},
    {"<leader>wl", "<C-w>l", desc = "Focus right window", mode = "n"},
    {"<leader>w<Right>", "<C-w>l", desc = "Focus right window", mode = "n"},

    {"<leader>w+", "<C-w>+", desc = "Increase height", mode = "n"},
    {"<leader>w-", "<C-w>-", desc = "Decrease height", mode = "n"},
    {"<leader>w>", "<C-w>>", desc = "Increase width", mode = "n"},
    {"<leader>w<", "<C-w><", desc = "Decrease width", mode = "n"},
    {"<leader>w=", "<C-w>=", desc = "Equally high and wide", mode = "n"},

    -- TODO(clovis): add jumping groups "[" / "]"
    -- TODO(clovis): add TODO jumps

    -- File/Find
    {"<leader>f", group = "File/Find"},
    {"<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find file", mode = "n"},
    {"<leader>fd", fzf_oil.browse, desc = "Find directory", mode = "n"},
    {"<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent files", mode = "n"},
    {"<leader>fc", open_config_file, desc = "Open nvim config file", mode = "n"},
    -- TODO(clovis): consider expanding this? Make it subgroup, add filters?
    {"<leader>ft", "<cmd>TodoFzfLua<cr>", desc = "Find TODOs", mode = "n"},

    -- Quit/Session
    {"<leader>q", group = "Quit/Session"},
    {"<leader>qs", "<cmd>AutoSession search<cr>", desc = "Select session", mode = "n"},
    {"<leader>qa", "<cmd>AutoSession save<cr>", desc = "Save current session", mode = "n"},
    {"<leader>qd", "<cmd>AutoSession delete<cr>", desc = "Delete current session", mode = "n"},
    {"<leader>ql", "<cmd>AutoSession restore<cr>", desc = "Load last session", mode = "n"},
    {"<leader>qt", "<cmd>AutoSession toggle<cr>", desc = "Toggle session autosave", mode = "n"},
    {"<leader>qq", "<cmd>qa<cr>", desc = "Quit nvim", mode = "n"},
    {"<leader>qQ", "<cmd>qa!<cr>", desc = "Quit nvim", mode = "n"},
    {"<leader>qr", "<cmd>restart<cr>", desc = "Restart nvim", mode = "n"},

    -- Open
    {"<leader>o", group = "Open"},
    {"<leader>o-", "<cmd>Oil<cr>", desc = "Open current directory in Oil", mode = "n"},
    {"<leader>oc", open_config_file, desc = "Open nvim config file", mode = "n"},
    {"<leader>oC", open_config_in_oil, desc = "Open nvim config", mode = "n"},
    {"<leader>of", "<cmd>FzfLua<cr>", desc = "Open FzfLua", mode = "n"},

    -- Git
    {"<leader>g", group = "Git"},
    {"<leader>gg", "<cmd>Neogit<cr>", desc = "Open Neogit", mode = "n"},

    -- Code
    {"<leader>c", group = "Code"},
    {"<leader>cc", "<cmd>below Compile<cr>", desc = "Compile Command", mode = "n"},
    {"<leader>cC", "<cmd>below Recompile<cr>", desc = "Recompile Command", mode = "n"},

    -- Toggle
    {"<leader>t", group = "Toggle"},
    {"<leader>tc", toggle_cmp_auto_show, desc = "Toggle completion auto show", mode = "n"},
    {"<leader>tn", toggle_line_number, desc = "Toggle line number", mode = "n"},
    {"<leader>tr", toggle_relative_number, desc = "Toggle relative line number", mode = "n"},

    -- No Group
    {"<leader>/", "<cmd>FzfLua live_grep<cr>", desc = "Search project", mode = "n"},
    {"<leader><leader>", "<cmd>FzfLua files<cr>", desc = "Find file", mode = "n"},
    {"<M-x>", "<cmd>FzfLua commands<cr>", desc = "Execute command", mode = "n"},
})

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
--
