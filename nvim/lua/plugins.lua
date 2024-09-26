local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Bootstrap lazy if missing
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath
    })
end

vim.opt.rtp:prepend(lazypath)

plugins = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "preservim/nerdtree",
    "ryanoasis/vim-devicons",
    "neovim/nvim-lspconfig",
    "nvim-telescope/telescope.nvim",
    "nvim-tree/nvim-web-devicons",
    'numToStr/Comment.nvim',
    "hrsh7th/vim-vsnip",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "tpope/vim-sleuth",
    "Mofiqul/dracula.nvim",
    "sindrets/diffview.nvim",
    "petertriho/nvim-scrollbar",
    {
        "rmagatti/auto-session",
        config = function()
            require("auto-session").setup {
                root_dir = "~/.nvim-sessions",
                auto_restore = true,
                auto_save = true,
                auto_create = false,
            }
        end
    },
    { 
        "catppuccin/nvim", 
        name = "catppuccin", 
        priority = 1000
    },
    {
        "nvim-telescope/telescope.nvim", 
        tag = "0.1.6",
        dependencies = { 
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-live-grep-args.nvim"
        },
        config = function ()
            local telescope = require("telescope")
            telescope.load_extension("live_grep_args")
        end
    },
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
                require("fzf-lua").setup({})
        end
    },
    {
      "folke/which-key.nvim",
      event = "VeryLazy",
      opts = {
        spec = {
            { "<leader>f", group = "+File" },
            { "<leader>s", group = "+Search" },
            { "<leader>sh", group = "+Search history" },
            { "<leader>u", group = "+Configure" },
            { "<leader>g", group = "+Git" },
            { "<leader>w", group = "+Window" },
            { "<leader>l", group = "+Lsp" },
            { "<leader>p", group = "+Projects" },
            { "<leader>q", group = "+Quit" },
        },
      },
      keys = {
        {
          "<leader>?",
          function()
            require("which-key").show()
          end,
          desc = "Buffer Local Keymaps (which-key)",
        },
      },
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    {
        "f-person/git-blame.nvim",
        event = "VeryLazy",
        opts = {
            enabled = true,
            message_template = " <summary> • <date> • <author> • <<sha>>",
            date_format = "%m-%d-%Y %H:%M:%S",
            virtual_text_column = 1,
        },
    },
    {
        'nvimdev/lspsaga.nvim',
        config = function()
            require('lspsaga').setup{
                ui = {
                    
                }
            }
        end,
        dependencies = {
            'nvim-treesitter/nvim-treesitter', -- optional
            'nvim-tree/nvim-web-devicons',     -- optional
        }
    }
}

require("lazy").setup(plugins, opts)

require('lualine').setup()

require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = { "rust_analyzer", "clangd", "pyright", "biome" }
}

require'lspconfig'.biome.setup{}

require("scrollbar").setup()

