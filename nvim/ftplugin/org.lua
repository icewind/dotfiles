local set = vim.opt

set.shiftwidth = 2
set.tabstop = 2
set.softtabstop = 2

vim.opt_local.formatoptions:remove({ 'r', 'o' })
