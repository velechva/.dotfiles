vim.opt.encoding = "UTF-8"
vim.opt.swapfile = false

-- lazy.nvim

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

-- plugins

plugins = {
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

require("lazy").setup(plugins, opts)

vim.keymap.set("n", "<Space>ff", "<cmd>lua require('fzf-lua').files()<CR>")
vim.keymap.set("n", "<Space>fs", "<cmd>write<CR>")
vim.keymap.set("n", "<Space>fx", "<cmd>exit<CR>")
vim.keymap.set("n", "<Space>rg", "<cmd>Telescope live_grep<CR>")
vim.keymap.set("n", "<Space>fr", "<cmd>Telescope lsp_references<CR>")
vim.keymap.set("n", "<Space>fd", "<cmd>Telescope lsp_definitions<CR>")
vim.keymap.set("n", "<Space>gs", "<cmd>Telescope git_status<CR>")
vim.keymap.set("n", "<Space>gb", "<cmd>Telescope git_branches<CR>")
vim.keymap.set("n", "<Space>gc", "<cmd>Telescope git_commits<CR>")
vim.keymap.set("n", "<Space>n", "<cmd>NERDTree<CR>")

-- completions
--
local cmp = require('cmp')

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true })
	}),
})

sources = cmp.config.sources({
	{ name = 'nvim_lsp' },
	{ name = 'vsnip' }
	{ name = 'buffer' },
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
	}, 
	{
		{ name = 'cmdline' }
	}),
	matching = { disallow_symbol_nonprefix_matching = false }
})

local lspconfig = require('lspconfig')
lspconfig.rust_analyzer.setup {
	settings = {
		['rust-analyzer'] = {},
	},
	capabilities = capabilities
}

