require("lze").load({
  {
    "conform.nvim",
    for_cat = "format",
    -- cmd = { "" },
    -- event = "",
    -- ft = "",
    keys = {
      { "<leader>FF", desc = "[F]ormat [F]ile" },
    },
    -- colorscheme = "",
    after = function(_) -- should be plugin
      local conform = require("conform")

      conform.setup({
        formatters_by_ft = {
          -- NOTE: download some formatters in lspsAndRuntimeDeps
          -- and configure them here
          -- lua = { "stylua" },
          go = { "goimports", "golines", "gofmt", "gofumpt" },
          javascript = { "prettierd", "biome", timeout_ms = 2000 },
          javascriptreact = { "prettierd", "biome", timeout_ms = 2000 },
          json = { "jq" },
          jsonc = { "prettierd" },
          html = { "prettierd" },
          less = { "prettierd" },
          lua = { "stylua" },
          markdown = { "prettierd" },
          nix = { "nixfmt" },
          rust = { "rustfmt", lsp_format = "fallback" },
          scss = { "prettierd" },
          shell = { "shellcheck", "shellharden", "shfmt" },
          toml = { "tombi" },
          typescript = { "prettierd", "biome", timeout_ms = 2000, stop_after_first = true },
          typescriptreact = { "prettierd", "biome", timeout_ms = 2000, stop_after_first = true },
          yaml = { "yamlfmt" },
          -- Conform will run multiple formatters sequentially
          -- python = { "isort", "black" },
          -- Use a sub-list to run only the first available formatter
        },
        formatters = {
          stylua = {
            append_args = { "--indent-type", "Spaces", "--indent-width", "2" },
          },
        },
        format_on_save = {
          timeout_ms = 2000,
          lsp_format = "fallback",
        },
      })

      vim.keymap.set({ "n", "v" }, "<leader>FF", function()
        conform.format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        })
      end, { desc = "[F]ormat [F]ile" })

      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function(args)
          require("conform").format({ bufnr = args.buf })
        end,
      })
    end,
  },
})
