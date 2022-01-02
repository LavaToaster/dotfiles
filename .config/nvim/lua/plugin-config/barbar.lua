local opts = {noremap = true, silent = true}

vim.api.nvim_set_keymap('', '<leader>[', '<Cmd>BufferPrevious<CR>', opts)
vim.api.nvim_set_keymap('', '<leader>]', '<Cmd>BufferNext<CR>', opts)
vim.api.nvim_set_keymap('', '<leader>x', '<Cmd>BufferClose<CR>', opts)
