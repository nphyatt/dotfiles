vim.g.mapleader = ' '

vim.opt.clipboard = 'unnamed'
vim.opt.updatetime = 200

-- Allow :Q as alias for :q
vim.api.nvim_create_user_command('Q', 'quit<bang>', { bang = true })

vim.opt.wildignore:append('*.db,*.o,*.obj,*.swp,*.bak,*.lock,*.git,*.svn,*DS_Store*,**/tmp/**')
vim.opt.wildignore:append('*.png,*.jpg,*.gif,*.app,*.dmg,*.pdf,*.so,*.pyc')
vim.opt.wildignore:append('**/node_modules/**,**/venv/**,**/__pycache__/**')

vim.opt.wrap = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.number = true
vim.opt.startofline = false

vim.opt.confirm = true
vim.opt.visualbell = true
vim.opt.timeout = false
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 200

vim.opt.expandtab = true
vim.opt.joinspaces = false
vim.opt.diffopt:append('vertical')
vim.opt.swapfile = false

-- Key mappings
vim.keymap.set('n', 'Y', 'y$')
vim.keymap.set('x', 'p', 'pgvy')
vim.keymap.set('n', 'ze', ':e ')
vim.keymap.set('n', 'zn', ':bn<CR>')
vim.keymap.set('n', 'zp', ':bp<CR>')
vim.keymap.set('n', 'z;', ':bd<CR>')
vim.keymap.set('n', '<leader><leader>', ':nohlsearch<Bar>:echo<CR>', { silent = true })
vim.keymap.set('n', '[g', ':GitGutterToggle<CR>')
vim.keymap.set('n', ']g', ':MagitOnly<CR>')
vim.keymap.set('', 'qq', '<Nop>')

-- Trailing whitespace
vim.api.nvim_set_hl(0, 'ExtraWhitespace', { bg = 'red', ctermbg = 'red' })

vim.api.nvim_create_autocmd('BufWinEnter', {
  pattern = '*',
  callback = function()
    vim.fn.matchadd('ExtraWhitespace', [[\s\+$]])
  end,
})

vim.api.nvim_create_autocmd('InsertEnter', {
  pattern = '*',
  callback = function()
    vim.fn.clearmatches()
    vim.fn.matchadd('ExtraWhitespace', [[\s\+\%#\@<!$]])
  end,
})

vim.api.nvim_create_autocmd('InsertLeave', {
  pattern = '*',
  callback = function()
    vim.fn.clearmatches()
    vim.fn.matchadd('ExtraWhitespace', [[\s\+$]])
  end,
})

vim.api.nvim_create_autocmd('BufWinLeave', {
  pattern = '*',
  callback = function()
    vim.fn.clearmatches()
  end,
})

-- Strip trailing whitespace on save
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  callback = function()
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd([[%s/\s\+$//e]])
    vim.api.nvim_win_set_cursor(0, pos)
  end,
})
