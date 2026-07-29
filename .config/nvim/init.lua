-- [Plugins]
-- See ./README.org to see requirements
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
    "https://github.com/lewis6991/gitsigns.nvim",

    -- Compile Mode for nvim
    "https://github.com/ej-shafran/compile-mode.nvim",

    -- Syntax highlighting
    "https://github.com/nvim-treesitter/nvim-treesitter",

    -- LSP
    "https://github.com/folke/lazydev.nvim",
    "https://github.com/neovim/nvim-lspconfig",

    -- Status line
    "https://github.com/nvim-lualine/lualine.nvim",
    -- Dashboard
    "https://github.com/nvimdev/dashboard-nvim",

    -- Qol plugins
    "https://github.com/folke/todo-comments.nvim",
    "https://github.com/nvim-mini/mini.align",

    -- Langs
    "https://github.com/nvim-orgmode/orgmode",
})
--

-- [Functions]
function open_config_in_oil()
    vim.cmd("Oil " .. vim.fn.stdpath("config"))
end
function open_config_file()
    vim.cmd("edit " .. vim.fn.stdpath("config") .. "/init.lua")
end

function open_buffer_manager()
    require("buffer_manager.ui").toggle_quick_menu()
end

function cmp_auto_show()
    if vim.g.cmp_auto_show == nil then
        vim.g.cmp_auto_show = false
    end
    return vim.g.cmp_auto_show
end
function toggle_cmp_auto_show()
    vim.g.cmp_auto_show = not vim.g.cmp_auto_show
    print("vim.g.cmp_auto_show = ", cmp_auto_show())
end
function toggle_line_number()
    vim.opt.number = not vim.opt.number:get()
    print("vim.opt.number = ", vim.opt.number:get())
end
function toggle_relative_number()
    vim.opt.relativenumber = not vim.opt.relativenumber:get()
    print("vim.opt.relativenumber = ", vim.opt.relativenumber:get())
end

function jump_next_todo(keywords)
    if keywords == nil then
        require("todo-comments").jump_next()
    else
        require("todo-comments").jump_next({ keywords = keywords })
    end
end
function jump_prev_todo(keywords)
    if keywords == nil then
        require("todo-comments").jump_prev()
    else
        require("todo-comments").jump_prev({ keywords = keywords })
    end
end


function jump_next_error()
    vim.diagnostic.jump({ count = 1, float = true })
end
function jump_prev_error()
    vim.diagnostic.jump({ count = -1, float = true })
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
            key = "r",
            key_hl = "Number",
            key_format = " %s",
            action = "FzfLua oldfiles"
          },
          {
            icon = "󰙰 ",
            icon_hl = "Title",
            desc = "Reload last session",
            desc_hl = "String",
            key = "l",
            key_hl = "Number",
            key_format = " %s",
            action = "AutoSession restore",
          },
          {
            icon = "󰱼 ",
            icon_hl = "Title",
            desc = "Select session",
            desc_hl = "String",
            key = "s",
            key_hl = "Number",
            key_format = " %s",
            action = "AutoSession search",
          },
          {
            icon = "󱁻 ",
            icon_hl = "Title",
            desc = "Open nvim config file",
            desc_hl = "String",
            key = "c",
            key_hl = "Number",
            key_format = " %s",
            action = open_config_file,
          },
          {
            icon = "󱁿 ",
            icon_hl = "Title",
            desc = "Open nvim config",
            desc_hl = "String",
            key = "C",
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
    ui_select = {},
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
        trigger = {
            show_in_snippet = false
        },
        menu = { auto_show = cmp_auto_show },
    },
    keymap = { preset = "super-tab" },
    cmdline = {
        keymap = { preset = 'inherit' },
        completion = { menu = { auto_show = true } },
    },
})

require('gitsigns').setup()

vim.g.compile_mode = {
    default_command = "",
    focus_compilation_buffer = true,
}

-- See :h nvim-treesitter-quickstart
require('nvim-treesitter').setup({
})
-- IMPORTANT: add tree-sitter languages here
-- See https://github.com/nvim-treesitter/nvim-treesitter/blob/main/SUPPORTED_LANGUAGES.md
local ts_langs = {
    "lua", "c", "cpp", "rust", "bash", "javascript",
    "json", "toml", "kdl",
}
require('nvim-treesitter').install(ts_langs)
-- Enable tree-sitter features
vim.api.nvim_create_autocmd('FileType', {
    pattern = ts_langs,
    callback = function()
        -- syntax highlighting, provided by Neovim
        vim.treesitter.start()
        -- folds, provided by Neovim
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo.foldmethod = 'expr'
        -- indentation, provided by nvim-treesitter
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})

require('lazydev').setup()
-- IMPORTANT: add lsp servers here. You need to manually install servers on your machine
local lsp_servers = {
    "clangd", "lua_ls",
}
-- Enable lsp servers
-- See :h lspconfig-quickstart
for _, lsp in pairs(lsp_servers) do
    vim.lsp.enable(lsp)
end


require("lualine").setup({
    sections = {
        lualine_c = {{ "filename", path = 1 }},
        lualine_x = {'lsp_status','encoding', 'fileformat', 'filetype'},
    }
})

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
require('mini.align').setup({
    mappings = {
        start = "ga",
        start_with_preview = "gA",
    },
})

require('orgmode').setup({
    org_startup_folded = "showeverything",
})
--

-- [General]
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

-- Regex syntax highlighting
vim.opt.syntax = "enable"

