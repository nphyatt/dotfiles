vim.g.gitgutter_terminal_reports_focus = 0
vim.g.gitgutter_realtime = 1
vim.api.nvim_set_hl(0, 'SignColumn', { link = 'LineNr' })
vim.api.nvim_set_hl(0, 'GitGutterAdd', { fg = '#009900', ctermfg = 2 })
vim.api.nvim_set_hl(0, 'GitGutterChange', { fg = '#bbbb00', ctermfg = 3 })
vim.api.nvim_set_hl(0, 'GitGutterDelete', { fg = '#ff2222', ctermfg = 1 })
