return {
  { "blink-nerdfont.nvim", event = "DeferredUIEnter", for_cat = "general.blink" },

  { "blink-emoji.nvim", event = "DeferredUIEnter", for_cat = "general.blink" },
  {
    "luasnip",
    for_cat = "completion",
    dep_of = { "blink.cmp" },
    after = function(_)
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()
      luasnip.config.setup({})
      local ls = require("luasnip")
      vim.keymap.set({ "i", "s" }, "<M-n>", function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end)
    end,
  },
  {
    "blink.cmp",
    for_cat = "completion",
    event = "DeferredUIEnter",
    after = function(_)
      require("blink-cmp").setup({
        appearance = { nerd_font_variant = "mono", use_nvim_cmp_as_default = true },
        cmdline = { completion = { list = { selection = { preselect = false } }, menu = { auto_show = true } } },
        completion = {
          documentation = { auto_show = true, window = { border = "rounded" } },
          ghost_text = { enabled = true },
          list = { selection = { auto_insert = false, preselect = true } },
          menu = { border = "rounded" },
        },
        fuzzy = { implementation = "rust", prebuilt_binaries = { download = false } },
        keymap = { preset = "default" },
        signature = { enabled = true, window = { border = "rounded" } },
        sources = {
          default = { "buffer", "emoji", "lsp", "nerdfont", "path", "snippets" },
          providers = {
            emoji = { module = "blink-emoji", name = "Emoji", score_offset = 1 },
            lsp = { score_offset = 4 },
            nerdfont = {
              module = "blink-nerdfont",
              name = "Nerd Fonts",
              opts = { insert = true },
              score_offset = 15,
            },
          },
        },
      })
    end,
  },
}
