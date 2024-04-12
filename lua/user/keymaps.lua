local opts = {noremap = true, silent = true }

local term_opts = {silent = true }

function merge(t1, t2)
    for k, v in pairs(t2) do
        t1[k] = v
    end
    return t1
end
-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "


-- Better window navigation
--keymap("n", "<C-h>", "<C-w>h", merge(opts, {desc = "Go to left window"}))
--keymap("n", "<C-j>", "<C-w>j", merge(opts, {desc = "Go to lower window"}))
--keymap("n", "<C-k>", "<C-w>k", merge(opts, {desc = "Go to upper window"}))
--keymap("n", "<C-l>", "<C-w>l", merge(opts, {desc = "Go to right window"}))

keymap("n", "<leader>e", ":Lex 30<cr>", merge(opts, {desc = "Open explorer"}))

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", merge(opts, {desc = "Increase window height"}))
keymap("n", "<C-Down>", ":resize -2<CR>", merge(opts, {desc = "Decrease window height"}))
keymap("n", "<C-Left>", ":vertical resize -2<CR>", merge(opts, {desc = "Decrease window width"}))
keymap("n", "<C-Right>", ":vertical resize +2<CR>", merge(opts, {desc = "Increase window width"}))

-- Move Lines
keymap("n", "<A-j>", ":m .+1<cr>==", merge(opts, { desc = "Move down" }))
keymap("n", "<A-k>", ":m .-2<cr>==", merge(opts,{ desc = "Move up" }))
keymap("v", "<A-j>", ":m '>+1<cr>gv=gv", merge(opts,{ desc = "Move down" }))
keymap("v", "<A-k>", ":m '<-2<cr>gv=gv", merge(opts,{ desc = "Move up" }))
keymap("i", "<A-k>", "<esc>:m .-2<cr>==gi", merge(opts,{ desc = "Move up" }))
keymap("i", "<A-j>", "<esc>:m .+1<cr>==gi", merge(opts,{ desc = "Move down" }))


-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Clear search with <esc>
keymap("n" , "<esc>", ":noh<cr><esc>", merge(opts, { desc = "Escape and clear hlsearch" }))

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
keymap("i", "<C-s>", ":w<cr><esc>", merge(opts, { desc = "Save file" }))
keymap("x", "<C-s>", ":w<cr><esc>", merge(opts, { desc = "Save file" }))
keymap("n", "<C-s>", ":w<cr><esc>", merge(opts, { desc = "Save file" }))
keymap("s", "<C-s>", ":w<cr><esc>", merge(opts, { desc = "Save file" }))
-- close file
keymap("i", "<C-x>", ":x!<esc>", merge(opts, { desc = "Quite file" }))
keymap("x", "<C-x>", ":x!<esc>", merge(opts, { desc = "Quite file" }))
keymap("n", "<C-x>", ":x!<esc>", merge(opts, { desc = "Quite file" }))
keymap("s", "<C-x>", ":x!<esc>", merge(opts, { desc = "Quite file" }))
-- quit
keymap('n', '<leader>qq', ':qa!<CR>', {desc = "Quite all",  noremap = true, silent = true })
keymap('n', '<leader>qf', ':q!<CR>', {desc = "Quite file",  noremap = true, silent = true })

-- Insert --
-- Press jk fast to exit insert mode 
keymap("i", "jk", "<ESC>", merge(opts, {desc = "exit insert mode" }))
keymap("i", "kj", "<ESC>", merge(opts, {desc = "exit insert mode" }))

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv^", opts)
keymap("v", ">", ">gv^", opts)
-- String replace
keymap('v', '<C-r>', '"hy:%s/<C-r>h//gc<Left><Left><Left>', { noremap = true, silent = true })

