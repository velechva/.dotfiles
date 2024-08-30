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
    "hrsh7th/vim-vsnip",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "tpope/vim-sleuth",
    "Mofiqul/dracula.nvim",
    { 
        "catppuccin/nvim", 
        name = "catppuccin", 
        priority = 1000
    },
    {
        "nvim-telescope/telescope.nvim", tag = "0.1.6",
         dependencies = { "nvim-lua/plenary.nvim" }
    },
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
                require("fzf-lua").setup({})
        end
    }
}

require("lazy").setup(plugins, opts)

require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = { "rust_analyzer", "clangd", "pyright" }
}
