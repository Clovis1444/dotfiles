-- LSP plugins
return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "clangd",
                    "cmake",
                    "eslint",
                    "jsonls",
                    "marksman",
                    "rust_analyzer",
                    "harper_ls",
                    "yamlls",
                    "bashls",
                    "html",
                },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        -- Each LSP must be setup; pass lua table to setup to configure the LSP
        -- There is a global keymaps after LSPs setup
        config = function()
            -- Note: use next line to tel LSP to use nvim-cmp as a completion engine
            -- Each time you setup new LSP you should pass this variable to it
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- nvim-ufo capabilities
            capabilities.textDocument.foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
            }

            -- enable workspace-diagnostics
            local wd_func = function(client, bufnr)
                require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
            end

            local lspconfig = require("lspconfig")

            -- IMPORTANT: Default setup table for all LSPs
            local def_setup = {
                on_attach = wd_func,
                capabilities = capabilities,
            }

            lspconfig.lua_ls.setup(def_setup)
            lspconfig.clangd.setup(def_setup)
            lspconfig.cmake.setup(def_setup)
            -- lspconfig.eslint.setup(def_setup)
            lspconfig.jsonls.setup(def_setup)
            lspconfig.marksman.setup(def_setup)
            lspconfig.rust_analyzer.setup({
                -- Server-specific settings. See `:help lspconfig-setup`
                settings = {
                    ["rust-analyzer"] = {},
                },
                capabilities = capabilities,
                on_attach = wd_func,
            })
            --lspconfig.harper_ls.setup(def_setup)
            lspconfig.yamlls.setup(def_setup)
            lspconfig.bashls.setup(def_setup)
            lspconfig.html.setup(def_setup)

            -- GLOBAL KEYMAPS
            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "dg", vim.lsp.buf.definition, {})
            vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
            vim.keymap.set("n", "<C-k>", vim.diagnostic.goto_prev, {})
            vim.keymap.set("n", "<C-j>", vim.diagnostic.goto_next, {})
            vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, {})
        end,
    },
}
