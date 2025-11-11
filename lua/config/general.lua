local o = vim.o

o.compatible = false
o.autoread = true
o.backspace = "indent,eol,start"
o.fileencodings = "utf-8,ucs-bom,gb18030,gbk,gb2312,cp936"

o.expandtab = false
o.smarttab = true
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.shiftround = true

o.eol = true
o.fixeol = true

o.clipboard = "unnamedplus"

o.ttyfast = true

-- code folding settings
o.foldmethod = "indent"
o.foldnestmax = 10
o.foldenable = false
o.foldlevel = 1

o.smartindent = true
o.cindent = true
o.autoindent = false
-- o.breakindent = true

o.swapfile = true

-- Save undo history
o.undofile = true

-- Decrease update time
o.updatetime = 250
o.timeoutlen = 300

o.cursorline = true

o.scrolloff = 5

o.guicursor = "i:block"
o.mouse = ""

-- By default, neovim uses `jcroql` for `formatoptions`. They're all related to comments,
-- some are useful, like `j` will remove the comment leader when joining two lines of comments,
-- `r` will insert the comment leader when pressing <ENTER> in INSERT mode. However, the `o`
-- option, to insert a new line below (`o`) or above (`O`) is annoying to me. So I turn this
-- feature off globally.
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove("o")
  end,
})
