local configs = {
	luacheck = {
		pattern = "[^:]+:(%d+):(%d+)-(%d+): %((%a)(%d+)%) (.*)",
		groups = { "lnum", "col", "end_col", "severity", "code", "message" },
	},
	severities = {
		W = vim.diagnostic.severity.WARN,
		E = vim.diagnostic.severity.ERROR,
	},
}
require("lze").load({
	{
		"nvim-lint",
		for_cat = "lint",
		-- cmd = { "" },
		event = "FileType",
		-- ft = "",
		-- keys = "",
		-- colorscheme = "",
		after = function(plugin)
			local lint = require("lint")
			lint.linters_by_ft = {
				-- NOTE: download some linters in lspsAndRuntimeDeps
				-- and configure them here
				bash = { "shellcheck" },
				c = { "clangtidy" },
				cpp = { "clangtidy" },
				css = { "stylelint" },
				go = { "golangcilint" },
				html = { "htmlhint" },
				javascript = { "biomejs" },
				lua = { "luacheck" },
				markdown = { "markdownlint-cli2" },
				sh = { "shellcheck" },
				sql = { "sqlfluff" },
				typescript = { "biomejs" },
				yaml = { "yamllint" },
			}
			lint.linters.luacheck = {
				name = "luacheck",
				cmd = "luacheck",
				stdin = true,
				args = { "--formatter", "plain", "--codes", "--ranges", "--globals", "vim", "-" },
				ignore_exitcode = true,
				parser = require("lint.parser").from_pattern(
					configs.luacheck.pattern,
					configs.luacheck.groups,
					configs.severities,
					{ ["source"] = "luacheck" },
					{ end_col_offset = 0 }
				),
			}
			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
})
