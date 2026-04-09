# Dotfiles

Personal configuration files for Neovim and tmux.

## Prerequisites

- [Neovim](https://neovim.io/) >= 0.11
- [tmux](https://github.com/tmux/tmux)
- [git](https://git-scm.com/)
- A [Nerd Font](https://www.nerdfonts.com/) installed and configured in your terminal (for icons)

## Installation

### 1. Clone the repository

```sh
git clone https://github.com/<your-username>/dotfiles.git ~/dotfiles
```

### 2. Create symlinks

```sh
# Neovim
ln -s ~/dotfiles/nvim ~/.config/nvim

# tmux
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
```

If the targets already exist, back them up first:

```sh
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.tmux.conf ~/.tmux.conf.bak
```

### 3. Install Neovim plugins

Open Neovim. [lazy.nvim](https://github.com/folke/lazy.nvim) will auto-bootstrap and install all plugins on first launch. Mason will also auto-install the configured LSP servers (lua_ls, ts_ls, terraformls).

### 4. Install tmux plugins

Install [TPM](https://github.com/tmux-plugins/tpm) (Tmux Plugin Manager):

```sh
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Then reload tmux and install plugins:

```sh
tmux source-file ~/.tmux.conf
```

Press `prefix + I` (default prefix is `C-Space`) to install tmux plugins (resurrect, continuum, yank).

## What's Included

### Neovim

- **Plugin manager:** lazy.nvim (auto-bootstraps)
- **LSP:** nvim-lspconfig + Mason (lua_ls, ts_ls, terraformls)
- **Completion:** nvim-cmp with LuaSnip
- **Syntax:** treesitter (C, Lua, Rust, Ruby, Vim, HTML, TypeScript, JavaScript, Python, YAML, CSS, Markdown, Bash)
- **Fuzzy finder:** telescope.nvim (`Ctrl-P` git files, `<leader>f` find files, `<leader>b` buffers, `<leader>o` symbols, `<leader>/` live grep)
- **File explorer:** nvim-tree (`Ctrl-N` to toggle)
- **Git:** vim-fugitive, vim-gitgutter, vimagit
- **Editing:** vim-surround, vim-repeat, vim-unimpaired, vim-eunuch
- **Statusline:** lualine.nvim
- **Tmux theme sync:** tmuxline.vim

### tmux

- **Prefix:** `C-Space`
- **Pane navigation:** `prefix + h/j/k/l`
- **Pane resize:** `prefix + H/J/K/L`
- **Split panes:** `prefix + |` (horizontal), `prefix + v` (vertical)
- **Session switching:** `prefix + N/P` (next/prev), `prefix + m` (by name)
- **Plugins:** tmux-resurrect, tmux-continuum (auto-save/restore sessions), tmux-yank
- **Reload config:** `prefix + r`
