return {
	"rmagatti/auto-session",
	lazy = false,
	config = function()
		require("auto-session").setup({
			suppressed_dirs = { "~/", "~/dev", "~/Downloads", "/" },
			-- Execute all startup command here
			post_restore_cmds = {
				-- Open Neotree without focus
				":Neotree show",
			},
		})
	end,
}
