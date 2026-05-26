--- @param tab TabbyTab
local function get_tab_name(tab)
  return string.gsub(tab.name(), "%[..%]", "")
end

--- @param tab TabbyTab
local function get_tab_window_count(tab)
  local count = #tab.wins().wins
  return count > 1 and "[" .. count .. "]" or ""
end

--- Keep one rendered window per buffer while preserving the current-window marker.
--- @param wins TabbyWins
local function unique_buffer_wins(wins)
  local representatives = {}

  for _, win in ipairs(wins.wins) do
    local bufid = win.buf().id
    if representatives[bufid] == nil or win.is_current() then
      representatives[bufid] = win.id
    end
  end

  return wins.filter(function(win)
    return representatives[win.buf().id] == win.id
  end)
end

return {
  "nanozuki/tabby.nvim",
  version = "v2.8.1",
  config = function()
    local theme = {
      fill = "TabLineFill",
      -- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
      head = "TabLine",
      current_tab = "TabLineSel",
      tab = "TabLine",
      win = "TabLine",
      tail = "TabLine",
    }

    require("tabby").setup({
      line = function(line)
        return {
          {
            { "  ", hl = theme.head },
            line.sep("", theme.head, theme.fill),
          },

          line.tabs().foreach(function(tab)
            local hl = tab.is_current() and theme.current_tab or theme.tab
            return {
              line.sep("", hl, theme.fill),
              tab.is_current() and "" or "󰆣",
              tab.number(),
              get_tab_name(tab),
              get_tab_window_count(tab),
              line.sep("", hl, theme.fill),
              hl = hl,
              margin = " ",
            }
          end),

          line.spacer(),

          unique_buffer_wins(line.wins_in_tab(line.api.get_current_tab())).foreach(function(win)
            return {
              line.sep("", theme.win, theme.fill),
              win.is_current() and "" or "",
              win.buf_name(),
              line.sep("", theme.win, theme.fill),
              hl = theme.win,
              margin = " ",
            }
          end),

          {
            line.sep("", theme.tail, theme.fill),
            { "  ", hl = theme.tail },
          },

          hl = theme.fill,
        }
      end,
    })
  end,
}
