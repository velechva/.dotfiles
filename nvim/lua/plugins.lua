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
    "neovim/nvim-lspconfig",
    "nvim-lualine/lualine.nvim",
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
    "rmagatti/auto-session",
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
    }
}

require("lazy").setup(plugins, opts)

require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = { "rust_analyzer", "clangd", "pyright" }
}

require('lualine').setup()
