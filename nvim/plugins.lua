local plugins = {
	"preservim/nerdtree",
	"ryanoasis/vim-devicons",
	"neovim/nvim-lspconfig",
	"nvim-telescope/telescope.nvim",
	"nvim-tree/nvim-web-devicons",
	'neovim/nvim-lspconfig',
	'hrsh7th/cmp-nvim-lsp',
	'hrsh7th/cmp-buffer',
	'hrsh7th/cmp-path',
	'hrsh7th/cmp-cmdline',
	'hrsh7th/nvim-cmp',
	"vim-sleuth",
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.6',
		 dependencies = { 'nvim-lua/plenary.nvim' }
	},
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("fzf-lua").setup({})
		end
	}
}

return plugins
