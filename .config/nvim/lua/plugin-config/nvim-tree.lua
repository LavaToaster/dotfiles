local opts = {silent = true, noremap = true}
vim.api.nvim_set_keymap('n', '<C-n>', '<Cmd>NvimTreeToggle<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>r', '<Cmd>NvimTreeRefresh<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>n', '<Cmd>NvimTreeFindFile<CR>', opts)

require'nvim-tree'.setup({
  diagnostics = {
    enable = true
  }
})