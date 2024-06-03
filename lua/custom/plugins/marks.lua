local plugins = {
  {
    'chentoast/marks.nvim',
    config = function()
      require('marks').setup {}
    end,
  },
}

return plugins
