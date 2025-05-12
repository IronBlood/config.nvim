local winnr = vim.fn.winnr
local nvim_command = vim.api.nvim_command

local function WinMove(key)
  local curwin = winnr()
  local move_cmd = "wincmd " .. key
  nvim_command(move_cmd)

  --if (vim.t.curwin == vim.fn.winnr()) then
  if curwin == winnr() then
    local cmd = (key == "j" or key == "k") and "wincmd s" or "wincmd v"
    nvim_command(cmd)
    nvim_command(move_cmd)
  end
end

local keys = { "h", "j", "k", "l" }
for _, k in pairs(keys) do
  vim.keymap.set("n", "<C-" .. k .. ">", function()
    WinMove(k)
  end)
end
