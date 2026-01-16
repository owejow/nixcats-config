-- keymaps
-- You can use the capture groups defined in `textobjects.scm`

return {
  "fzf-lua",
  for_cat = "general.fzf-lua",
  event = "DeferredUIEnter",
  after = function(_)
    local fzf = require("fzf-lua")
    local config = fzf.config
    local actions = fzf.actions
    local img_previewer ---@type string[]?
    for _, v in ipairs({
      { cmd = "ueberzug", args = {} },
      { cmd = "chafa", args = { "{file}", "--format=symbols" } },
      { cmd = "viu", args = { "-b" } },
    }) do
      if vim.fn.executable(v.cmd) == 1 then
        img_previewer = vim.list_extend({ v.cmd }, v.args)
        break
      end
    end
    -- Quickfix
    config.defaults.keymap.fzf["ctrl-q"] = "select-all+accept"
    config.defaults.keymap.fzf["ctrl-u"] = "half-page-up"
    config.defaults.keymap.fzf["ctrl-d"] = "half-page-down"
    config.defaults.keymap.fzf["ctrl-x"] = "jump"
    config.defaults.keymap.fzf["ctrl-f"] = "preview-page-down"
    config.defaults.keymap.fzf["ctrl-b"] = "preview-page-up"
    config.defaults.keymap.builtin["<c-f>"] = "preview-page-down"
    config.defaults.keymap.builtin["<c-b>"] = "preview-page-up"
    fzf.setup({
      "default-title",
      fzf_colors = true,
      fzf_opts = { ["--no-scrollbar"] = true },
      previewers = {
        builtin = {
          extensions = {
            ["png"] = img_previewer,
            ["jpg"] = img_previewer,
            ["jpeg"] = img_previewer,
            ["gif"] = img_previewer,
            ["webp"] = img_previewer,
          },
          ueberzug_scaler = "fit_contain",
        },
      },
      ui_select = function(fzf_opts, items)
        return vim.tbl_deep_extend("force", fzf_opts, {
          prompt = " ",
          winopts = {
            title = " " .. vim.trim((fzf_opts.prompt or "Select"):gsub("%s*:%s*$", "")) .. " ",
            title_pos = "center",
          },
        }, fzf_opts.kind == "codeaction" and {
          winopts = {
            layout = "vertical",
            -- height is number of items minus 15 lines for the preview, with a max of 80% screen height
            height = math.floor(math.min(vim.o.lines * 0.8 - 16, #items + 4) + 0.5) + 16,
            width = 0.5,
            preview = not vim.tbl_isempty(vim.lsp.get_clients({ bufnr = 0, name = "vtsls" })) and {
              layout = "vertical",
              vertical = "down:15,border-top",
              hidden = "hidden",
            } or {
              layout = "vertical",
              vertical = "down:15,border-top",
            },
          },
        } or {
          winopts = {
            width = 0.5,
            -- height is number of items, with a max of 80% screen height
            height = math.floor(math.min(vim.o.lines * 0.8, #items + 4) + 0.5),
          },
        })
      end,
      winopts = {
        width = 0.8,
        height = 0.8,
        row = 0.5,
        col = 0.5,
        preview = {
          scrollchars = { "┃", "" },
        },
      },
      keymap = {
        builtin = {
          true,
        },
        fzf = {
          true,
        },
      },
      files = {
        cwd_prompt = false,
        actions = {
          ["alt-i"] = { actions.toggle_ignore },
          ["alt-h"] = { actions.toggle_hidden },
        },
      },
      grep = {
        actions = {
          ["alt-i"] = { actions.toggle_ignore },
          ["alt-h"] = { actions.toggle_hidden },
        },
      },
      lsp = {
        symbols = {
          symbol_hl = function(s)
            return "TroubleIcon" .. s
          end,
          symbol_fmt = function(s)
            return s:lower() .. "\t"
          end,
          child_prefix = false,
        },
        code_actions = {
          previewer = vim.fn.executable("delta") == 1 and "codeaction_native" or nil,
        },
      },
    })
    vim.keymap.set("t", "<c-j>", "<c-j>", { noremap = true, nowait = true })
    vim.keymap.set("t", "<c-k>", "<c-k>", { noremap = true, nowait = true })
    vim.keymap.set("n", "<leader>,", function()
      require("fzf-lua").buffers({ sort_mru = true, sort_lastused = true })
    end, { desc = "Switch Buffer", noremap = true })
    vim.keymap.set("n", "<leader>/", function()
      require("fzf-lua").live_grep()
    end, { desc = "Live Grep", noremap = true })

    vim.keymap.set("n", "<leader>:", function()
      require("fzf-lua").command_history()
    end, { desc = "Command History", noremap = true })

    vim.keymap.set("n", "<leader>fb", function()
      require("fzf-lua").files({ sort_mru = true, sort_lastused = true })
    end, { desc = "Buffers (all)", noremap = true })

    vim.keymap.set("n", "<leader>ff", function()
      require("fzf-lua").files()
    end, { desc = "Find Files (Root Dir)", noremap = true })

    vim.keymap.set("n", "<leader>fg", function()
      require("fzf-lua").git_files()
    end, { desc = "Find Files (git-files)", noremap = true })

    -- git
    vim.keymap.set("n", "<leader>Gc", function()
      require("fzf-lua").git_commits()
    end, { desc = "Git Commits", noremap = true })

    vim.keymap.set("n", "<leader>Gs", function()
      require("fzf-lua").git_status()
    end, { desc = "Git Status", noremap = true })

    vim.keymap.set("n", "<leader>GS", function()
      require("fzf-lua").git_stash()
    end, { desc = "Git Stash", noremap = true })

    vim.keymap.set("n", "<leader>r", function()
      require("fzf-lua").registers()
    end, { desc = "Registers", noremap = true })

    vim.keymap.set("n", "<leader>s/", function()
      require("fzf-lua").search_history()
    end, { desc = "Search History", noremap = true })

    vim.keymap.set("n", "<leader>sc", function()
      require("fzf-lua").command_history()
    end, { desc = "Command History", noremap = true })

    vim.keymap.set("n", "<leader>sC", function()
      require("fzf-lua").commands()
    end, { desc = "Commands", noremap = true })

    vim.keymap.set("n", "<leader>sd", function()
      require("fzf-lua").diagnostics_workspace()
    end, { desc = "Diagnostics", noremap = true })

    vim.keymap.set("n", "<leader>sD", function()
      require("fzf-lua").diagnostics_document()
    end, { desc = "Buffer Diagnostics", noremap = true })

    vim.keymap.set("n", "<leader>sg", function()
      require("fzf-lua").live_grep()
    end, { desc = "Grep (Root Dir)", noremap = true })

    vim.keymap.set("n", "<leader>sG", function()
      require("fzf-lua").live_grep({ root = false })
    end, { desc = "Grep (cwd)", noremap = true })

    vim.keymap.set("n", "<leader>sh", function()
      require("fzf-lua").help_tags()
    end, { desc = "Help Pages", noremap = true })

    vim.keymap.set("n", "<leader>sH", function()
      require("fzf-lua").highlights()
    end, { desc = "Search Highlight Groups", noremap = true })

    vim.keymap.set("n", "<leader>sj", function()
      require("fzf-lua").jumps()
    end, { desc = "JumpList", noremap = true })

    vim.keymap.set("n", "<leader>sk", function()
      require("fzf-lua").keymaps()
    end, { desc = "Keymaps", noremap = true })

    vim.keymap.set("n", "<leader>sl", function()
      require("fzf-lua").loclist()
    end, { desc = "Location List", noremap = true })

    vim.keymap.set("n", "<leader>sM", function()
      require("fzf-lua").man_pages()
    end, { desc = "Search Man Pages", noremap = true })

    vim.keymap.set("n", "<leader>sm", function()
      require("fzf-lua").marks()
    end, { desc = "Marks", noremap = true })

    vim.keymap.set("n", "<leader>sR", function()
      require("fzf-lua").resume()
    end, { desc = "Resume", noremap = true })

    vim.keymap.set("n", "<leader>sq", function()
      require("fzf-lua").quickfix()
    end, { desc = "Quickfix List", noremap = true })

    vim.keymap.set("n", "<leader>sw", function()
      require("fzf-lua").grep_cword()
    end, { desc = "Word (Root Dir)", noremap = true })

    vim.keymap.set("n", "<leader>sW", function()
      require("fzf-lua").grep_cword({ root = false })
    end, { desc = "Word (cwd)", noremap = true })

    vim.keymap.set("n", "<leader>uC", function()
      require("fzf-lua").colorschemes()
    end, { desc = "Colorscheme with Preview", noremap = true })
  end,
}
