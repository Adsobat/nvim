vim.keymap.set('i', '<C-c>', '<Esc>', { desc = 'Remap crt c to esc' })
vim.keymap.set({ 'v', 'n' }, '<leader>ev', '<cmd>Vex<CR>', { desc = 'Open File escporer' })

return {}
