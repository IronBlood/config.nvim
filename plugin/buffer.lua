local function wipe_hidden_non_terminal_buffers()
  local bufnrs = vim.tbl_filter(function(bufnr)
    -- must be listed
    if 1 ~= vim.fn.buflisted(bufnr) then
      return false
    end

    -- must be loaded
    if not vim.api.nvim_buf_is_loaded(bufnr) then
      return false
    end

    -- skip terminal buffers
    if vim.api.nvim_get_option_value("buftype", { buf = bufnr }) == "terminal" then
      return false
    end

    -- skip visible buffers
    if vim.fn.bufwinnr(bufnr) ~= -1 then
      return false
    end

    return true
  end, vim.api.nvim_list_bufs())

  for _, bufnr in ipairs(bufnrs) do
    vim.api.nvim_buf_delete(bufnr, { force = true })
  end
end

vim.api.nvim_create_user_command("WipeUnusedBuffers", wipe_hidden_non_terminal_buffers, {
  desc = "Delete all non-visible, non-terminal, listed buffers",
})
