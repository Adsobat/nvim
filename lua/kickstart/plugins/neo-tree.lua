local function custom_renderer(item, config)
  local node = item.node
  local name = node.name
  local max_width = config.window.width
  local additional_info = ''
  -- Calculate the length of the file name and additional info
  local name_length = #name
  local file_size_str = ' ' .. node.stats.size

  -- If there is enough space, display the file size
  if max_width > name_length + #file_size_str then
    additional_info = file_size_str
  end

  item:add_child {
    text = name .. additional_info,
    highlight = config.highlight,
  }
end
-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim
local function copy_path(state)
  -- NeoTree is based on [NuiTree](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree)
  -- The node is based on [NuiNode](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree#nuitreenode)
  local node = state.tree:get_node()
  local filepath = node:get_id()
  local filename = node.name
  local modify = vim.fn.fnamemodify

  local results = {
    filepath,
    modify(filepath, ':.'),
    modify(filepath, ':~'),
    filename,
    modify(filename, ':r'),
    modify(filename, ':e'),
  }

  vim.ui.select({
    '1. Absolute path: ' .. results[1],
    '2. Path relative to CWD: ' .. results[2],
    '3. Path relative to HOME: ' .. results[3],
    '4. Filename: ' .. results[4],
    '5. Filename without extension: ' .. results[5],
    '6. Extension of the filename: ' .. results[6],
  }, { prompt = 'Choose to copy to clipboard:' }, function(choice)
    if choice then
      local i = tonumber(choice:sub(1, 1))
      if i then
        local result = results[i]
        vim.fn.setreg('"', result)
        vim.notify('Copied: ' .. result)
      else
        vim.notify 'Invalid selection'
      end
    else
      vim.notify 'Selection cancelled'
    end
  end)
end

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', { desc = 'NeoTree reveal' } },

    { '<leader>e', ':Neotree toggle<CR>', { desc = 'NeoTree toggle' } },
  },
  init_false = function()
    if vim.fn.argc(-1) == 1 then
      local stat = vim.loop.fs_stat(vim.fn.argv(0))
      if stat and stat.type == 'directory' then
        require('neo-tree').setup {
          filesystem = {
            hijack_netrw_behavior = 'open_current',
          },
        }
      end
    end
  end,
  --  opts = {
  --    filesystem = {
  --      group_empty_dirs = true,
  --      scan_mode = 'deep',
  --      window = {
  --        mappings = {
  --          ['\\'] = 'close_window',
  --        },
  --      },
  --    },
  --
  --    group_empty_dirs = true,
  --  },
  config = function()
    require('neo-tree').setup {
      close_if_last_window = true,
      default_component_configs = {
        container = {
          enable_character_fading = false,
        },
      },
      icons_enabled = true,
      renderer = custom_renderer,
      window = {
        position = 'left',
        width = 50,
        ['Y'] = copy_path,
      },
      filesystem = {
        group_empty_dirs = true,
        filtered_items = {
          visible = true,
          show_hidden_count = true,
          hide_dotfiles = false,
          hide_gitignored = false,
        },
        follow_current_file = {
          enabled = true,
          leave_dirs_open = false,
        },
      },
      buffers = {
        follow_current_file = {
          enabled = true, -- This will find and focus the file in the active buffer every time
          --              -- the current file is changed while the tree is open.
          leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
        },
      },
    }
  end,
}
