local o = vim.o

o.ignorecase = true
o.smartcase = true
o.incsearch = true
o.hlsearch = true

o.lazyredraw = false

o.magic = true

o.showmatch = true
o.mat = 2

o.syntax = "ON"

-- Always display the statusline in all windows
o.laststatus = 2
-- Always display the tabline, even if there is only one tab
o.showtabline = 2
-- Hide the default mode text (e.g. -- INSERT -- below the statusline)
o.showmode = false

o.number = true
o.relativenumber = true
