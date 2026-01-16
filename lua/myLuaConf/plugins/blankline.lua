return {
	"indent-blankline.nvim",
	for_cat = "general",
	event = "DeferredUIEnter",
	after = function(plugin)
		require("ibl").setup()
	end,
}
