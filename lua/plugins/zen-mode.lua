return {
  "folke/zen-mode.nvim",
  opts = {
    plugins = {
      options = {
        laststatus = 0,
      },
      gitsigns = {
        enabled = true,
      },
      alacritty = {
        -- might sending messages to another session
        enabled = false,
        font = "28",
      },
    },
  },
  {
    "folke/twilight.nvim",
    config = function()
      local tl = require("twilight")
      tl.setup({
        context = 2,
      })
      vim.keymap.set("n", "<leader>z", tl.toggle, { desc = "Toggle Twilight" })
    end,
  },
}
