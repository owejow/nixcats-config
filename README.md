# Neovim Configuraiton Using `nixCats`

The configuraiton is utilizes [nixCats](https://github.com/BirdeeHub/nixCats-nvim)
package manager. This package manager utlizes regular lua mechanism for
configuring packages.

> - `nixCats` is responsible for downloading all plugins.
> - Plugins are only loaded if their respective category is enabled.

## Debugging

Following snppet is useful to outputing loaded packages to output.txt

```lua
    local output = vim.inspect(package.loaded)
    vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(output, "\n"))
    vim.cmd("w! output.txt")

```
