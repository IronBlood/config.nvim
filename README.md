# Config.nvim

This is my personal configurations for neovim. It may not suit you, but I wish there's something helpful.

## Requirements

* Neovim v0.10+
* Git

## Plugins

* [base16-nvim](https://github.com/RRethy/base16-nvim) - Theme
* [blink.cmp](https://github.com/saghen/blink.cmp) - Completion
* [Catppuccin](https://github.com/catppuccin/nvim) - Theme (Default `catppuccin-frappe`)
* [Cloak](https://github.com/laytan/cloak.nvim) - Overlay `*`'s (or any other character) over defined patterns in defined files
* [codecompanion.nvim](https://github.com/olimorris/codecompanion.nvim) - LLM
* [Colorizer](https://github.com/norcalli/nvim-colorizer.lua) - Color higherligher, currently only enabled for `.css` files.
* [Comment.nvim](https://github.com/numToStr/Comment.nvim) - Comment with motions
* [conform.nvim](https://github.com/stevearc/conform.nvim) - Formatter
* [fidget](https://github.com/j-hui/fidget.nvim) - Extensible UI for neovim notifications and LSP progress messages.
* [Friendly Snippets](https://github.com/rafamadriz/friendly-snippets) - Set of preconfigured snippets for different languages.
* [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) - Git integration
* [hlargs.nvim](https://github.com/m-demare/hlargs.nvim) - Highlight arguments' definitions and usages, using Treesitter
* [ident-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) - This plugin adds indentation guides to Neovim.
* [lazy.nvim](https://github.com/folke/lazy.nvim) - A plugin manager.
* [lazydev.nvim](https://github.com/folke/lazydev.nvim) - Faster LuaLS setup for Neovim.
* [lsp_lines.nvim](https://git.sr.ht/~whynothugo/lsp_lines.nvim) - renders diagnostics using virtual lines on top of the real line of code.
* [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) - A statusline plugin.
* [luasnip](https://github.com/L3MON4D3/LuaSnip) - Snippet Engine for Neovim written in Lua.
* [mason.nvim](https://github.com/mason-org/mason.nvim) - Portable package manager that manages LSP servers, DAP servers, linters and formatters.
* [mason-lspconfig.nvim](https://github.com/mason-org/mason-lspconfig.nvim)
* [mason-tool-installer.nvim](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim) - Install and upgrade 3rd party tools.
* [nightfox.nvim](https://github.com/EdenEast/nightfox.nvim) - Theme
* [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
* [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) - A file explorer.
* [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - Nvim Treesitter configurations and abstraction layer
* [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) - Nerd Font icons.
* [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) - Useful functions written in Lua.
* [sqlite.lua](https://github.com/kkharji/sqlite.lua) - SQLite LuaJIT binding with a very simple api.
* [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) - Fuzzy finder
* [Todo Comments](https://github.com/folke/todo-comments.nvim) - to highlight and search for todo comments like `TODO`, `HACK`, `BUG`, etc.
* [tokyonight.nvim](https://github.com/folke/tokyonight.nvim) - Theme
* [TreeSJ](https://github.com/Wansmer/treesj) - Splitting or joining blocks of code like arrays, hashes, statements, etc.
* [Vim Fugitive](https://github.com/tpope/vim-fugitive) - A git wrapper
* [Which Key](https://github.com/folke/which-key.nvim/) - Shows available keybindings.
* [Zen Mode](https://github.com/folke/zen-mode.nvim) - Distraction-free coding

## Commands

* `:Catppuccin $flavor_name` where `flavor_name = "frappe" | "mocha" | "latte" | "macchiato"` (`latte` is a light theme)
* `:CodeCompanion /expert` select line in `VISUAL` mode first, then type this command and press `ENTER`, then raise the rest questions in the next line.
* `:ClockDisable`, `:ClockEnable` and `:ClockToggle`, currently affects `.env` file only.
* `:Git` (or just `:G`), calls any arbitrary git command.
* `:Gitsigns` probably `blame`, `stage_hunk` and `reset_hunk` are the most useful commands for me at the moment.
* `:Mason`
* `:Lazy`
* `:TSInstall`
* `:ZenMode` toggles zen mode.
