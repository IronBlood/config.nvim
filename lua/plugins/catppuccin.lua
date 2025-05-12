return {
  "catppuccin/nvim",
  priority = 1000,
  init = function()
    require("catppuccin").setup({
      compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
    })

    vim.cmd.colorscheme("catppuccin-frappe")
  end,
}
