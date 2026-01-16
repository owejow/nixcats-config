
-- keymaps
-- You can use the capture groups defined in `textobjects.scm`

return {
  "nvim-origami",
  for_cat = "general.fzf-lua",
  event = "DeferredUIEnter",
  after = function(_)
    require("origami").setup({})
  end,
}
