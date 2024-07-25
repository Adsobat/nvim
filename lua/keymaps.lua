local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

function merge(t1, t2)
  for k, v in pairs(t2) do
    t1[k] = v
  end
  return t1
end
-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Remap space as leader key
keymap('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Better window navigation
--keymap("n", "<C-h>", "<C-w>h", merge(opts, {desc = "Go to left window"}))
--keymap("n", "<C-j>", "<C-w>j", merge(opts, {desc = "Go to lower window"}))
--keymap("n", "<C-k>", "<C-w>k", merge(opts, {desc = "Go to upper window"}))
--keymap("n", "<C-l>", "<C-w>l", merge(opts, {desc = "Go to right window"}))

--keymap('n', '<leader>e', ':Lex 30<cr>', merge(opts, { desc = 'Open explorer' }))

-- Resize with arrows
keymap('n', '<C-Up>', ':resize +2<CR>', merge(opts, { desc = 'Increase window height' }))
keymap('n', '<C-Down>', ':resize -2<CR>', merge(opts, { desc = 'Decrease window height' }))
keymap('n', '<C-Left>', ':vertical resize -2<CR>', merge(opts, { desc = 'Decrease window width' }))
keymap('n', '<C-Right>', ':vertical resize +2<CR>', merge(opts, { desc = 'Increase window width' }))

-- Move Lines
keymap('n', '<A-j>', ':m .+1<cr>==', merge(opts, { desc = 'Move line down' }))
keymap('n', '<A-k>', ':m .-2<cr>==', merge(opts, { desc = 'Move line up' }))
keymap('v', '<A-j>', ":m '>+1<cr>gv=gv", merge(opts, { desc = 'Move line down' }))
keymap('v', '<A-k>', ":m '<-2<cr>gv=gv", merge(opts, { desc = 'Move line up' }))
keymap('i', '<A-k>', '<esc>:m .-2<cr>==gi', merge(opts, { desc = 'Move line up' }))
keymap('i', '<A-j>', '<esc>:m .+1<cr>==gi', merge(opts, { desc = 'Move line down' }))

-- Navigate buffers
keymap('n', '<S-l>', ':bnext<CR>', opts)
keymap('n', '<S-h>', ':bprevious<CR>', opts)

-- Clear search with <esc>
keymap('n', '<esc>', ':noh<cr><esc>', merge(opts, { desc = 'Escape and clear hlsearch' }))

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
-- Map 'n' in normal, visual, and operator-pending modes
keymap('n', 'n', [[v:searchforward ? 'n' : 'N']], { noremap = true, expr = true })
keymap('x', 'n', [[v:searchforward ? 'n' : 'N']], { noremap = true, expr = true })
keymap('o', 'n', [[v:searchforward ? 'n' : 'N']], { noremap = true, expr = true })
-- Map 'N' in normal, visual, and operator-pending modes
keymap('n', 'N', [[v:searchforward ? 'N' : 'n']], { noremap = true, expr = true })
keymap('x', 'N', [[v:searchforward ? 'N' : 'n']], { noremap = true, expr = true })
keymap('o', 'N', [[v:searchforward ? 'N' : 'n']], { noremap = true, expr = true })

-- save file
keymap('i', '<C-s>', '<esc>:w<cr><esc>', merge(opts, { desc = 'Save file' }))
keymap('x', '<C-s>', '<esc>:w<cr><esc>', merge(opts, { desc = 'Save file' }))
keymap('n', '<C-s>', '<esc>:w<cr><esc>', merge(opts, { desc = 'Save file' }))
keymap('s', '<C-s>', '<esc>:w<cr><esc>', merge(opts, { desc = 'Save file' }))
-- close file
keymap('i', '<C-x>', ':x!<esc>', merge(opts, { desc = 'Quite file' }))
keymap('x', '<C-x>', ':x!<esc>', merge(opts, { desc = 'Quite file' }))
keymap('n', '<C-x>', ':x!<esc>', merge(opts, { desc = 'Quite file' }))
keymap('s', '<C-x>', ':x!<esc>', merge(opts, { desc = 'Quite file' }))
-- quit
keymap('n', '<leader>qq', ':qa!<CR>', { desc = 'Quite all', noremap = true, silent = true })
keymap('n', '<leader>qf', ':q!<CR>', { desc = 'Quite file', noremap = true, silent = true })
keymap('n', '<leader>qb', ':bd!<CR>', { desc = 'Quite buffer', noremap = true, silent = true })
-- Insert --
-- Press jk fast to exit insert mode
keymap('i', 'jk', '<ESC>', merge(opts, { desc = 'exit insert mode' }))
keymap('i', 'kj', '<ESC>', merge(opts, { desc = 'exit insert mode' }))

-- Visual --
-- Stay in indent mode
keymap('v', '<', '<gv^', opts)
keymap('v', '>', '>gv^', opts)
-- String replace
keymap('v', '<C-r>', '"hy:%s/<C-r>h//gc<Left><Left><Left>', { noremap = true, silent = true })

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>E', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>Q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- prevent pasting over something to change buffer
vim.keymap.set('v', 'p', '_dp', { desc = 'paste' })

vim.keymap.set('i', '<C-c>', '<Esc>', { desc = 'Remap crt c to esc' })
--vim.keymap.set({ 'v', 'n' }, '<leader>ev', '<cmd>Vex<CR>', { desc = 'Open File explorer vertical' })
