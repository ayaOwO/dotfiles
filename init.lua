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
    { 'williamboman/mason.nvim', dependencies = { 'williamboman/mason-lspconfig.nvim', 'neovim/nvim-lspconfig' } },
    { 'folke/twilight.nvim', opts = {} },
    { 'folke/neodev.nvim', opts = {} },
    { 'folke/todo-comments.nvim', dependencies = { "nvim-lua/plenary.nvim" }, opts = { TODO = { icon = " ", color = "info", alt = { "todo" } }, } },
    { 'folke/which-key.nvim', opts = {} },
    { 'j-hui/fidget.nvim', opts = {} },
    { "max397574/better-escape.nvim", opts = {} },
    { 'akinsho/bufferline.nvim', opts = {}, dependencies = 'nvim-tree/nvim-web-devicons' },
    { "akinsho/toggleterm.nvim", opts = {} },
    {
        'nvim-lualine/lualine.nvim',

        dependencies = { "archibate/lualine-time" },
        opts = {
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = { 'filename' },
                lualine_x = { 'encoding', 'fileformat', 'filetype' },
                lualine_y = { 'progress', 'ctime' },
                lualine_z = { 'location' },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { 'filename' },
                lualine_x = { 'location' },
                lualine_y = {},
                lualine_z = {}
            },
        },
    },
    { 'numToStr/Comment.nvim',               opts = {} },
    { 'lukas-reineke/indent-blankline.nvim', main = 'ibl', opts = {} },

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
        config = function()
            local options = {
                -- hijack_netrw_behavior = "open_default",
                hijack_cursor = true,
                -- hijack_unnamed_buffer_when_opening = true,
                sync_root_with_cwd = true,
                update_focused_file = {
                    enable = true,
                    update_root = false,
                },
                view = {
                    adaptive_size = false,
                    side = "left",
                    width = 30,
                    preserve_window_proportions = true,
                },
                git = {
                    enable = false,
                    ignore = true,
                },
                filesystem_watchers = {
                    enable = true,
                },
                actions = {
                    open_file = {
                        resize_window = true,
                    },
                },
                renderer = {
                    root_folder_label = false,
                    highlight_git = false,
                    highlight_opened_files = "none",

                    indent_markers = {
                        enable = false,
                    },

                    icons = {
                        show = {
                            file = true,
                            folder = true,
                            folder_arrow = true,
                            git = false,
                        },

                        glyphs = {
                            default = "󰈚",
                            symlink = "",
                            folder = {
                                default = "",
                                empty = "",
                                empty_open = "",
                                open = "",
                                symlink = "",
                                symlink_open = "",
                                arrow_open = "",
                                arrow_closed = "",
                            },
                            git = {
                                unstaged = "✗",
                                staged = "✓",
                                unmerged = "",
                                renamed = "➜",
                                untracked = "★",
                                deleted = "",
                                ignored = "◌",
                            },
                        },
                    },
                },
            }
            require("nvim-tree").setup(options)
        end,
    },
}

require('lazy').setup(plugins, {})
require('mason').setup()
require('mason-lspconfig').setup()

local lsp_config = require('lspconfig')
lsp_config.lua_ls.setup {}
lsp_config.csharp_ls.setup {}

vim.o.number = true
vim.o.relativenumber = true
-- Tab
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true

-- Line Highlighting
vim.o.colorcolumn = '80'
vim.o.cursorline = true

vim.o.scrolloff = 5
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
if vim.g.neovide then
    -- Put anything you want to happen only in Neovide here
    vim.o.guifont = "JetBrainsMono Nerd Font:h11"
    vim.g.neovide_hide_mouse_when_typing = true
    vim.g.neovide_theme = 'auto'
    vim.g.neovide_cursor_vfx_mode = "pixiedust"
    -- vim.g.NeovideRegisterRightClick()
end

vim.g.neovide_scale_factor = 1.0
local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end
vim.keymap.set("n", "<C-=>", function()
    change_scale_factor(1.25)
end)
vim.keymap.set("n", "<C-->", function()
    change_scale_factor(1 / 1.25)
end)
-- Lsp
vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, { desc = "Hover" })
vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format() end, { desc = "Format buffer" })
vim.keymap.set("n", "<leader>gd", function() vim.lsp.buf.definition() end, { desc = "[G]o to [D]efinition" })
vim.keymap.set("n", "<leader>gi", function() vim.lsp.buf.implementation() end, { desc = "[G]o to [I]mplementation" })
vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, { desc = "[R]e[N]ame" })
vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, { desc = "[C]ode [A]ction" })

-- Telescope
vim.keymap.set('n', '<leader>ss', require('telescope.builtin').builtin, { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sb', require('telescope.builtin').buffers, { desc = '[S]earch [B]uffers' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
-- vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>e', "<cmd> NvimTreeFocus<CR>", { desc = 'File [E]xplorer' })
vim.keymap.set('n', '<C-n>', "<cmd> NvimTreeToggle<CR>", { desc = 'Toggle file explorer' })

-- Terminal
vim.keymap.set('n', '<leader>h', "<cmd> ToggleTerm<CR>", { desc = 'Toggle terminal' })
function _G.set_terminal_keymaps()
    local opts = { buffer = 0 }
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], { desc = "Exit terminal" })
    vim.keymap.set('t', 'jk', [[<C-\><C-n>]], { desc = "Exit terminal" })
end
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

-- buffer management
vim.keymap.set('n', '<tab>', ":bn<CR>", { desc = 'Next buffer' })
vim.keymap.set('n', '<S-tab>', ":bp<CR>", { desc = 'Previous buffer' })
vim.keymap.set('n', '<leader>x', ":bd<CR>", { desc = 'Close buffer' })


-- NOTE: Set startup directory to Desktop
-- local os = require("os")
-- local path_to_desktop = os.getenv("USERPROFILE") .. "\\Desktop"
-- local vim_enter_group = vim.api.nvim_create_augroup("vim_enter_group", { clear = true })
-- vim.api.nvim_create_autocmd(
--     {"VimEnter"},
--     { pattern = "*", command = "cd " .. path_to_desktop, group = vim_enter_group }
-- )
