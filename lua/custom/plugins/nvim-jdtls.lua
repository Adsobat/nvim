local plugin = {
  {
    'microsoft/java-debug',
    build = function()
      local plugin_path = vim.fn.stdpath 'data' .. '/lazy/java-debug'
      local command = 'cd ' .. plugin_path .. ' && ./mvnw clean install'
      -- TODO: run command async
      vim.fn.system(command)
    end,
  },
  'mfussenegger/nvim-jdtls',
  dependency = {
    'mfussenegger/nvim-dap',
  },
}
--return plugin

return plugin
