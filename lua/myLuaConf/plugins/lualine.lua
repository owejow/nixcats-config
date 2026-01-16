local function get_color_scheme()
  return vim.api.nvim_exec2("colorscheme", { output = true }).output
end

return {
  "lualine.nvim",
  for_cat = "general.always",
  -- cmd = { "" },
  event = "DeferredUIEnter",
  -- ft = "",
  -- keys = "",
  after = function(plugin)
    require("lualine").setup({
      options = {
        theme = get_color_scheme(),
        globalstatus = false,
        icons_enabled = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1, file_status = true } },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {},

      --     sections = {
      --     lualine_a = { "mode" },
      --      	lualine_b = { "branch", "diff", "diagnostic" },
      --      	lualine_c = {
      --      		{
      --      			"filename",
      --      			path = 1,
      --      			status = true,
      --      		},
      --     	lualine_x = { "encoding", "fileformat", "filetype" },
      --     	lualine_y = { "progress" },
      --     	lualine_z = { "location" },
      --     },
      --     inactive_sections = {
      --     	lualine_c = { "filename" },
      --     	lualine_x = { "location" },
      --     	lualine_y = {},
      --     	lualine_z = {},
      --     },
      --     tabline = {},
      --     winbar = {},
      --     inactive_winbar = {},
      --     extensions = {},
      -- },
    })
  end,
}
