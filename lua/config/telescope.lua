require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        ["<C-u>"] = false,
        ["<C-d>"] = false,
      },
    },
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown(),
    },
  },
})

local load_extension = require("telescope").load_extension
pcall(load_extension, "fzf")
--pcall(load_extension, "smart_history")
pcall(load_extension, "ui-select")

local builtin = require("telescope.builtin")

-- Telescope live_grep in git root
-- Function to find the git root directory based on the current buffer's path
local function find_git_root()
  -- Use the current buffer's path as the starting point for the git search
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir
  local cwd = vim.fn.getcwd()
  -- If the buffer is not associated with a file, return nil
  if current_file == "" then
    current_dir = cwd
  else
    -- Extract the directory from the current file's path
    current_dir = vim.fn.fnamemodify(current_file, ":h")
  end

  -- Find the Git root directory from the current file's path
  local Job = require("plenary.job")
  local job = Job:new({
    command = "git",
    args = { "rev-parse", "--show-toplevel" },
    cwd = current_dir,
  })
  local ok, res = pcall(function()
    return job:sync()
  end)
  local git_root = (ok and res and res[1]) or nil
  if not git_root or git_root == "" then
    print("Not a git repository. Searching on current working directory")
    return cwd
  end
  return git_root
end

-- Custom live_grep function to search in git root
local function live_grep_git_root()
  local git_root = find_git_root()
  if git_root then
    builtin.live_grep({
      search_dirs = { git_root },
    })
  end
end

vim.api.nvim_create_user_command("LiveGrepGitRoot", live_grep_git_root, {})

local set = vim.keymap.set
local a_cbff = builtin.current_buffer_fuzzy_find
local mrg = require("utils.telescope-multi-rg")
local lub = require("utils.telescope-unsaved-buffers")
local function lg_of()
  builtin.live_grep({
    grep_open_files = true,
    prompt_title = "Live Grep in Open Files",
  })
end
local function ff_lazy()
  builtin.find_files({ cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy") })
end
local function ff_config()
  builtin.find_files({ cwd = vim.fn.stdpath("config") })
end

-- stylua: ignore start
set("n", "<leader>sh", builtin.help_tags,   { desc = "[S]earch [H]elp" })
set("n", "<leader>sk", builtin.keymaps,     { desc = "[S]earch [K]eymaps" })
set("n", "<leader>sf", builtin.find_files,  { desc = "[S]earch [F]iles" })
set("n", "<leader>ss", builtin.builtin,     { desc = "[S]earch [S]elect Telescope" })
set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
set("n", "<leader>sg", mrg,                 { desc = "[S]earch by [G]rep" })
set("n", "<leader>sU", lub,                 { desc = "[S]earch [U]nsaved Buffers" })
set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
set("n", "<leader>sr", builtin.resume,      { desc = "[S]earch [R]esume" })
set("n", "<leader>s.", builtin.oldfiles,    { desc = '[S]earch Recent Files ("." for repeat)' })
set("n", "<leader>sb", builtin.buffers,     { desc = "[ ] Find existing buffers" })
set("n", "<leader>gf", builtin.git_files,   { desc = "Search [G]it [F]iles" })
set("n", "<leader>sG", live_grep_git_root,  { desc = "[S]earch by [G]rep on Git Root" })
set("n", "<leader>/",  a_cbff,              { desc = "[/] Fuzzily search in current buffer" })
set("n", "<leader>s/", lg_of,               { desc = "[S]earch [/] in Open Files" })
set("n", "<leader>sa", ff_lazy,             { desc = "[S]earch L[A]zy" })
set("n", "<leader>sn", ff_config,           { desc = "[S]earch [N]eovim files" })
-- stylua: ignore end
