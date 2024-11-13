return {
	"willothy/moveline.nvim",
	build = "make",
	config = function()
		local moveline = require("moveline")
		vim.keymap.set("n", "<M-k>", moveline.up)
		vim.keymap.set("n", "<M-j>", moveline.down)
		vim.keymap.set("v", "<M-k>", moveline.block_up)
		vim.keymap.set("v", "<M-j>", moveline.block_down)

		vim.keymap.set("n", "<M-Up>", moveline.up)
		vim.keymap.set("n", "<M-Down>", moveline.down)
		vim.keymap.set("v", "<M-Up>", moveline.block_up)
		vim.keymap.set("v", "<M-Down>", moveline.block_down)
	end,
}
