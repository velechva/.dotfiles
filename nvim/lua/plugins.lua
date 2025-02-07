local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Bootstrap lazy if missing
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

plugins = {
    -- Plugin Management --

    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",

    -- Core --

    "preservim/nerdtree",
    'nmac427/guess-indent.nvim',
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

    -- LSP --

    "neovim/nvim-lspconfig",

    -- Appearance --

    "ryanoasis/vim-devicons",
    "nvim-tree/nvim-web-devicons",

    -- Themes --

    'raddari/last-color.nvim',

    "Mofiqul/dracula.nvim",
    'navarasu/onedark.nvim',
    'NTBBloodbath/doom-one.nvim',
    { 'projekt0n/github-nvim-theme', name = 'github-theme' },
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

    -- Language features --
    'numToStr/Comment.nvim',
    "hrsh7th/vim-vsnip",

    -- Cmp --
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",

    -- Etc --

    "tpope/vim-sleuth",
    "sindrets/diffview.nvim",
    "petertriho/nvim-scrollbar",

    -- Session Mgmt --

    {
        "rmagatti/auto-session",
        config = function()
            require("auto-session").setup {
                root_dir = "~/.nvim-sessions",
                auto_restore = false,
                auto_save = false,
                auto_create = false,
            }
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

    -- SCM --

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
}

require("lazy").setup(plugins, opts)

require('lualine').setup{
    sections = {
        lualine_a = {{
            'filename',
            file_status = true,
            -- Show full filepath
            path = 2
        }}
    }
}

require("mason").setup()
require("mason-lspconfig").setup  {}

require'lspconfig'.biome.setup    {}
require'lspconfig'.ruby_lsp.setup {}
require'lspconfig'.lemminx.setup  {}

require'Comment'.setup{}

require('guess-indent').setup {}
