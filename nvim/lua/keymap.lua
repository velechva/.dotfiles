-- File
vim.keymap.set("n", "<leader>fs", "<cmd>write<CR>", { desc = "Save" })
vim.keymap.set("n", "<leader>fq", "<cmd>exit<CR>", { desc = "Quit" })

-- Window
vim.keymap.set("n", "<leader>w\\", "<cmd>vsplit<CR>", { desc = "Split vertically" })
vim.keymap.set("n", "<leader>w-", "<cmd>split<CR>", { desc = "Split horizontally" })

-- Search
vim.keymap.set("n", "<leader>sf", "<cmd>lua require('fzf-lua').files()<CR>", { desc = "Files" })
vim.keymap.set("n", "<leader>ss", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", { desc = "Grep" })
vim.keymap.set("n", "<leader>b", "<cmd>Telescope buffers<CR>", { desc = "List buffers" })

-- Git
vim.keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<CR>", { desc = "Git status" })
vim.keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<CR>", { desc = "Git branches" })
vim.keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "Git commits" })

vim.keymap.set("n", "<leader>n", "<cmd>NERDTree<CR>", { desc = "File tree" })

-- Lsp
vim.keymap.set("n", "<leader>lr", "<cmd>Telescope lsp_references<CR>", { desc = "Find References" })
vim.keymap.set("n", "<leader>ld", "<cmd>Telescope lsp_definitions<CR>", { desc = "Go To Definition" })
vim.keymap.set("n", "<leader>lh", "<cmd>lua vim.lsp.buf.hover()<CR>", { desc = "Lsp Hover" })
vim.keymap.set("n", "<leader>ls", "<cmd>lua vim.lsp.buf.rename()<CR>", { desc = "Rename" })
vim.keymap.set("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format()<CR>", { desc = "Format buffer" })
vim.keymap.set("n", "<leader>le", "<cmd>lua vim.diagnostic.open_float()<CR>", { desc = "Show diagnostics" })
vim.keymap.set("n", "<leader>l<leader>", "<cmd>lua vim.lsp.buf.completion()<CR>", { desc = "Autocomplete" })

