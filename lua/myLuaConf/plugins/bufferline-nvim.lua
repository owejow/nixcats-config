return {
  "bufferline",
  for_cat = "general.always",
  -- cmd = { "" },
  event = "DeferredUIEnter",
  -- ft = "",
  -- keys = "",
  -- colorscheme = "",
  keys = {
    { "<S-h>", "<cmd>BufferLineCyclePrev <CR>", mode = { "n" }, noremap = true, desc = "Prev Buffer" },
    { "<S-l>", "<cmd>BufferLineCycleNext <CR>", mode = { "n" }, noremap = true, desc = "Next Buffer" },
    {
      "<leader>bo",
      "<cmd>BufferLineCLoseOthers <CR>",
      mode = { "n" },
      noremap = true,
      desc = "Delete Other Buffers",
    },
    {
      "<leader>br",
      "<cmd>BufferLineCLoseRight <CR>",
      mode = { "n" },
      noremap = true,
      desc = "Delete Buffers to the Right",
    },
    {
      "<leader>bl",
      "<cmd>BufferLineCLoseLeft <CR>",
      mode = { "n" },
      noremap = true,
      desc = "Delete Buffers to the Left",
    },
  },
  after = function(plugin)
    require("bufferline").setup({
      options = {
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            text_align = "left",
            highlith = "Directory",
            separator = true,
          },
        },
      },
    })
  end,
}
