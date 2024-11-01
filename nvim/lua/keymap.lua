-- File
vim.keymap.set("n", "<leader>fs", "<cmd>write<CR>", { desc = "Save" })
vim.keymap.set("n", "<leader>fq", "<cmd>exit<CR>", { desc = "Quit" })

-- Window
vim.keymap.set("n", "<C-w>-", "<cmd>split<CR><C-w>w", { desc = "Split vertically" })
vim.keymap.set("n", "<C-w>\\", "<cmd>vsplit<CR><C-w>w", { desc = "Split vertically" })
vim.keymap.set("n", "<C-w>x", "<cmd>quit<CR>", { desc = "Quit" })
vim.keymap.set("n", "<C-w>n", "<cmd>tabnext<CR>", { desc = "Next tab" })
vim.keymap.set("n", "<C-w>p", "<cmd>tabprevious<CR>", { desc = "Previous tab" })
vim.keymap.set('n', '<C-w>t', ':tab split<CR>', { desc = "Open in new tab" })

-- Search
vim.keymap.set("n", "<leader>sf", "<cmd>lua require('fzf-lua').files()<CR>", { desc = "Files" })
vim.keymap.set("n", "<leader>sr", "<cmd>lua require('telescope.builtin').resume()<CR>", { desc = "Resume telescope" })
vim.keymap.set("n", "<leader>ss", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", { desc = "Grep" })
vim.keymap.set("n", "<leader>sm", "<cmd>Telescope marks<CR>", { desc = "Grep" })
vim.keymap.set("n", "<leader>b", "<cmd>Telescope buffers<CR>", { desc = "List buffers" })
vim.keymap.set("n", "<leader>so", "<cmd>Telescope oldfiles<CR>", { desc = "Old files" })
vim.keymap.set("n", "<leader>shc", "<cmd>Telescope command_history<CR>", { desc = "Command history" })
vim.keymap.set("n", "<leader>shs", "<cmd>Telescope search_history<CR>", { desc = "Search history" })
vim.keymap.set("n", "<leader>ut", "<cmd>Telescope colorscheme<CR>", { desc = "Theme" })

-- Git
vim.keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<CR>", { desc = "Git status" })
vim.keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<CR>", { desc = "Git branches" })
vim.keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "Git commits" })
vim.keymap.set("n", "<leader>gl", "<cmd>GitBlameToggle<CR>", { desc = "Toggle git blame" })

vim.keymap.set("n", "<leader>n", "<cmd>NERDTreeToggle<CR>", { desc = "File tree" })
vim.keymap.set("n", "<leader>N", "<cmd>NERDTreeFind<CR>", { desc = "Find file in tree" })

-- Lsp
vim.keymap.set("n", "<leader>lr", "<cmd>Telescope lsp_references<CR>", { desc = "Find References, including tests" })
vim.keymap.set("n", "<leader>lt", "<cmd>lua require('telescope.builtin').lsp_references({ file_ignore_patterns = { 'tests' }})<CR>", { desc = "Find Refereneces, excluding tests" })
vim.keymap.set("n", "<leader>ld", "<cmd>Telescope lsp_definitions<CR>", { desc = "Go To Definition" })
vim.keymap.set("n", "<leader>lh", "<cmd>lua vim.lsp.buf.hover()<CR>", { desc = "Lsp Hover" })
vim.keymap.set("n", "<leader>ls", "<cmd>lua vim.lsp.buf.rename()<CR>", { desc = "Rename" })
vim.keymap.set("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format()<CR>", { desc = "Format buffer" })
vim.keymap.set("n", "<leader>le", "<cmd>lua vim.diagnostic.open_float()<CR>", { desc = "Show diagnostics" })
vim.keymap.set("n", "<leader>l<leader>", "<cmd>lua vim.lsp.buf.completion()<CR>", { desc = "Autocomplete" })
vim.keymap.set("n", "<leader>ly", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", { desc = "Show diagnostics" })

vim.keymap.set("n", "<leader>pf", "<cmd>SessionSearch<CR>", { desc = "Show sessions" })
vim.keymap.set("n", "<leader>ps", "<cmd>SessionSave<CR>", { desc = "Save session" })
vim.keymap.set("n", "<leader>px", "<cmd>SessionDelete<CR>", { desc = "Delete session" })

-- Exit VIM!
local function quit()
  local bufnr = vim.api.nvim_get_current_buf()
  local buf_windows = vim.call("win_findbuf", bufnr)
  local modified = vim.api.nvim_get_option_value("modified", { buf = bufnr })

  if modified and #buf_windows == 1
  then
    vim.ui.input(
      {
        prompt = "... unwritten changes, want to quit? (y/n) ",
      },
      function(input)
        if input == "y" then
          vim.cmd("qa!")
        end
      end
    )
  else
    vim.cmd("qa!")
  end
end

vim.keymap.set("n", "<leader>qq", quit, { silent = true })

