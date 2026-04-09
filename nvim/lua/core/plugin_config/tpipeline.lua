-- tmuxline.vim syncs your tmux statusline theme with your Neovim colorscheme
-- while keeping them as separate lines.
vim.g.tmuxline_preset = {
  a = '#S',
  win = { '#I', '#W' },
  cwin = { '#I', '#W', '#F' },
  y = { '%R', '%a', '%Y' },
  z = '#H',
}
