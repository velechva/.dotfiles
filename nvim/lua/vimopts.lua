vim.opt.encoding = "UTF-8"
vim.opt.swapfile = false
vim.opt.tabstop  = 4
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes:1"

vim.g.mapleader = " "

vim.g.gitblame_enabled = 0

vim.cmd 'command! SplitDiff windo diffthis'

vim.g.xml_syntax_folding = 1
vim.opt.syntax = "on"

vim.api.nvim_create_autocmd("FileType", {
  pattern = "xml",
  callback = function(args)
    vim.opt.foldmethod = "syntax"
  end
})

-- Use patience algorithm for better git diffs
vim.cmd([[ set diffopt+=internal,algorithm:patience ]])
