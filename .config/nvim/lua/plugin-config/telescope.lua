local opts = { silent = true, noremap = true }
vim.api.nvim_set_keymap('n', '<Leader>ff', "<Cmd>lua require'telescope.builtin'.find_files()<CR>", {silent=false, noremap=true})
vim.api.nvim_set_keymap('n', '<Leader>fg', "<Cmd>lua require'telescope.builtin'.live_grep()<CR>", opts)
vim.api.nvim_set_keymap('n', '<Leader>fb', "<Cmd>lua require'telescope.builtin'.buffers()<CR>", opts)
vim.api.nvim_set_keymap('n', '<Leader>fh', "<Cmd>lua require'telescope.builtin'.help_tags()<CR>", opts)

require('telescope').setup {}
