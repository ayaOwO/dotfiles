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
    {
        'folke/flash.nvim',
        event = "VeryLazy",
        opts = {},
        keys = {
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,   desc = "Flash" },
            { "f", mode = "o",               function() require("flash").remote() end, desc = "Remote Flash" },
        }
    },
    { 'williamboman/mason.nvim', dependencies = { 'williamboman/mason-lspconfig.nvim', 'neovim/nvim-lspconfig' } },
    { 'stevearc/overseer.nvim', opt = {} },
    { 'folke/twilight.nvim', opts = {} },
    { 'folke/neodev.nvim', opts = {} },
    { 'folke/todo-comments.nvim', dependencies = { "nvim-lua/plenary.nvim" }, opts = { TODO = { icon = " ", color = "info", alt = { "todo" } }, } }, -- TODO: allow for lower case todos
    { 'folke/which-key.nvim', lazy = true, opts = {} },
    { 'j-hui/fidget.nvim', opts = {} },
    { "max397574/better-escape.nvim", opts = {} },
    { "sindrets/diffview.nvim", opts = {} },
    { 'akinsho/bufferline.nvim', opts = {}, dependencies = 'nvim-tree/nvim-web-devicons' },
    { "akinsho/toggleterm.nvim", opts = {} },
    { "nvimtools/none-ls.nvim" }, -- NOTE: none-ls is not initiated
    { "tpope/vim-fugitive" },
    { "lewis6991/gitsigns.nvim", opts = {} },
    { "rhysd/committia.vim" },
    -- { "OmniSharp/omnisharp-vim" },
    { "Hoffs/omnisharp-extended-lsp.nvim" },
    {
        'nvim-lualine/lualine.nvim',

        dependencies = { "archibate/lualine-time" },
    },
    { 'numToStr/Comment.nvim',               opts = {} },
    { 'lukas-reineke/indent-blankline.nvim', main = 'ibl', opts = {} },

    {
        -- Autocompletion
        'hrsh7th/nvim-cmp',
        event = "InsertEnter",
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
    { 'kevinhwang91/nvim-ufo', dependencies = { 'kevinhwang91/promise-async' } },
    { 'windwp/nvim-autopairs', event = "InsertEnter",                          opts = {} },
    {
        "nvim-tree/nvim-tree.lua",
        cmd = { "NvimTreeToggle", "NvimTreeFocus" },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim"
        },
    },
}

require('lazy').setup(plugins, {})
require('basics-conf')
require('neovide-conf')
require("lua-line-conf")
require("nvimtree-conf")
require('lsp-config-conf')
setupOmniSharp()
setupCSharpLs()
pcall(require('telescope').load_extension, 'fzf')
require('cmp-conf')
require('ufo-conf')
require('keybinds-conf')

-- NOTE: Set startup directory to Desktop
-- local os = require("os")
-- local path_to_desktop = os.getenv("USERPROFILE") .. "\\Desktop"
-- local vim_enter_group = vim.api.nvim_create_augroup("vim_enter_group", { clear = true })
-- vim.api.nvim_create_autocmd(
--     {"VimEnter"},
--     { pattern = "*", command = "cd " .. path_to_desktop, group = vim_enter_group }
-- )

-- TODO: Add dotnet to overseer
-- TODO: Show current language on lualine
-- TODO: omnisharp, allow for decompliation
