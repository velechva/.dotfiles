-- Buffer management
vim.keymap.set("n", "<Space>fs", "<cmd>write<CR>")
vim.keymap.set("n", "<Space>wq", "<cmd>exit<CR>")

-- Window management
vim.keymap.set("n", "<C-w>|", "<cmd>vsplit<CR>")
vim.keymap.set("n", "<C-w>-", "<cmd>split<CR>")

-- Fuzzy finder
vim.keymap.set("n", "<Space>ff", "<cmd>lua require('fzf-lua').files()<CR>")

-- Telescope
vim.keymap.set("n", "<Space>rg", "<cmd>Telescope live_grep<CR>")
vim.keymap.set("n", "<Space>gs", "<cmd>Telescope git_status<CR>")
vim.keymap.set("n", "<Space>gb", "<cmd>Telescope git_branches<CR>")
vim.keymap.set("n", "<Space>gc", "<cmd>Telescope git_commits<CR>")
vim.keymap.set("n", "<Space>b", "<cmd>Telescope buffers<CR>")

vim.keymap.set("n", "<Space>n", "<cmd>NERDTree<CR>")

-- LSP
vim.keymap.set("n", "<Space>fr", "<cmd>Telescope lsp_references<CR>")
vim.keymap.set("n", "<Space>fd", "<cmd>Telescope lsp_definitions<CR>")
vim.keymap.set("n", "<Space>lh", "<cmd>lua vim.lsp.buf.hover()<CR>")
vim.keymap.set("n", "<Space>lr", "<cmd>lua vim.lsp.buf.rename()<CR>")
vim.keymap.set("n", "<Space>lf", "<cmd>lua vim.lsp.buf.format()<CR>")
vim.keymap.set("n", "<Space>l<Space>", "<cmd>lua vim.lsp.buf.completion()<CR>")
