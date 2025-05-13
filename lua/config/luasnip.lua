local ls = require("luasnip")
local set = vim.keymap.set

set({ "i", "s" }, "<C-k>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })

set({ "i", "s" }, "<C-j>", function()
  ls.jump(-1)
end, { silent = true })
