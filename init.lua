-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false

-- [[ Setting options ]]
require 'options'

-- [[ Basic Keymaps ]]
require 'keymaps'

-- [[ Install `lazy.nvim` plugin manager ]]
require 'lazy-bootstrap'

-- [[ Configure and install plugins ]]
require 'lazy-plugins'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
--
local status, bufferline = pcall(require, 'bufferline')
if not status then
  print 'ERROR bufferline'
  return
end

bufferline.setup {
  options = {
    indicator_icon = '▎',
    modified_icon = '●',
    buffer_close_icon = '',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    numbers = 'ordinal',
    max_name_length = 15,
    max_prefix_length = 6,
    diagnostics = 'nvim_lsp',
    show_buffer_icons = true,
    show_buffer_close_icons = false,
    show_close_icon = false,
    persist_buffer_sort = true,
    enforce_regular_tabs = true,
    diagnostics_indicator = function(count, level)
      local icon = level:match 'error' and '' or ''
      return icon .. count
    end,
  },
}
