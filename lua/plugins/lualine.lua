--- @param trunc_width number trunctates component when screen width is less then trunc_width
--- @param trunc_len number truncates component to trunc_len number of chars
--- @param hide_width number | nil hides component when window width is smaller then hide_width
--- @param no_ellipsis boolean whether to disable adding '...' at end after truncation
--- @return fun(str: string): string that can format the component accordingly
local function trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
  return function(str)
    local win_width = vim.fn.winwidth(0)
    if hide_width and win_width < hide_width then
      return ""
    elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
      return str:sub(1, trunc_len) .. (no_ellipsis and "" or "...")
    end
    return str
  end
end

local function show_tw()
  local space = vim.fn.search([[\s\+$]], "nwc")
  return space ~= 0 and "TW:" .. space or ""
end

local function show_mi_ib()
  local s_pat = "\\v^ +[^\\*]" -- space pattern
  local t_pat = "\\v^\\t+[^\\*]" -- tab pattern

  local s_indent = vim.fn.search(s_pat, "nwc")
  local t_indent = vim.fn.search(t_pat, "nwc")

  local mixed = (s_indent > 0 and t_indent > 0)
  local mixed_same_line

  if not mixed then
    local t_s = "(^\\t+ )" -- tab then space pattern
    local s_t = "(^ +\\t)" -- space then tab pattern
    local ts_st_pat = string.format("\\v(%s|%s)[^\\*]", t_s, s_t)
    mixed_same_line = vim.fn.search(ts_st_pat, "nwc")
    mixed = mixed_same_line > 0
  end

  if not mixed then
    return ""
  end

  if mixed_same_line ~= nil and mixed_same_line > 0 then
    return "MI!!:" .. mixed_same_line
  end

  local s_indent_cnt = vim.fn.searchcount({ pattern = s_pat, max_count = 1e3 }).total
  local t_indent_cnt = vim.fn.searchcount({ pattern = t_pat, max_count = 1e3 }).total

  if s_indent_cnt > t_indent_cnt then
    return string.format("MI:%s(%d)", t_indent, t_indent_cnt)
  else
    return string.format("MI:%s(%d)", s_indent, s_indent_cnt)
  end
end

return {
  "nvim-lualine/lualine.nvim",
  opts = {
    sections = {
      lualine_a = {
        { "mode", fmt = trunc(80, 4, nil, true) },
      },
      lualine_x = {
        {
          require("lazy.status").updates,
          cond = require("lazy.status").has_updates,
          color = { fg = "#ff9e64" },
        },
        "encoding",
        "fileformat",
        "filetype",
      },
      lualine_z = {
        "location",
        { show_tw },
        { show_mi_ib },
      },
    },
    options = {
      component_separators = "",
      section_separators = { left = "", right = "" },
      disabled_filetypes = { "NvimTree", "query", "terminal" },
    },
  },
}
