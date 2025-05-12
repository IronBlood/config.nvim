local get_code

return {
  "olimorris/codecompanion.nvim",
  -- setup
  opts = {
    strategies = {
      chat = {
        adapter = "ollama",
        keymaps = {
          send = {
            modes = {
              n = "<C-s>",
              i = "<C-s>",
            },
          },
          close = {
            modes = {
              n = "<C-c>",
              i = "<C-c>",
            },
          },
        },
        roles = {
          ---@type string|fun(adapter: CodeCompanion.Adapter): string
          llm = function(adapter)
            return "CodeCompanion (" .. adapter.formatted_name .. ")"
          end,
          user = "Me",
        },
      },
      inline = {
        adapter = "codellama",
        keymaps = {
          accept_change = {
            modes = { n = "ga" },
            description = "Accept the suggested change",
          },
          reject_change = {
            modes = { n = "gr" },
            description = "Reject the suggested change",
          },
        },
      },
      cmd = {
        adapter = "codellama",
      },
    },
    adapters = {
      opts = {
        show_defaults = false,
      },
      ollama = function()
        return require("codecompanion.adapters").extend("ollama", {
          schema = {
            model = {
              default = "qwen3:latest",
            },
          },
          num_ctx = {
            default = 16384,
          },
          num_predict = {
            default = -1,
          },
        })
      end,
    },
    display = {
      chat = {
        icons = {
          pinned_buffer = " ",
          watched_buffer = "👀 ",
        },
        auto_scroll = false,
        window = {
          --layout = "float",
          layout = "vertical",
          border = "single",
          height = 0.8,
          width = 0.45,
          relative = "editer",
        },
        intro_message = "Welcome to CodeCompanion ✨! Press ? for options",
        show_header_separator = false,
        separator = "─",
        show_settings = true,
      },
      inline = {
        -- vertical | horizontal | buffer
        layout = "float",
      },
    },
    prompt_library = {
      ["Code Expert"] = {
        strategy = "chat",
        description = "Get some special advice from an LLM",
        opts = {
          mapping = "glce",
          modes = { "v" },
          short_name = "expert",
          auto_submit = true,
          stop_context_insertion = true,
          user_prompt = true,
        },
        prompts = {
          {
            role = "system",
            content = function(context)
              -- stylua: ignore start
              return "I want you to act as a senior "
                  .. context.filetype
                  .. " developer. I will ask you specific questions and I want "
                  .. "you to return concise explanations and codeblock examples. /no_think"
              -- stylua: ignore end
            end,
          },
          {
            role = "user",
            content = function(context)
              if not get_code then
                get_code = require("codecompanion.helpers.actions").get_code
              end

              local text = get_code(context.start_line, context.end_line)
              -- stylua: ignore start
              return "I have the follwing code:\n\n```"
                  .. context.filetype
                  .. "\n"
                  .. text
                  .. "\n```\n\n"
              -- stylua: ignore end
            end,
            opts = {
              contains_code = true,
            },
          },
        },
      },
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
}
