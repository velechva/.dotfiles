local lspconfig = require('lspconfig')

lspconfig.rust_analyzer.setup {
	settings = {
		['rust-analyzer'] = {},
	},
	capabilities = capabilities
}

lspconfig.pyright.setup {
	capabilities = capabilities
}

lspconfig.clangd.setup  {
	default_config = {
		root_dir = [[
		root_pattern(
		'config.yaml',
		'.clangd',
		'.clang-tidy',
		'.clang-format',
		'compile_commands.json',
		'compile_flags.txt',
		'configure.ac',
		'.git'
		)
		]],
		capabilities = [[default capabilities, with offsetEncoding utf-8]],
	},
}

