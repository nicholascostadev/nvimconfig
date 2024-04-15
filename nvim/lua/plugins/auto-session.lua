return {
	"rmagatti/auto-session",
	config = function()
		require("auto-session").setup({
			log_level = "error",
			auto_session_supress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
			auto_restore_enabled = false,
			session_lens = {
				buftypes_to_ignore = {},
				load_on_setup = true,
				theme_conf = { border = true },
				previewer = false,
			},
		})

		vim.keymap.set("n", "<leader>sr", ":SessionRestore<CR>", {
			noremap = true,
		})
		vim.keymap.set("n", "<leader>sl", require("auto-session.session-lens").search_session, {
			noremap = true,
		})
	end,
}
