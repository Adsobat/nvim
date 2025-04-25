local plugin = {
  'ibhagwan/fzf-lua',
  -- optional for icon support
  dependencies = {
    { 'junegunn/fzf', build = './install --bin' },
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require("which-key").add(
      {
        {"<leader>z", group = "fzf"}
      });
    vim.keymap.set('n', '<leader>zg', ':FzfLua live_grep_native<CR>', { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>zG', ':FzfLua live_grep_glob<CR>', { desc = '[S]earch by [G]rep with glob suppert' })
    vim.keymap.set('n', '<leader>z<leader>', ':FzfLua buffers<CR>', { desc = '[S]earch by [B]uffers' })
    vim.keymap.set('n', '<leader>zf', ':FzfLua files<CR>', { desc = '[S]earch by [F]iles' })

    vim.keymap.set('n', '<leader>z?', ':FzfLua keymaps<CR>', { desc = 'Search Keymaps' })
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
--return plugin
return plugin
