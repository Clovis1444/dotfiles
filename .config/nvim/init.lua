-- [Plugins]
-- TODO(clovis): add LSP support
vim.pack.add({
    -- Dependency plugins
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/nvim-tree/nvim-web-devicons",

    -- Theme
    "https://github.com/catppuccin/nvim",

    -- Keybinds hints
    "https://github.com/folke/which-key.nvim",

    -- Session manager
    "https://github.com/folke/persistence.nvim",

    -- File explorer
    "https://github.com/stevearc/oil.nvim",
    -- File picker. Dep: (fzf)
    "https://github.com/ibhagwan/fzf-lua",
    "https://github.com/ingur/fzf-oil.nvim",

    -- Buffer manager
    "https://github.com/j-morano/buffer_manager.nvim",

    -- Magit like git client
    "https://github.com/NeogitOrg/neogit",

    -- Compile Mode for nvim
    "https://github.com/ej-shafran/compile-mode.nvim",

    -- Status line
    "https://github.com/nvim-lualine/lualine.nvim",
    -- Dashboard
    "https://github.com/nvimdev/dashboard-nvim",
})
--

-- [Functions]
load_last_session = function()
    require("persistence").load({ last = true })
end
load_current_dir_session = function()
    require("persistence").load()
end
select_session = function()
    require("persistence").select()
end
stop_session = function()
    require("persistence").stop()
end

open_config_in_oil = function()
    vim.cmd("Oil " .. vim.fn.stdpath("config"))
end
open_config_file = function()
    vim.cmd("edit " .. vim.fn.stdpath("config") .. "/init.lua")
end

open_buffer_manager = function()
    require("buffer_manager.ui").toggle_quick_menu()
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
            action = load_last_session,
          },
          {
            icon = "󰱼 ",
            icon_hl = "Title",
            desc = "Select session",
            desc_hl = "String",
            key = "3",
            key_hl = "Number",
            key_format = " %s",
            action = select_session,
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
require("persistence").setup()
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

require("fzf-lua").setup()

require("buffer_manager").setup({
    focus_alternate_buffer = true,
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

    -- TODO(clovis): finish thi section
    -- Window
    {"<leader>w", group = "Window"},
    {"<leader>ws", "<cmd>sp<cr>", desc = "Horizontal window split", mode = "n"},
    {"<leader>wv", "<cmd>vs<cr>", desc = "Vercital window split", mode = "n"},
    {"<leader>wq", "<cmd>q<cr>", desc = "Close window", mode = "n"},
    {"<leader>wQ", "<cmd>q!<cr>", desc = "Close window without saving", mode = "n"},
    {"<leader>wj", "<C-w>j", desc = "Focus down window", mode = "n"},
    {"<leader>wk", "<C-w>k", desc = "Focus up window", mode = "n"},
    {"<leader>wh", "<C-w>h", desc = "Focus left window", mode = "n"},
    {"<leader>wl", "<C-w>l", desc = "Focus right window", mode = "n"},

    -- File/Find
    {"<leader>f", group = "File/Find"},
    {"<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find file", mode = "n"},
    {"<leader>fd", fzf_oil.browse, desc = "Find directory", mode = "n"},
    {"<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent files", mode = "n"},
    {"<leader>fc", open_config_file, desc = "Open nvim config file", mode = "n"},

    -- Quit/Session
    {"<leader>q", group = "Quit/Session"},
    {"<leader>qs", "<cmd>lua select_session()<cr>", desc = "Select session", mode = "n"},
    {"<leader>qS", "<cmd>lua load_current_dir_session()<cr>", desc = "Load session for the current dir", mode = "n"},
    {"<leader>ql", "<cmd>lua load_last_session()<cr>", desc = "Load last session", mode = "n"},
    {"<leader>qd", "<cmd>lua stop_session()<cr>", desc = "Do not save current session", mode = "n"},
    {"<leader>qq", "<cmd>qa<cr>", desc = "Quit nvim", mode = "n"},
    {"<leader>qQ", "<cmd>qa!<cr>", desc = "Quit nvim", mode = "n"},
    {"<leader>qr", "<cmd>restart<cr>", desc = "Restart nvim", mode = "n"},

    -- Open
    {"<leader>o", group = "Open"},
    {"<leader>o-", "<cmd>Oil<cr>", desc = "Open current directory in Oil", mode = "n"},
    {"<leader>oc", open_config_file, desc = "Open nvim config file", mode = "n"},
    {"<leader>oC", open_config_in_oil, desc = "Open nvim config", mode = "n"},

    -- Git
    {"<leader>g", group = "Git"},
    {"<leader>gg", "<cmd>Neogit<cr>", desc = "Open Neogit", mode = "n"},

    -- Code
    {"<leader>c", group = "Code"},
    {"<leader>cc", "<cmd>below Compile<cr>", desc = "Compile Command", mode = "n"},
    {"<leader>cC", "<cmd>below Recompile<cr>", desc = "Recompile Command", mode = "n"},

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
