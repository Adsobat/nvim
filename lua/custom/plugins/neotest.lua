return {
  {
    'quolpr/quicktest.nvim',
    opts = {},
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'm00qek/baleia.nvim',
      {
        'rcasia/neotest-java',
        init = function()
          -- override the default keymaps.
          -- needed until neotest-java is integrated in LazyVim
        end,
      },
    },
    keys = function()
      local qt = function()
        return require 'quicktest'
      end

      local keys = {
        {
          '<leader>tr',
          function()
            -- current_win_mode return currently opened panel, split or popup
            qt().run_line(qt().current_win_mode())
            -- You can force open split or popup like this:
            -- qt().run_current('split')
            -- qt().run_current('popup')
          end,
          desc = '[T]est [R]un',
        },
        {
          '<leader>tR',
          function()
            qt().run_file(qt().current_win_mode())
          end,
          desc = '[T]est [R]un file',
        },
        {
          '<leader>tt',
          function()
            qt().toggle_win 'popup'
          end,
          desc = '[T]est [T]toggle result',
        },
        {
          '<leader>ts',
          function()
            qt().toggle_win 'split'
          end,
          desc = '[T]est [S]plit result',
        },

        {
          '<leader>tp',
          function()
            qt().run_previous(qt().current_win_mode())
          end,
          desc = '[T]est [P]revious',
        },

        adapters = {
          ['neotest-java'] = {
            -- config here
          },
        },
      }

      return keys
    end,
  },
}
