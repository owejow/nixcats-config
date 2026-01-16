return {
	{
		"nvim-notify",
		for_cat = "notifications",
		lazy = false,
		after = function(_)
			local notify = require("notify")
			notify.setup({
				on_open = function(win)
					vim.api.nvim_win_set_config(win, { focusable = false })
				end,
				merge_duplicates = false,
			})
			vim.notify = notify
			vim.keymap.set("n", "<Esc>", function()
				notify.dismiss({ silent = true, pending = true })
			end, { desc = "dismiss notify popup and clear hlsearch" })
		end,
	},

	{
		"nui.nvim",
		for_cat = "notifications",
		lazy = false,
	},
	{
		"noice.nvim",
		for_cat = "notifications",
		lazy = false,
		dependencies = {
			"nui.nvim",
			"nvim-notify",
		},
		after = function(_)
			require("noice").setup({
				lsp = {
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
				},
			})
		end,
	},
}
