local set = vim.keymap.set
local fn = function(f, ...)
  local args = { ... }
  return function(...)
    return f(unpack(args), ...)
  end
end

-- Keymaps for better default experience
-- Cancel move with space key
set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
set("n", "<Esc>", "<cmd>nohlsearch<CR>")

set("n", "<S-Tab>", "<<")
set("i", "<S-Tab>", "<C-d>")

set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

set("n", "\\t", function()
  vim.cmd.set("ts=4 sts=4 sw=4 noet")
end)
set("n", "\\s", function()
  vim.cmd.set("ts=4 sts=4 sw=4 et")
end)
set("n", "\\j", function()
  vim.cmd.set("ts=2 sts=2 sw=2 et")
end)

-- Diagnostic keymaps
set("n", "[d", fn(vim.diagnostic.jump, { count = 1, float = true }), { desc = "Go to previous diagnostic message" })
set("n", "]d", fn(vim.diagnostic.jump, { count = -1, float = true }), { desc = "Go to next diagnostic message" })
set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

set("n", "<leader>x", "<cmd>.lua<CR>", { desc = "Execute the current line" })
set("n", "<leader><leader>x", "<cmd>source %<CR>", { desc = "Execute the current file" })

-- Normally these are not good mappings, but these make navigating tabs easier
set("n", "<left>", "gT")
set("n", "<right>", "gt")

-- These mappings control the size of splits (height/width)
set("n", "<M-,>", "<c-w>5<")
set("n", "<M-.>", "<c-w>5>")
set("n", "<M-t>", "<C-W>+")
set("n", "<M-s>", "<C-W>-")
