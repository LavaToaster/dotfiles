-- defaults
local opts = { noremap = true, silent = true }

-- stay in normal mode after inserting a new line
vim.api.nvim_set_keymap('', 'o', 'o <Bs><Esc>', opts)
vim.api.nvim_set_keymap('', 'O', 'O <Bs><Esc>', opts)

-- mapping that opens .vimrc in a new tab for quick editing
-- vim.api.nvim_set_keymap('n', '<Leader>ev', '<Cmd>tabe $MYVIMRC<CR>', opts)
-- mapping that sources the vimrc in the current filea doesn't work, should change all require calls to dofile
-- or clear all require cache and reimport
vim.api.nvim_set_keymap('n', '<Leader>sv', '<Cmd>lua dofile(vim.fn.stdpath(\'config\')..\'/init.lua\')<CR>', { noremap = true, silent = false })

-- Mapping U to Redo.
vim.api.nvim_set_keymap('', 'U', '<C-r>', opts)
vim.api.nvim_set_keymap('', '<C-r>', '<NOP>', opts)

-- indent via Tab
vim.api.nvim_set_keymap('n', '<Tab>', '>>_', opts)
vim.api.nvim_set_keymap('n', '<S-Tab>', '<<_', opts)
vim.api.nvim_set_keymap('v', '<Tab>', '>>_', opts)
vim.api.nvim_set_keymap('v', '<S-Tab>', '<<_', opts)
vim.api.nvim_set_keymap('i', '<Tab>', '\t', opts)
vim.api.nvim_set_keymap('i', '<S-Tab>', '\b', opts)

-- -- opening terminal with shortcut
-- vim.api.nvim_set_keymap('', '<Leader><CR>', '<Cmd>silent !$TERM &<CR>', opts)

-- LSP
vim.api.nvim_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gt', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gf', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)

-- autocomplete
-- if autocomplete popup menu opens pressing enter will complete the first match
-- vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.smart_tab()', {expr = true, noremap = true})
vim.api.nvim_set_keymap('i', '<CR>', 'pumvisible() ? "<C-n><Esc>a" : "<CR>"', {expr = true, noremap = true, silent = true})
