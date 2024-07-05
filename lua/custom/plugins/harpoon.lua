local plugin = {
  'ThePrimeagen/harpoon',

  config = function()
    vim.keymap.set('n', '<leader>m', function()
      require('harpoon.mark').add_file()
    end, { desc = '[m]ark Harpoon' })
    vim.keymap.set('n', '<leader>sH', function()
      require('harpoon.ui').toggle_quick_menu()
    end, { desc = 'Search [H]arpoon Files' })
    return {}
  end,
}
return plugin
