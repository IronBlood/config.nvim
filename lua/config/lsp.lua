local parsed = require("utils.dotenv").parse_plugin_env()
local set = vim.keymap.set

-- [[ Configure LSP ]]
local M = {}

---@param list (string|table)[]
---@param replacement table
local function update_ensure_installed(list, replacement)
  for i, v in ipairs(list) do
    if type(v) == "string" and v == replacement[1] then
      list[i] = replacement
      break
    end
  end
end

M.setup = function()
  --  This function gets run when an LSP attaches to a particular buffer.
  --    That is to say, every time a new file is opened that is associated with
  --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
  --    function will be executed to configure the current buffer
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
    callback = function(event)
      -- This function lets us more easily to define mappings specific
      -- for LSP related items. It sets the mode, buffer and description
      -- for us each time.
      ---@param keys string
      ---@param func function
      ---@param desc string
      ---@param mode (string|string[])?
      local map = function(keys, func, desc, mode)
        mode = mode or "n"
        if desc then
          desc = "LSP: " .. desc
        end

        set(mode, keys, func, { buffer = event.buf, desc = desc })
      end

      local builtin = require("telescope.builtin")
      -- stylua: ignore start
      map("grn", vim.lsp.buf.rename,                    "[R]e[n]ame")
      map("gra", vim.lsp.buf.code_action,               "[C]ode [A]ction", { "x", "n" })
      map("grr", builtin.lsp_references,                "[G]oto [R]eferences")
      map("gri", builtin.lsp_implementations,           "[G]oto [I]mplementation")
      map("grd", builtin.lsp_definitions,               "[G]oto [D]efinition")
      map("grD", vim.lsp.buf.declaration,               "[G]oto [D]eclaration")
      map("gO",  builtin.lsp_document_symbols,          "Open Document Symbols")
      map("gW",  builtin.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
      map("grt", builtin.lsp_type_definitions,          "Type [D]efinition")
      map("K",   function()
        vim.lsp.buf.hover({
          border = 'rounded'
        })
      end, "Hover Documentation")
      -- Lesser used LSP functionality
      map("<leader>wa", vim.lsp.buf.add_workspace_folder,    "[W]orkspace [A]dd Folder")
      map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
      -- stylua: ignore end
      map("<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, "[W]orkspace [L]ist Folders")

      -- Create a command `:Format` local to the LSP buffer
      vim.api.nvim_buf_create_user_command(event.buf, "Format", function(_)
        vim.lsp.buf.format()
      end, { desc = "Format current buffer with LSP" })

      -- This function resolves a difference between different neovim stable versions 0.11 and 0.10
      ---@param client vim.lsp.Client
      ---@param method vim.lsp.protocol.Method
      ---@param bufnr? integer some lsp support methods only in specific files
      ---@return boolean
      local function client_supports_method(client, method, bufnr)
        if vim.fn.has("nvim-0.11") == 1 then
          ---@diagnostic disable-next-line: param-type-mismatch
          return client:supports_method(method, bufnr)
        else
          ---@diagnostic disable-next-line: param-type-mismatch
          return client.supports_method(method, { bufnr = bufnr })
        end
      end

      -- The following two autocommands are used to highlight references of the
      -- word under your cursor when your cursor rests there for a little while.
      --    See `:help CursorHold` for information about when this is executed
      --
      -- When you move your cursor, the highlights will be cleared (the second autocommand).
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if
        client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
      then
        local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.clear_references,
        })
      end

      vim.api.nvim_create_autocmd("LspDetach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
        end,
      })

      -- The following autocommand is used to enable inlay hints in your
      -- code, if the language server you are using supports them
      --
      -- This may be unwanted, since they displace some of your code
      if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
        map("<leader>th", function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
        end, "[T]oggle Inlay [H]ints")
      end
    end,
  })

  -- Diagnostic Config
  -- See :help vim.diagnostic.Opts
  vim.diagnostic.config({
    severity_sort = true,
    float = { border = "rounded", source = "if_many" },
    underline = { severity = vim.diagnostic.severity.ERROR },
    -- stylua: ignore start
    signs = vim.g.have_nerd_font and {
      text = {
        [vim.diagnostic.severity.ERROR] = "󰅚 ",
        [vim.diagnostic.severity.WARN]  = "󰀪 ",
        [vim.diagnostic.severity.INFO]  = "󰋽 ",
        [vim.diagnostic.severity.HINT]  = "󰌶 ",
        },
      }
    or {},
    -- stylua: ignore end
    virtual_text = {
      source = "if_many",
      spacing = 2,
      format = function(diagnostic)
        -- stylua: ignore
        local diagnostic_message = {
          [vim.diagnostic.severity.ERROR] = diagnostic.message,
          [vim.diagnostic.severity.WARN]  = diagnostic.message,
          [vim.diagnostic.severity.INFO]  = diagnostic.message,
          [vim.diagnostic.severity.HINT]  = diagnostic.message,
        }
        return diagnostic_message[diagnostic.severity]
      end,
    },
  })

  -- Enable the following language servers
  --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
  --
  --  Add any additional override configuration in the following tables. They will be passed to
  --  the `settings` field of the server config. You must look up that documentation yourself.
  --
  --  If you want to override the default filetypes that your language server will attach to you can
  --  define the property 'filetypes' to the map in question.
  local servers = {
    bashls = {},
    cmake = {},
    clangd = {},
    eslint = {},
    gopls = {},
    jdtls = {},
    jsonls = {
      settings = {
        json = {
          schemas = require("schemastore").json.schemas({
            select = {
              ".eslintrc",
              "babelrc.json",
              "jsconfig.json",
              "tsconfig.json",
              "package.json",
              "prettierrc.json",
            },
          }),
          validate = { enable = true },
        },
      },
    },
    lua_ls = {
      settings = {
        Lua = {
          -- This is not official yet
          -- See LuaLS/lua-language-server#3155
          addonRepositoryPath = parsed.addonRepositoryPath,
          completion = {},
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
        },
      },
    },
    pyright = {},
    rust_analyzer = {
      settings = {
        ["rust-analyzer"] = {
          diagnostics = {
            enable = false,
          },
        },
      },
    },
    svelte = {},
    ts_ls = {
      init_options = {
        preferences = {
          disableSuggestions = true,
        },
      },
    },
    vuels = {
      init_options = {
        vue = {
          -- TODO https://github.com/vuejs/language-tools/pull/5248
          hybridMode = false,
        },
      },
    },
    yamlls = {
      settings = {
        schemaStore = {
          enable = false,
          url = "",
        },
        schemas = require("schemastore").yaml.schemas({
          select = {
            "GitHub Workflow",
            "docker-compose.yml",
          },
        }),
      },
    },
  }
  servers["copilot-language-server"] = {}

  -- LSP servers and clients are able to communicate to each other what features they support.
  --  By default, Neovim doesn't support everything that is in the LSP specification.
  --  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
  --  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
  local capabilities = require("blink.cmp").get_lsp_capabilities()

  -- Ensure the servers and tools above are installed
  local ensure_installed = vim.tbl_keys(servers or {})
  vim.list_extend(ensure_installed, {
    "stylua", -- Used to format Lua code
  })

  update_ensure_installed(ensure_installed, {
    "gopls",
    condition = function()
      return vim.fn.executable("go") == 1
    end,
  })
  update_ensure_installed(ensure_installed, {
    "jdtls",
    condition = function()
      return vim.fn.executable("java") == 1
    end,
  })
  update_ensure_installed(ensure_installed, {
    "rust_analyzer",
    condition = function()
      return vim.fn.executable("rustc") == 1
    end,
  })
  require("mason-tool-installer").setup({
    ensure_installed = ensure_installed,
  })

  local mason_lspconfig = require("mason-lspconfig")

  ---Normalize server names across toolchains.
  ---@param server_name string
  ---@return string
  local function update_server_name(server_name)
    local replacements = {
      vuels = "vue_ls",
      ["copilot-languag-server"] = "copilot",
    }

    return replacements[server_name] or server_name
  end

  mason_lspconfig.setup({
    ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
    automatic_installation = false,
    handlers = {
      function(server_name)
        local server = servers[server_name] or {}
        server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
        if server_name == "jdtls" then
          server.capabilities.textDocument.completion.completionItem.snippetSupport = false
        end
        server_name = update_server_name(server_name)
        vim.lsp.config(server_name, server)
        vim.lsp.enable(server_name)
      end,
    },
  })

  require("config.luasnip")
  require("snippets")

  require("lsp_lines").setup()
  vim.diagnostic.config({ virtual_text = false })

  vim.keymap.set("", "<leader>l", function()
    local config = vim.diagnostic.config() or {}
    if config.virtual_text then
      vim.diagnostic.config({ virtual_text = false, virtual_lines = true })
    else
      vim.diagnostic.config({ virtual_text = true, virtual_lines = false })
    end
  end, { desc = "Toggle lsp_lines" })
end

-- M.setup()

return M
