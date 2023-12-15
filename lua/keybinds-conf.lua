-- Lsp
vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, { desc = "Hover" })
vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format() end, { desc = "Format buffer" })
vim.keymap.set("n", "<leader>gd", function() vim.lsp.buf.definition() end, { desc = "[G]o to [D]efinition" })
vim.keymap.set("n", "<leader>ge", function() vim.lsp.buf.declaration() end, { desc = "[G]o to d[E]claration" })
vim.keymap.set("n", "<leader>gt", function() vim.lsp.buf.type_definition() end, { desc = "[G]o to [T]ype definition" })
vim.keymap.set("n", "<leader>gi", function() vim.lsp.buf.implementation() end, { desc = "[G]o to [I]mplementation" })
vim.keymap.set("n", "<leader>s", function() vim.lsp.buf.signature_help() end, { desc = "[S]ignature help" })
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
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], { desc = "Exit terminal" })
    vim.keymap.set('t', 'jk', [[<C-\><C-n>]], { desc = "Exit terminal" })
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
-- buffer management
vim.keymap.set('n', '<tab>', ":bn<CR>", { desc = 'Next buffer' })
vim.keymap.set('n', '<S-tab>', ":bp<CR>", { desc = 'Previous buffer' })
vim.keymap.set('n', '<leader>x', ":bd<CR>", { desc = 'Close buffer' })
