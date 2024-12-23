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
    -- Basics --
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "preservim/nerdtree",
    "neovim/nvim-lspconfig",
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
    'nmac427/guess-indent.nvim',

    -- Appearance
    "ryanoasis/vim-devicons",
    "nvim-tree/nvim-web-devicons",

    -- Themes
    "Mofiqul/dracula.nvim",
    'navarasu/onedark.nvim',
    'NTBBloodbath/doom-one.nvim',
    { 
        "catppuccin/nvim", 
        name = "catppuccin", 
        priority = 1000
    },

    -- Language features
    'numToStr/Comment.nvim',
    "hrsh7th/vim-vsnip",

    -- Auto-complete
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",

    "tpope/vim-sleuth",
    "sindrets/diffview.nvim",
    'raddari/last-color.nvim',
    "petertriho/nvim-scrollbar",
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
    },
    'nvim-treesitter/nvim-treesitter-context',
    {
		  'maxmx03/solarized.nvim',
		  lazy = false,
		  priority = 1000,
		  opts = {},
		  config = function(_, opts)
			require('solarized').setup(opts)
		  end
    }
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

require'nvim-treesitter.configs'.setup {
  ensure_installed = "xml",
  highlight = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}

require'treesitter-context'.setup{
  enable = false,
  multiwindow = false,
  max_lines = 20,
  min_window_height = 20,
  line_numbers = true,
  multiline_threshold = 20,
  trim_scope = 'outer',
  mode = 'cursor',
  separator = nil,
  zindex = 20,
  on_attach = nil,
}
