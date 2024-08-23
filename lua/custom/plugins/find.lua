local plugin = {
  'ibhagwan/fzf-lua',
  -- optional for icon support
  dependencies = {
    { 'junegunn/fzf', build = './install --bin' },
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    vim.keymap.set('n', '<leader>sg', ':FzfLua grep_visual<CR>', { desc = '[S]earch by [G]rep' })

    vim.keymap.set('n', '<leader>?', ':FzfLua keymaps<CR>', { desc = 'Search Keymaps' })
    -- calling `setup` is optional for customization
    require('fzf-lua').setup {}
  end,
}
--local plugin = {
--  'junegunn/fzf',
--  dir = '~/.fzf',
--  build = './install --all',
--  name = 'fzf',
--  config = function()
--    vim.keymap.set('n', '<leader>sg', ':FZF grep_visual<CR>', { desc = '[S]earch by [G]rep' })
--  end,
--}
return plugin
