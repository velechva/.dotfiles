-- The basics
vim.opt.encoding = "UTF-8"
vim.opt.swapfile = false
vim.opt.tabstop  = 4
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes:1"
vim.opt.syntax = "on"
vim.cmd 'set wrap!'
vim.g.mapleader = " "

-- Don't show git blame right away
vim.g.gitblame_enabled = 0

-- Create a diff based on the current split-window arrangement
vim.cmd 'command! SplitDiff windo diffthis'

-- XML specifics
vim.g.xml_syntax_folding = 1
vim.api.nvim_create_autocmd("FileType", {
  pattern = "xml",
  callback = function(args)
    vim.opt.foldmethod = "syntax"
  end
})

-- Use the patience algorithm for better git diffs
vim.cmd([[ set diffopt+=internal,algorithm:patience ]])

-- Terminal --

-- Default to zsh
vim.cmd 'cnoreabbrev ter ter zsh'
-- Exit termianl
vim.cmd ':tnoremap <Esc> <C-\\><C-n>'
