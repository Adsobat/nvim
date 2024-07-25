local plugins = {
  {
    'akinsho/bufferline.nvim',
    version = '*',
    --   config = function()
    --     require('marks').setup {}
    --   end,

    --- count is an integer representing total count of errors
    --- level is a string "error" | "warning"
    --- diagnostics_dict is a dictionary from error level ("error", "warning" or "info")to number of errors for each level.
    --- this should return a string
    --- Don't get too fancy as this function will be executed a lot
    themable = true,
    config = function(options)
      local status, bufferline = pcall(require, 'bufferline')
      local status, whichkey = pcall(require, 'which-key.plugins.presets')
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
          numbers = function(opts)
            return string.format('%s|%s', opts.id, opts.raise(opts.ordinal))
          end,
          max_name_length = 15,
          max_prefix_length = 6,
          diagnostics = 'nvim_lsp',
          show_buffer_icons = true,
          show_buffer_close_icons = false,
          show_close_icon = false,
          persist_buffer_sort = true,
          enforce_regular_tabs = true,
          diagnostics_indicator = function(count, level)
            local icon = level:match 'error' and '   ' or '   '
            return icon .. count
          end,
        },
      }
      --      local bufferline = require 'bufferline'
      for i = 1, 9 do
        local hotkey = '<leader>' .. i
        vim.api.nvim_set_keymap(
          'n', -- Mode (normal mode)
          hotkey,
          -- bufferline.go_to(i, true)
          ':lua require("bufferline").go_to('
            .. i
            .. ')<CR>',
          { desc = 'which_key_ignore', noremap = true, silent = true } -- Options (non-recursive and silent)
        )
      end
    end,
  },
}
return plugins
