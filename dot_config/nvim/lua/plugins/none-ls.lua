-- This module contains support for linters and formatters
-- Note: all sources should be install via Mason

return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				-- Note: Also glsl shaders support
				null_ls.builtins.formatting.clang_format.with({
					filetypes = { "c", "cpp", "glsl", "vert", "frag", "tesc", "tese", "geom", "comp" },
				}),
				null_ls.builtins.formatting.prettier,
				-- null_ls.builtins.diagnostics.eslint,
			},
		})

		-- Global maps
		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
