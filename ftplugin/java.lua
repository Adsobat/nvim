local nvim_path = vim.fn.expand '$HOME/.config/nvim/'
local jdtt_language_server_path = vim.fn.expand '$HOME/Downloads/jdt-language-server-1.9.0-202203031534/'
local current_cwd = vim.fn.getcwd()

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {
    -- 💀
    'java', -- or '/path/to/java17_or_newer/bin/java'
    -- depends on if `java` is in your $PATH env variable and if it points to the right version.

    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens',
    'java.base/java.util=ALL-UNNAMED',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',
    --TODO: lombock muss noch configuriert werden
    '-javaagent:'
      .. nvim_path
      .. 'dep/lombok.jar',
    -- ✔️✔️

    '-jar',
    jdtt_language_server_path .. 'plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
    -- Must point to the                                                     Change this to
    -- eclipse.jdt.ls installation                                           the actual version

    -- ✔️
    '-configuration',
    jdtt_language_server_path .. 'config_linux',
    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
    -- Must point to the                      Change to one of `linux`, `win` or `mac`
    -- eclipse.jdt.ls installation            Depending on your system.

    -- 💀
    '-data',
    '/tmp/workspace/' .. current_cwd,
  },

  -- 💀
  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  --
  -- vim.fs.root requires Neovim 0.10.
  -- If you're using an earlier version, use: require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
  root_dir = vim.fs.root(0, { '.git', 'mvnw', 'gradlew' }),

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
      signatureHelp = { enabled = true },
      import = { enabled = true },
      rename = { enabled = true },
    },
  },

  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  init_options = {
    bundles = {
      -- vim.fn.expand '$HOME/.local/share/nvim/lazy/java-debug/com.microsoft.java.debug.repository/target/repository/plugins/com.microsoft.java.debug.plugin_0.53.0.jar',
      vim.fn.glob(
        vim.fn.expand '$HOME/.config/nvim/dep/java-debug/com.microsoft.java.debug.repository/target/repository/plugins/com.microsoft.java.debug.plugin_0.53.0.jar',
        1
      ),
    },
  },
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require('jdtls').start_or_attach(config)

--local config = {
--  cmd = {
--    '/home/jusc6/Downloads/jdt-language-server-1.9.0-202203031534/bin/jdtls',
--    ('--jvm-arg=-javaagent:%s'):format(vim.fn.expand '$HOME/.config/nvim/dep/lombok.jar'),
--  },
--  capabilities = require('cmp_nvim_lsp').default_capabilities(),
--  bundles = { vim.fn.expand '$HOME/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar' },
--  root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw', 'pom.xml' }, { upward = true })[1]),
--}

--require('jdtls').start_or_attach(config)
--
--

--local port = '5012'
--local dap = require 'dap'
--dap.adapters.java = function(callback)
--  -- FIXME:
--  -- Here a function needs to trigger the `vscode.java.startDebugSession` LSP command
--  -- The response to the command must be the `port` used below
--  callback {
--    type = 'server',
--    host = '127.0.0.1',
--    port = port,
--  }
--end
