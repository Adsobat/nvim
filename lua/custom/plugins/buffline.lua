local plugins = {
  {
    'akinsho/bufferline.nvim',
    version = '*',
    config = function()
      require('marks').setup {}
    end,

    dependencies = 'nvim-tree/nvim-web-devicons',
  },
}

return plugins
