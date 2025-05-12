local M = {}

M.setup = function()
  vim.defer_fn(function()
    require("nvim-treesitter.configs").setup({
      modules = {},
      sync_install = false,
      ignore_install = {},
      -- Add languages to be installed here that you want installed for treesitter
      ensure_installed = {
        "bash",
        "c",
        "c_sharp",
        "cmake",
        "comment",
        "cpp",
        "css",
        "csv",
        "cuda",
        "desktop",
        "diff",
        "dockerfile",
        "dot",
        "editorconfig",
        "git_config",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "go",
        "html",
        "ini",
        "java",
        "javascript",
        "jsdoc",
        "json",
        "json5",
        "lua",
        "luadoc",
        "make",
        "markdown",
        "markdown_inline",
        "nginx",
        "query",
        "python",
        "regex",
        "rust",
        "scss",
        "sql",
        "ssh_config",
        "svelte",
        "sway",
        "tsx",
        "tmux",
        "toml",
        "typescript",
        "vimdoc",
        "vim",
        "vue",
        "xml",
        "yaml",
      },

      -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
      auto_install = false,

      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = {},
      },
      indent = { enable = true, disable = { "typescript" } },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<c-space>",
          node_incremental = "<c-space>",
          scope_incremental = "<c-s>",
          node_decremental = "<M-space>",
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]]"] = "@class.outer",
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]["] = "@class.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[]"] = "@class.outer",
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>a"] = "@parameter.inner",
          },
          swap_previous = {
            ["<leader>A"] = "@parameter.inner",
          },
        },
      },
    })
  end, 0)
end

return M
