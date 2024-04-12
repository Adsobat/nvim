local lspconfig = require('lspconfig')
local lspzero = require('lsp-zero')

-- Configure jdtls with Lombok
lspconfig.jdtls.setup(lspzero.make_config({
  name = 'jdtls',
  cmd = {'java-ls'},
  filetypes = {'java'},
  root_dir = lspconfig.util.root_pattern('pom.xml', 'gradle.build', '.git'),
  settings = {
    java = {
      signatureHelp = { enabled = true },
      completion = {
        favoriteStaticMembers = {
          'org.hamcrest.MatcherAssert.assertThat',
          'org.hamcrest.Matchers.*',
          'org.hamcrest.CoreMatchers.*',
          'org.junit.jupiter.api.Assertions.*',
          'java.util.Objects.requireNonNull',
          'java.util.Objects.requireNonNullElse',
          'org.mockito.Mockito.*'
        }
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999
        }
      },
      configuration = {
        runtimes = {
          {
            name = 'JavaJDK-11',
            path = '/usr/lib/jvm/jdk-11'
          },

          {
            name = 'JavaJDK-17',
            path = '/usr/lib/jvm/zulu17'
          },
        }
      },
      codeGeneration = {
        lombok = {
          enabled = true
        }
      }
    }
  }
}))

-- Configure Lua
lspconfig.sumneko_lua.setup(lspzero.make_config({
  name = 'sumneko_lua',
  cmd = {'lua-language-server'},
  filetypes = {'lua'},
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = vim.split(package.path, ';')
      },
      diagnostics = {
        globals = {'vim'}
      },
      workspace = {
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
        }
      }
    }
  }
}))

-- Configure Mason
lspconfig.mason.setup(lspzero.make_config({
  name = 'mason',
  cmd = {'mason-lsp'},
  filetypes = {'mason'}
}))
