vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
local plugins = {
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        priority = 1000,
        config = function()
            require('catppuccin').setup({
                flavour = 'mocha',
                integrations = {
                ufo = true,
                treesitter = true,
                cmp = true
            }
            })
            vim.cmd.colorscheme 'catppuccin'
        end,
    },
    { 'williamboman/mason.nvim',             dependencies = { 'williamboman/mason-lspconfig.nvim', 'neovim/nvim-lspconfig' } },
    { 'folke/neodev.nvim',                   opts = {} },
    { 'folke/which-key.nvim',                opts = {} },
    { 'nvim-lualine/lualine.nvim',           opts = {} },
    { 'numToStr/Comment.nvim',               opts = {} },
    { 'lukas-reineke/indent-blankline.nvim', main = 'ibl',                                                                   opts = {} },

    {
        -- Autocompletion
        'hrsh7th/nvim-cmp',
        dependencies = {
            -- Snippet Engine & its associated nvim-cmp source
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',

            -- Adds LSP completion capabilities
            'hrsh7th/cmp-nvim-lsp',

            -- Adds a number of user-friendly snippets
            'rafamadriz/friendly-snippets',
        },
    },
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            -- Fuzzy Finder Algorithm which requires local dependencies to be built.
            -- Only load if `make` is available. Make sure you have the system
            -- requirements installed.
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                -- NOTE: If you are having trouble with this installation,
                --       refer to the README for telescope-fzf-native for more instructions.
                build = 'make',
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
        },
    },
    {
        -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ':TSUpdate',
    },
    { 'kevinhwang91/nvim-ufo', dependencies = { 'kevinhwang91/promise-async' } }
}

require('lazy').setup(plugins, {})
require('mason').setup()
require('mason-lspconfig').setup()

local lsp_config = require('lspconfig')
lsp_config.lua_ls.setup {}
lsp_config.csharp_ls.setup {}

vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true
vim.o.colorcolumn = '80'
vim.o.scrolloff = 5
vim.o.cursorline = true
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.termguicolors = true
pcall(require('telescope').load_extension, 'fzf')
require('nvim_cmp')
require('nvim_ufo')