-- Disable auto folding
vim.opt.foldenable = false
vim.opt.foldmethod = 'manual'
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

    -- Next
    {"<leader>]", group = "Next"},
    {"<leader>]t", jump_next_todo, desc = "Next TODO", mode = "n"},
    {"<leader>]T", function() jump_next_todo({"TODO"}) end, desc = "Next TODO(TODO only)", mode = "n"},
    {"<leader>]e", jump_next_error, desc = "Next error", mode = "n"},
    {"<leader>]g", "<cmd>Gitsigns nav_hunk next<cr>", desc = "Next git hunk", mode = "n"},
    -- Prev
    {"<leader>[", group = "Prev"},
    {"<leader>[t", jump_prev_todo, desc = "Prev TODO", mode = "n"},
    {"<leader>[T", function() jump_prev_todo({"TODO"}) end, desc = "Prev TODO(TODO only)", mode = "n"},
    {"<leader>[e", jump_prev_error, desc = "Prev error", mode = "n"},
    {"<leader>[g", "<cmd>Gitsigns nav_hunk prev<cr>", desc = "Prev git hunk", mode = "n"},

    -- File/Find
    {"<leader>f", group = "File/Find"},
    {"<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find file", mode = "n"},
    {"<leader>fd", fzf_oil.browse, desc = "Find directory", mode = "n"},
    {"<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent files", mode = "n"},
    {"<leader>fc", open_config_file, desc = "Open nvim config file", mode = "n"},
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
    {"<leader>ox", "gf", desc = "Open filepath under cursor", mode = "n"},
    {"<leader>oX", ":normal gx<cr>", desc = "Open filepath or URI under cursor", mode = "n"},
    {"<leader>od", "<cmd>Dashboard<cr>", desc = "Open dashboard", mode = "n"},

    -- Git
    {"<leader>g", group = "Git"},
    {"<leader>gg", "<cmd>Neogit<cr>", desc = "Open Neogit", mode = "n"},
    {"<leader>gh", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview hunk", mode = "n"},
    {"<leader>g]", "<cmd>Gitsigns nav_hunk next<cr>", desc = "Next hunk", mode = "n"},
    {"<leader>g[", "<cmd>Gitsigns nav_hunk prev<cr>", desc = "Prev hunk", mode = "n"},
    {"<leader>gs", "<cmd>Gitsigns stage_hunk<cr>", desc = "Stage hunk", mode = "n"},
    {"<leader>gR", "<cmd>Gitsigns reset_hunk<cr>", desc = "Reset hunk", mode = "n"},

    -- Code
    {"<leader>c", group = "Code"},
    {"<leader>cc", "<cmd>below Compile<cr>", desc = "Compile Command", mode = "n"},
    {"<leader>cC", "<cmd>below Recompile<cr>", desc = "Recompile Command", mode = "n"},
    {"<leader>ca", "<cmd>FzfLua lsp_code_actions<cr>", desc = "LSP code action", mode = "n"},
    {"<leader>ci", "<cmd>FzfLua lsp_implementations<cr>", desc = "LSP implementations", mode = "n"},
    {"<leader>cr", vim.lsp.buf.rename, desc = "LSP rename", mode = "n"},
    {"<leader>cD", "<cmd>FzfLua lsp_references<cr>", desc = "LSP references", mode = "n"},
    {"<leader>cd", "<cmd>FzfLua lsp_definitions<cr>", desc = "LSP definitions", mode = "n"},
    {"<leader>cx", "<cmd>FzfLua diagnostics_document<cr>", desc = "Show diagnostics", mode = "n"},
    {"<leader>cX", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Show diagnostics workspace", mode = "n"},
    {"<leader>cs", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "LSP symbols", mode = "n"},
    {"<leader>cS", "<cmd>FzfLua lsp_workspace_symbols<cr>", desc = "LSP symbols workspace", mode = "n"},
    {"<leader>ck", vim.lsp.buf.hover, desc = "LSP hover", mode = "n"},
    {"<leader>ce", vim.diagnostic.open_float, desc = "Open diagnostics float", mode = "n"},
    {"<leader>cf", vim.lsp.buf.format, desc = "Format buffer/region", mode = { "n", "v" }},

    -- Toggle
    {"<leader>t", group = "Toggle"},
    {"<leader>tc", toggle_cmp_auto_show, desc = "Toggle completion auto show", mode = "n"},
    {"<leader>tn", toggle_line_number, desc = "Toggle line number", mode = "n"},
    {"<leader>tr", toggle_relative_number, desc = "Toggle relative line number", mode = "n"},

    -- Help
    {"<leader>h", group = "Help"},
    {"<leader>hk", "<cmd>FzfLua keymaps<cr>", desc = "Show keymaps", mode = "n"},
    {"<leader>hm", "<cmd>FzfLua manpages<cr>", desc = "Show manpages", mode = "n"},
    {"<leader>hc", "<cmd>FzfLua commands<cr>", desc = "Show commands", mode = "n"},
    {"<leader>ho", "<cmd>FzfLua nvim_options<cr>", desc = "Show nvim options", mode = "n"},
    {"<leader>hh", "<cmd>FzfLua<cr>", desc = "Open FzfLua", mode = "n"},

    -- No Group
    {"<leader>/", "<cmd>FzfLua live_grep<cr>", desc = "Search project", mode = "n"},
    {"<leader><leader>", "<cmd>FzfLua files<cr>", desc = "Find file", mode = "n"},
    {"<M-x>", "<cmd>FzfLua commands<cr>", desc = "Execute command", mode = "n"},
    {"]e", jump_next_error, desc = "Next error", mode = "n"},
    {"[e", jump_prev_error, desc = "Prev error", mode = "n"},
    {"]g", "<cmd>Gitsigns nav_hunk next<cr>", desc = "Next git hunk", mode = "n"},
    {"[g", "<cmd>Gitsigns nav_hunk prev<cr>", desc = "Prev git hunk", mode = "n"},
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
