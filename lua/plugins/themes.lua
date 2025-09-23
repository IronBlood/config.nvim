return {
  {
    "catppuccin/nvim",
    priority = 1000,
    init = function()
      require("catppuccin").setup({
        compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
        integrations = {
          aerial = false,
          alpha = false,
          barbar = false,
          barbecue = {
            alt_background = false,
            bold_basename = false,
            dim_context = false,
            dim_dirname = false,
          },
          beacon = false,
          -- enabled
          blink_cmp = {
            style = "bordered",
          },
          buffon = false,
          coc_nvim = false,
          colorful_winsep = {
            enabled = false,
          },
          dashboard = false,
          diffview = false,
          dropbar = {
            enabled = false,
          },
          fern = false,
          -- enabled
          fidget = true,
          flash = false,
          fzf = false,
          gitgraph = false,
          -- enabled
          gitsigns = true,
          grug_far = false,
          harpoon = false,
          headlines = false,
          hop = false,
          -- enabled
          indent_blankline = {
            enabled = true,
          },
          leap = false,
          lightspeed = false,
          lir = {
            enabled = false,
            git_status = false,
          },
          lsp_saga = false,
          markdown = false,
          markview = false,
          -- enabled
          mason = true,
          mini = {
            enabled = false,
          },
          neotree = false,
          neogit = false,
          neotest = false,
          noice = false,
          notifier = false,
          copilot_vim = false,
          -- enabled
          dap = true,
          dap_ui = true,
          navic = {
            enabled = false,
          },
          notify = false,
          semantic_tokens = false,
          nvim_surround = false,
          nvimtree = true,
          -- enabled
          treesitter = true,
          treesitter_context = false,
          ts_rainbow2 = false,
          ts_rainbow = false,
          ufo = false,
          window_picker = false,
          octo = false,
          overseer = false,
          pounce = false,
          rainbow_delimiters = false,
          render_markdown = false,
          snacks = {
            enabled = false,
          },
          symbols_outline = false,
          telekasten = false,
          telescope = {
            enabled = true,
          },
          lsp_trouble = false,
          dadbod_ui = false,
          gitgutter = false,
          illuminate = {
            enabled = false,
          },
          sandwich = false,
          signify = false,
          vim_sneak = false,
          vimwiki = false,
          -- enabled
          which_key = true,
        },
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
