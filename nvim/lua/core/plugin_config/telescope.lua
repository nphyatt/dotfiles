local builtin = require('telescope.builtin')

vim.keymap.set('n', '<c-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>f', builtin.find_files, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
vim.keymap.set('n', '<leader>o', builtin.lsp_document_symbols, {})
vim.keymap.set('n', '<leader>/', builtin.live_grep, {})
vim.keymap.set('n', '<leader>.', function()
  builtin.live_grep({ additional_args = {
    '--hidden', '--no-ignore',
    '--glob', '!.git/',
    '--glob', '!node_modules/',
    '--glob', '!dist/',
    '--glob', '!build/',
  } })
end)
