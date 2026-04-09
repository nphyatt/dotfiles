require("lazy").setup({
        "nvim-tree/nvim-tree.lua",
        "nvim-tree/nvim-web-devicons",
        "nvim-lualine/lualine.nvim",
        "nvim-treesitter/nvim-treesitter",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",

        -- Git
        "tpope/vim-fugitive",
        "airblade/vim-gitgutter",

        -- Editing
        "tpope/vim-surround",
        "tpope/vim-repeat",
        "tpope/vim-unimpaired",
        "tpope/vim-eunuch",

        -- Telescope (fuzzy finder)
        { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

        -- Colorscheme
        { "bluz71/vim-nightfly-colors", name = "nightfly", lazy = false, priority = 1000 },

        -- Claude Code integration
        { "Cannon07/claude-preview.nvim", config = function() require("claude-preview").setup() end },

        -- Discoverability
        { "folke/which-key.nvim", event = "VeryLazy" },
})
