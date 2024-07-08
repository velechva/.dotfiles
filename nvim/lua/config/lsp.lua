local lspconfig = require('lspconfig')
lspconfig.rust_analyzer.setup {
	settings = {
		['rust-analyzer'] = {},
	},
	capabilities = capabilities
}
