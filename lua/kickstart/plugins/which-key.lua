-- NOTE: Plugins can also be configured to run Lua code when they are loaded.
--
-- This is often very useful to both group configuration, as well as handle
-- lazy loading plugins that don't need to be loaded immediately at startup.
--
-- For example, in the following configuration, we use:
--  event = 'VimEnter'
--
-- which loads which-key before all the UI elements are loaded. Events can be
-- normal autocommands events (`:help autocmd-events`).
--
-- Then, because we use the `config` key, the configuration only runs
-- after the plugin has been loaded:
--  config = function() ... end

return {
  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',

    dependencies = {
      { 'nvim-tree/nvim-web-devicons' },
      { 'echasnovski/mini.icons' },
    },
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup()

      -- Document existing key chains
      require('which-key').add {

        { '<leader>s', group = '[S]earch' },
        { '<leader>q', group = '[Q]uite' },
        { '<leader>l', group = 'Switch headers' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>c', group = '[C]ode' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>h', group = 'Git [H]unk' },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>t', group = '[T]oggle' },
        { '', desc = '', hidden = true, mode = { 'n', 'n', 'n', 'n', 'n', 'n', 'n' } },
        --    ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
        --    ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
        --    ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
        --    ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
        --    ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
        --    ['<leader>t'] = { name = '[T]oggle', _ = 'which_key_ignore' },
        --    ['<leader>h'] = { name = 'Git [H]unk', _ = 'which_key_ignore' },
      }
      -- visual mode
      require('which-key').add {
        { '', group = 'Git [H]unk', mode = 'v' },
      }
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
