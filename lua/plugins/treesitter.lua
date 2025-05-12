return {
  -- Highlight, edit, and navigate code
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  main = "nvim-treesitter.configs", -- Sets main module to use for opts
  build = ":TSUpdate",
  -- `master` is the stable branch, while `main` is a rewrite, WIP and imcompatible version
  branch = "master",
  lazy = false,
  config = function()
    require("config.treesitter").setup()
  end,
}
