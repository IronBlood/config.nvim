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
}
