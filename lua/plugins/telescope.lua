return {
  "nvim-telescope/telescope.nvim",
  tag = "v0.2.1",
  event = "VimEnter",
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system
    -- requirements installed.
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      -- NOTE: If you are having trouble with this installation,
      --       refer to the README for telescope-fzf-native for more instructions.
      build = function()
        if vim.fn.has("win32") == 1 then
          -- make sure CMake, and the Microsoft C++ Build Tools are installed on Windows
          return "mingw32-make"
        else
          -- for Linux and Linux-like systems
          return "make"
        end
      end,
      cond = function()
        -- Windows + msys2
        if vim.fn.has("win32") == 1 then
          return vim.fn.executable("mingw32-make") == 1
        end

        -- Linux and Linux-like
        return vim.fn.executable("make") == 1
      end,
    },
    "nvim-telescope/telescope-ui-select.nvim",

    -- Useful for getting pretty icons, but requires a Nerd Font.
    { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
  },
  config = function()
    require("config.telescope")
  end,
}
