-- Better diagnostics support

return {
	{
		"folke/trouble.nvim",
		opts = {
			modes = {
				diagnostics = {
					win = {
						position = "right",
						size = 0.3,
					},
					preview = {
						type = "float",
						relative = "editor",
						border = "rounded",
						title = "Diagnostics preview",
						size = { width = 0.4, height = 0.8 },
						position = { 0.4, 0.4 },
						zindex = 200,
					},
				},
			},
		},
		cmd = "Trouble",
		keys = {
			{
				"<M-C-x>",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics toggle(Trouble)",
			},
			{
				"<leader>x",
				"<cmd>Trouble diagnostics focus<cr>",
				desc = "Diagnostics focus(Trouble)",
			},
			-- {
			-- 	"<leader>xX",
			-- 	"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
			-- 	desc = "Buffer Diagnostics (Trouble)",
			-- },
			-- {
			-- 	"<leader>cs",
			-- 	"<cmd>Trouble symbols toggle focus=false<cr>",
			-- 	desc = "Symbols (Trouble)",
			-- },
			-- {
			-- 	"<leader>cl",
			-- 	"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
			-- 	desc = "LSP Definitions / references / ... (Trouble)",
			-- },
			-- {
			-- 	"<leader>xL",
			-- 	"<cmd>Trouble loclist toggle<cr>",
			-- 	desc = "Location List (Trouble)",
			-- },
			-- {
			-- 	"<leader>xQ",
			-- 	"<cmd>Trouble qflist toggle<cr>",
			-- 	desc = "Quickfix List (Trouble)",
			-- },
		},
	},
	-- Workscpace wide diagnostics support
	{
		"artemave/workspace-diagnostics.nvim",
	},
}
