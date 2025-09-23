return {
  "nvim-tree/nvim-tree.lua",
  version = "1.*",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- optional, for file icon
  },
  config = function()
    vim.opt.termguicolors = true

    local api = require("nvim-tree.api")
    local function opts(desc)
      return {
        desc = "nvim-tree: " .. desc,
        noremap = true,
        silent = true,
        nowait = true,
      }
    end
    vim.keymap.set("n", "<C-n>", api.tree.toggle, opts("Toggle nvim tree"))
    require("nvim-tree").setup({})
  end,
}
