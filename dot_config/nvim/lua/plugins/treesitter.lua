return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			-- Note: comment out next line to turn off auto install
			auto_install = true,
			ensure_installed = {
				"c",
				"cpp",
				"cmake",
				"bash",
				"json",
				"toml",
				"rust",
				"lua",
				"vim",
				"javascript",
				"html",
				"typescript",
				"markdown",
				"markdown_inline",
			},
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
