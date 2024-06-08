local plugins = {
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    branch = 'stable',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      ---- set use_icons to true if you have a Nerd Font
      statusline.setup {
        -- Content of statusline as functions which return statusline string. See
        -- `:h statusline` and code of default contents (used instead of `nil`).
        content = {
          -- Content for active window
          active = nil,
          -- Content for inactive window(s)
          inactive = nil,
        },

        -- Whether to use icons by default

        -- Whether to set Vim's settings for statusline (make it always shown with
        -- 'laststatus' set to 2). To use global statusline in Neovim>=0.7.0, set
        -- this to `false` and 'laststatus' to 3.
        set_vim_settings = false,

        use_icons = vim.g.have_nerd_font,
      }

      ---- You can configure sections in the statusline by overriding their
      ---- default behavior. For example, here we set the section for
      ---- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
}

return plugins
