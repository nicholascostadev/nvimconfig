return {
	"goolord/alpha-nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		dashboard.section.buttons.val = {
			dashboard.button("<Leader>e", "  File Explorer"),
			dashboard.button("<Leader>ff", "  Find File"),
			dashboard.button("<Leader>fg", "  Find Word"),
			dashboard.button("<Leader>sr", "  Restore Session"),
			dashboard.button("q", "  Quit", ":qa<cr>"),
		}

		alpha.setup(dashboard.opts)
	end,
}
