local function my_on_attach(bufnr)
  local api = require 'nvim-tree.api'

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end
  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent, opts 'Up')
  vim.keymap.set('n', '?', api.tree.toggle_help, opts 'Help')
end

local plugin = {
  'nvim-tree/nvim-tree.lua',
  config = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    vim.keymap.set(
      { 'n', 'v', 'i', 'c', 's', 'x', 'o', 't' },
      '<leader>e',
      '<Cmd>NvimTreeToggle <CR>',
      { desc = 'Open File view', noremap = true, silent = true, nowait = true }
    )
    -- optionally enable 24-bit colour
    vim.opt.termguicolors = true
    require('nvim-tree').setup {
      view = {
        width = 30,
      },
      renderer = {
        group_empty = true,
      },
      on_attach = my_on_attach,
    }
  end,
}

return plugin
