local ok, notify = pcall(require, "tiny-inline-diagnostic")
if ok then
  require("tiny-inline-diagnostic").setup({
    preset = "modern",
  })
end
