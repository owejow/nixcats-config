require("myLuaConf.plugins.colorscheme")
require("myLuaConf.plugins.oil")
require("myLuaConf.plugins.icons")
require("myLuaConf.plugins.tiny-inline-diagnostic")

-- NOTE: you can check if you included the category with the thing wherever you want.
require("lze").load({
	{ import = "myLuaConf.plugins.treesitter" },
	{ import = "myLuaConf.plugins.fzf-lua" },
	{ import = "myLuaConf.plugins.completion" },
	{ import = "myLuaConf.plugins.which-key" },
	{ import = "myLuaConf.plugins.nvim-surround" },
	{ import = "myLuaConf.plugins.nvim-tree" },
	{ import = "myLuaConf.plugins.lualine" },
	{ import = "myLuaConf.plugins.bufferline-nvim" },
	{ import = "myLuaConf.plugins.blankline" },
	{ import = "myLuaConf.plugins.undotree" },
	{ import = "myLuaConf.plugins.git" },
	{ import = "myLuaConf.plugins.folding" },
	{ import = "myLuaConf.plugins.notifications" },
	{
		"markdown-preview.nvim",
		-- NOTE: for_cat is a custom handler that just sets enabled value for us,
		-- based on result of nixCats('cat.name') and allows us to set a different default if we wish
		-- it is defined in luaUtils template in lua/nixCatsUtils/lzUtils.lua
		-- you could replace this with enabled = nixCats('cat.name') == true
		-- if you didnt care to set a different default for when not using nix than the default you already set
		for_cat = "markdown",
		cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
		ft = "markdown",
		keys = {
			{ "<leader>mp", "<cmd>MarkdownPreview <CR>", mode = { "n" }, noremap = true, desc = "markdown preview" },
			{
				"<leader>ms",
				"<cmd>MarkdownPreviewStop <CR>",
				mode = { "n" },
				noremap = true,
				desc = "markdown preview stop",
			},
			{
				"<leader>mt",
				"<cmd>MarkdownPreviewToggle <CR>",
				mode = { "n" },
				noremap = true,
				desc = "markdown preview toggle",
			},
		},
		before = function(plugin)
			vim.g.mkdp_auto_close = 0
		end,
	},
	{
		"comment.nvim",
		for_cat = "general.extra",
		event = "DeferredUIEnter",
		after = function(plugin)
			require("Comment").setup()
		end,
	},

	{
		"vim-startuptime",
		for_cat = "general.extra",
		cmd = { "StartupTime" },
		before = function(_)
			vim.g.startuptime_event_width = 0
			vim.g.startuptime_tries = 10
			vim.g.startuptime_exe_path = nixCats.packageBinPath
		end,
	},
	{
		"fidget.nvim",
		for_cat = "general.extra",
		event = "DeferredUIEnter",
		-- keys = "",
		after = function(plugin)
			require("fidget").setup({})
		end,
	},
	-- {
	--   "hlargs",
	--   for_cat = 'general.extra',
	--   event = "DeferredUIEnter",
	--   -- keys = "",
	--   dep_of = { "nvim-lspconfig" },
	--   after = function(plugin)
	--     require('hlargs').setup {
	--       color = '#32a88f',
	--     }
	--     vim.cmd([[hi clear @lsp.type.parameter]])
	--     vim.cmd([[hi link @lsp.type.parameter Hlargs]])
	--   end,
	-- },
})
