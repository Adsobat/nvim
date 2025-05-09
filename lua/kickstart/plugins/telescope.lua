-- NOTE: Plugins can specify dependencies.
--
-- The dependencies are proper plugin specifications as well - anything
-- you do for a plugin at the top level, you can do for a dependency.
--
-- Use the `dependencies` key to specify the dependencies of a particular plugin

local plugin = {
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-live-grep-args.nvim',
        'smartpde/telescope-recent-files',
        -- This will not install any breaking changes.
        -- For major updates, this must be adjusted manually.
        version = '^1.1.0',
      },

      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
      { 'nvim-telescope/telescope-smart-history.nvim', dependencies = { 'kkharji/sqlite.lua' } },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      local telescope = require 'telescope'
      local lga_actions = require 'telescope-live-grep-args.actions'
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        defaults = {
          history = {
            path = '~/.local/share/nvim/databases/telescope_history.sqlite3',
            limit = 100,
          },
          --          path_display = function(opts, path)
          --            local tail = require('telescope.utils').path_tail(path)
          --            return string.format('%s > (%s)', tail, path)
          --          end,
        },
        mappings = {
          i = {
            ['<C-Down>'] = require('telescope.actions').cycle_history_next,
            ['<C-Up>'] = require('telescope.actions').cycle_history_prev,
            ['<c-enter>'] = 'to_fuzzy_refine',
          },
        },
        -- },
        -- pickers = {}
        extensions = {
          live_grep_args = {
            auto_qoting = true,
            layout_config = {
              prompt_position = "bottom",
              horizontal = {
                width_padding = 0.04,
                height_padding = 0.1,
                preview_width = 0.6,
              },
              vertical = {
                width_padding = 0.05,
                height_padding = 1,
                preview_height = 0.5,
              },
              layout_strategy = "horizontal",
            },
            vimgrep_arguments = {
              -- all required except `--smart-case`
              'rg',
              '--color=never',
              '--no-heading',
              '--with-filename',
              '--line-number',
              '--column',
              '--smart-case',

              -- add your options
            },

            mappings = {
              i = {
                ['<C-k>'] = lga_actions.quote_prompt(),
                ['<C-i>'] = lga_actions.quote_prompt { postfix = ' --iglob ' },
                ['<C-f>'] = lga_actions.quote_prompt { postfix = ' -t', desc = 'find search in files' },
                ['<C-Down>'] = require('telescope.actions').cycle_history_next,
                ['<C-Up>'] = require('telescope.actions').cycle_history_prev,
              },
            },
          },
          colorscheme = {
            enable_preview = true,
          },
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },

        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      pcall(require('telescope').load_extension, 'telescope-live-grep-args')
      pcall(require('telescope').load_extension, 'recent_files')
      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      local action_state = require 'telescope.actions.state'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>?', builtin.keymaps, { desc = 'Search Keymaps' })
      vim.keymap.set(
        'n',
        '<leader>F',
        [[<cmd>lua require('telescope').extensions.recent_files.pick()<CR>]],
        { desc = 'Search recent [F]iles', noremap = true, silent = true }
      )

      --https://github.com/nvim-telescope/telescope.nvim/issues/621#issuecomment-2094924716
      vim.keymap.set('n', '<leader><leader>', function()
        builtin.buffers({
          initial_mode = 'normal',
          attach_mappings = function(prompt_bufnr, map)
            local delete_buf = function()
              local current_picker = action_state.get_current_picker(prompt_bufnr)
              current_picker:delete_selection(function(selection)
                vim.api.nvim_buf_delete(selection.bufnr, { force = true })
              end)
            end

            map('n', '<c-q>', delete_buf)
            map('n', '<Del>', delete_buf)

            return true
          end,
        }, {
          sort_lastused = true,
          sort_mru = true,
          theme = 'dropdown',
        })
      end)
      --      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      --vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = '[b] Find existing buffers' })
      vim.keymap.set('n', '<leader>sg', ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", { desc = '[S]earch by [G]rep' })
      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
      telescope.load_extension 'live_grep_args'
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
--
return plugin
