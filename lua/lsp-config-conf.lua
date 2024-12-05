require('mason').setup()
require('mason-lspconfig').setup()

local lsp_config = require('lspconfig')
lsp_config.lua_ls.setup {}

