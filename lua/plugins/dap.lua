return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    {
      "theHamsta/nvim-dap-virtual-text",
      opts = {},
    },
    "nvim-neotest/nvim-nio",
  },
  config = function()
    require("config.dap")
  end,
}
