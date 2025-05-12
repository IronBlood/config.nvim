return {
  {
    "catppuccin/nvim",
    priority = 1000,
    init = function()
      require("catppuccin").setup({
        compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
      })

      -- default theme
      vim.cmd.colorscheme("catppuccin-frappe")
    end,
  },
  -- colorscheme tokyonight-night
  -- colorscheme tokyonight-storm
  -- colorscheme tokyonight-day
  -- colorscheme tokyonight-moon
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  -- colorscheme base16-github
  -- colorscheme base16-precious-light-white
  -- colorscheme base16-rose-pine-dawn
  -- colorscheme base16-selenized-light
  -- colorscheme base16-standardized-light
  {
    "RRethy/base16-nvim",
    config = function()
      require("base16-colorscheme").with_config({
        telescope = true,
        indentblankline = true,
        notify = true,
        ts_rainbow = true,
        cmp = true,
        illuminate = true,
        dapui = true,
      })
    end,
  },
  -- colorscheme dayfox
  -- colorscheme dawnfox
  {
    "EdenEast/nightfox.nvim",
    opts = {
      options = {
        styles = {
          comments = "italic",
          keywords = "bold",
          types = "italic,bold",
        },
      },
    },
  },
}
