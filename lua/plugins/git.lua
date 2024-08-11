local gitsigns = require('gitsigns')
local neogit = require('neogit')
local diffview = require("diffview")
local diffview_actions = require("diffview.actions")


gitsigns.setup {
  signs = {
    add          = { text = '🗸' },
    change       = { text = '✐' },
    delete       = { text = '✗' },
    topdelete    = { text = '✗' },
    changedelete = { text = '✘' },
  },
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 500,
    follow_files = true
  },
  on_attach = function(bufnr)
    local function map(mode, lhs, rhs, opts)
      opts = vim.tbl_extend(
        'force', {noremap = true, silent = true}, opts or {}
      )
      vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
    end

    -- Navigation
    map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", {expr=true})
    map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", {expr=true})

    -- Actions
    map('n', '<leader>hs', ':Gitsigns stage_hunk<CR>')
    map('v', '<leader>hs', ':Gitsigns stage_hunk<CR>')
    map('n', '<leader>hr', ':Gitsigns reset_hunk<CR>')
    map('v', '<leader>hr', ':Gitsigns reset_hunk<CR>')
    map('n', '<leader>hS', '<cmd>Gitsigns stage_buffer<CR>')
    map('n', '<leader>hu', '<cmd>Gitsigns undo_stage_hunk<CR>')
    map('n', '<leader>hR', '<cmd>Gitsigns reset_buffer<CR>')
    map('n', '<leader>hp', '<cmd>Gitsigns preview_hunk<CR>')
    map('n', '<leader>hb', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>')
    map('n', '<leader>tb', '<cmd>Gitsigns toggle_current_line_blame<CR>')
    map('n', '<leader>hd', '<cmd>Gitsigns diffthis<CR>')
    map('n', '<leader>hD', '<cmd>lua require"gitsigns".diffthis("~")<CR>')
    map('n', '<leader>td', '<cmd>Gitsigns toggle_deleted<CR>')

    -- Text object
    map('o', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    map('x', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}

neogit.setup {
}

diffview.setup {
  diff_binaries = false,    -- Show diffs for binaries
  enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
  git_cmd = { "git" },      -- The git executable followed by default args.
  hg_cmd = { "hg" },        -- The hg executable followed by default args.
  use_icons = true,         -- Requires nvim-web-devicons
  show_help_hints = true,   -- Show hints for how to open the help panel
  watch_index = true,       -- Update views and index buffers when the git index changes.
  icons = {                 -- Only applies when use_icons is true.
    folder_closed = "",
    folder_open = "",
  },
  signs = {
    fold_closed = "",
    fold_open = "",
    done = "✓",
  },
  view = {
    -- Configure the layout and behavior of different types of views.
    -- Available layouts:
    --  'diff1_plain'
    --    |'diff2_horizontal'
    --    |'diff2_vertical'
    --    |'diff3_horizontal'
    --    |'diff3_vertical'
    --    |'diff3_mixed'
    --    |'diff4_mixed'
    -- For more info, see ':h diffview-config-view.x.layout'.
    default = {
      -- Config for changed files, and staged files in diff views.
      layout = "diff2_horizontal",
      winbar_info = false,          -- See ':h diffview-config-view.x.winbar_info'
    },
    merge_tool = {
      -- Config for conflicted files in diff views during a merge or rebase.
      layout = "diff3_horizontal",
      disable_diagnostics = true,   -- Temporarily disable diagnostics for conflict buffers while in the view.
      winbar_info = true,           -- See ':h diffview-config-view.x.winbar_info'
    },
    file_history = {
      -- Config for changed files in file history views.
      layout = "diff2_horizontal",
      winbar_info = false,          -- See ':h diffview-config-view.x.winbar_info'
    },
  },
  file_panel = {
    listing_style = "tree",             -- One of 'list' or 'tree'
    tree_options = {                    -- Only applies when listing_style is 'tree'
      flatten_dirs = true,              -- Flatten dirs that only contain one single dir
      folder_statuses = "only_folded",  -- One of 'never', 'only_folded' or 'always'.
    },
    win_config = {                      -- See ':h diffview-config-win_config'
      position = "left",
      width = 35,
      win_opts = {}
    },
  },
  file_history_panel = {
    log_options = {   -- See ':h diffview-config-log_options'
      git = {
        single_file = {
          diff_merges = "combined",
        },
        multi_file = {
          diff_merges = "first-parent",
        },
      },
      hg = {
        single_file = {},
        multi_file = {},
      },
    },
    win_config = {    -- See ':h diffview-config-win_config'
      position = "bottom",
      height = 16,
      win_opts = {}
    },
  },
  commit_log_panel = {
    win_config = {   -- See ':h diffview-config-win_config'
      win_opts = {},
    }
  },
  default_args = {    -- Default args prepended to the arg-list for the listed commands
    DiffviewOpen = {},
    DiffviewFileHistory = {},
  },
  hooks = {},         -- See ':h diffview-config-hooks'
  keymaps = {
    disable_defaults = false, -- Disable the default keymaps
    view = {
      -- The `view` bindings are active in the diff buffers, only when the current
      -- tabpage is a Diffview.
      { "n", "<tab>",       diffview_actions.select_next_entry,              { desc = "Open the diff for the next file" } },
      { "n", "<s-tab>",     diffview_actions.select_prev_entry,              { desc = "Open the diff for the previous file" } },
      { "n", "gf",          diffview_actions.goto_file_edit,                 { desc = "Open the file in the previous tabpage" } },
      { "n", "<C-w><C-f>",  diffview_actions.goto_file_split,                { desc = "Open the file in a new split" } },
      { "n", "<C-w>gf",     diffview_actions.goto_file_tab,                  { desc = "Open the file in a new tabpage" } },
      { "n", "<leader>e",   diffview_actions.focus_files,                    { desc = "Bring focus to the file panel" } },
      { "n", "<leader>b",   diffview_actions.toggle_files,                   { desc = "Toggle the file panel." } },
      { "n", "g<C-x>",      diffview_actions.cycle_layout,                   { desc = "Cycle through available layouts." } },
      { "n", "[x",          diffview_actions.prev_conflict,                  { desc = "In the merge-tool: jump to the previous conflict" } },
      { "n", "]x",          diffview_actions.next_conflict,                  { desc = "In the merge-tool: jump to the next conflict" } },
      { "n", "<leader>co",  diffview_actions.conflict_choose("ours"),        { desc = "Choose the OURS version of a conflict" } },
      { "n", "<leader>ct",  diffview_actions.conflict_choose("theirs"),      { desc = "Choose the THEIRS version of a conflict" } },
      { "n", "<leader>cb",  diffview_actions.conflict_choose("base"),        { desc = "Choose the BASE version of a conflict" } },
      { "n", "<leader>ca",  diffview_actions.conflict_choose("all"),         { desc = "Choose all the versions of a conflict" } },
      { "n", "dx",          diffview_actions.conflict_choose("none"),        { desc = "Delete the conflict region" } },
      { "n", "<leader>cO",  diffview_actions.conflict_choose_all("ours"),    { desc = "Choose the OURS version of a conflict for the whole file" } },
      { "n", "<leader>cT",  diffview_actions.conflict_choose_all("theirs"),  { desc = "Choose the THEIRS version of a conflict for the whole file" } },
      { "n", "<leader>cB",  diffview_actions.conflict_choose_all("base"),    { desc = "Choose the BASE version of a conflict for the whole file" } },
      { "n", "<leader>cA",  diffview_actions.conflict_choose_all("all"),     { desc = "Choose all the versions of a conflict for the whole file" } },
      { "n", "dX",          diffview_actions.conflict_choose_all("none"),    { desc = "Delete the conflict region for the whole file" } },
    },
    diff1 = {
      -- Mappings in single window diff layouts
      { "n", "g?", diffview_actions.help({ "view", "diff1" }), { desc = "Open the help panel" } },
    },
    diff2 = {
      -- Mappings in 2-way diff layouts
      { "n", "g?", diffview_actions.help({ "view", "diff2" }), { desc = "Open the help panel" } },
    },
    diff3 = {
      -- Mappings in 3-way diff layouts
      { { "n", "x" }, "2do",  diffview_actions.diffget("ours"),            { desc = "Obtain the diff hunk from the OURS version of the file" } },
      { { "n", "x" }, "3do",  diffview_actions.diffget("theirs"),          { desc = "Obtain the diff hunk from the THEIRS version of the file" } },
      { "n",          "g?",   diffview_actions.help({ "view", "diff3" }),  { desc = "Open the help panel" } },
    },
    diff4 = {
      -- Mappings in 4-way diff layouts
      { { "n", "x" }, "1do",  diffview_actions.diffget("base"),            { desc = "Obtain the diff hunk from the BASE version of the file" } },
      { { "n", "x" }, "2do",  diffview_actions.diffget("ours"),            { desc = "Obtain the diff hunk from the OURS version of the file" } },
      { { "n", "x" }, "3do",  diffview_actions.diffget("theirs"),          { desc = "Obtain the diff hunk from the THEIRS version of the file" } },
      { "n",          "g?",   diffview_actions.help({ "view", "diff4" }),  { desc = "Open the help panel" } },
    },
    file_panel = {
      { "n", "j",              diffview_actions.next_entry,                     { desc = "Bring the cursor to the next file entry" } },
      { "n", "<down>",         diffview_actions.next_entry,                     { desc = "Bring the cursor to the next file entry" } },
      { "n", "k",              diffview_actions.prev_entry,                     { desc = "Bring the cursor to the previous file entry" } },
      { "n", "<up>",           diffview_actions.prev_entry,                     { desc = "Bring the cursor to the previous file entry" } },
      { "n", "<cr>",           diffview_actions.select_entry,                   { desc = "Open the diff for the selected entry" } },
      { "n", "o",              diffview_actions.select_entry,                   { desc = "Open the diff for the selected entry" } },
      { "n", "l",              diffview_actions.select_entry,                   { desc = "Open the diff for the selected entry" } },
      { "n", "<2-LeftMouse>",  diffview_actions.select_entry,                   { desc = "Open the diff for the selected entry" } },
      { "n", "-",              diffview_actions.toggle_stage_entry,             { desc = "Stage / unstage the selected entry" } },
      { "n", "S",              diffview_actions.stage_all,                      { desc = "Stage all entries" } },
      { "n", "U",              diffview_actions.unstage_all,                    { desc = "Unstage all entries" } },
      { "n", "X",              diffview_actions.restore_entry,                  { desc = "Restore entry to the state on the left side" } },
      { "n", "L",              diffview_actions.open_commit_log,                { desc = "Open the commit log panel" } },
      { "n", "zo",             diffview_actions.open_fold,                      { desc = "Expand fold" } },
      { "n", "h",              diffview_actions.close_fold,                     { desc = "Collapse fold" } },
      { "n", "zc",             diffview_actions.close_fold,                     { desc = "Collapse fold" } },
      { "n", "za",             diffview_actions.toggle_fold,                    { desc = "Toggle fold" } },
      { "n", "zR",             diffview_actions.open_all_folds,                 { desc = "Expand all folds" } },
      { "n", "zM",             diffview_actions.close_all_folds,                { desc = "Collapse all folds" } },
      { "n", "<c-b>",          diffview_actions.scroll_view(-0.25),             { desc = "Scroll the view up" } },
      { "n", "<c-f>",          diffview_actions.scroll_view(0.25),              { desc = "Scroll the view down" } },
      { "n", "<tab>",          diffview_actions.select_next_entry,              { desc = "Open the diff for the next file" } },
      { "n", "<s-tab>",        diffview_actions.select_prev_entry,              { desc = "Open the diff for the previous file" } },
      { "n", "gf",             diffview_actions.goto_file_edit,                 { desc = "Open the file in the previous tabpage" } },
      { "n", "<C-w><C-f>",     diffview_actions.goto_file_split,                { desc = "Open the file in a new split" } },
      { "n", "<C-w>gf",        diffview_actions.goto_file_tab,                  { desc = "Open the file in a new tabpage" } },
      { "n", "i",              diffview_actions.listing_style,                  { desc = "Toggle between 'list' and 'tree' views" } },
      { "n", "f",              diffview_actions.toggle_flatten_dirs,            { desc = "Flatten empty subdirectories in tree listing style" } },
      { "n", "R",              diffview_actions.refresh_files,                  { desc = "Update stats and entries in the file list" } },
      { "n", "<leader>e",      diffview_actions.focus_files,                    { desc = "Bring focus to the file panel" } },
      { "n", "<leader>b",      diffview_actions.toggle_files,                   { desc = "Toggle the file panel" } },
      { "n", "g<C-x>",         diffview_actions.cycle_layout,                   { desc = "Cycle available layouts" } },
      { "n", "[x",             diffview_actions.prev_conflict,                  { desc = "Go to the previous conflict" } },
      { "n", "]x",             diffview_actions.next_conflict,                  { desc = "Go to the next conflict" } },
      { "n", "g?",             diffview_actions.help("file_panel"),             { desc = "Open the help panel" } },
      { "n", "<leader>cO",     diffview_actions.conflict_choose_all("ours"),    { desc = "Choose the OURS version of a conflict for the whole file" } },
      { "n", "<leader>cT",     diffview_actions.conflict_choose_all("theirs"),  { desc = "Choose the THEIRS version of a conflict for the whole file" } },
      { "n", "<leader>cB",     diffview_actions.conflict_choose_all("base"),    { desc = "Choose the BASE version of a conflict for the whole file" } },
      { "n", "<leader>cA",     diffview_actions.conflict_choose_all("all"),     { desc = "Choose all the versions of a conflict for the whole file" } },
      { "n", "dX",             diffview_actions.conflict_choose_all("none"),    { desc = "Delete the conflict region for the whole file" } },
    },
    file_history_panel = {
      { "n", "g!",            diffview_actions.options,                     { desc = "Open the option panel" } },
      { "n", "<C-A-d>",       diffview_actions.open_in_diffview,            { desc = "Open the entry under the cursor in a diffview" } },
      { "n", "y",             diffview_actions.copy_hash,                   { desc = "Copy the commit hash of the entry under the cursor" } },
      { "n", "L",             diffview_actions.open_commit_log,             { desc = "Show commit details" } },
      { "n", "zR",            diffview_actions.open_all_folds,              { desc = "Expand all folds" } },
      { "n", "zM",            diffview_actions.close_all_folds,             { desc = "Collapse all folds" } },
      { "n", "j",             diffview_actions.next_entry,                  { desc = "Bring the cursor to the next file entry" } },
      { "n", "<down>",        diffview_actions.next_entry,                  { desc = "Bring the cursor to the next file entry" } },
      { "n", "k",             diffview_actions.prev_entry,                  { desc = "Bring the cursor to the previous file entry." } },
      { "n", "<up>",          diffview_actions.prev_entry,                  { desc = "Bring the cursor to the previous file entry." } },
      { "n", "<cr>",          diffview_actions.select_entry,                { desc = "Open the diff for the selected entry." } },
      { "n", "o",             diffview_actions.select_entry,                { desc = "Open the diff for the selected entry." } },
      { "n", "<2-LeftMouse>", diffview_actions.select_entry,                { desc = "Open the diff for the selected entry." } },
      { "n", "<c-b>",         diffview_actions.scroll_view(-0.25),          { desc = "Scroll the view up" } },
      { "n", "<c-f>",         diffview_actions.scroll_view(0.25),           { desc = "Scroll the view down" } },
      { "n", "<tab>",         diffview_actions.select_next_entry,           { desc = "Open the diff for the next file" } },
      { "n", "<s-tab>",       diffview_actions.select_prev_entry,           { desc = "Open the diff for the previous file" } },
      { "n", "gf",            diffview_actions.goto_file_edit,              { desc = "Open the file in the previous tabpage" } },
      { "n", "<C-w><C-f>",    diffview_actions.goto_file_split,             { desc = "Open the file in a new split" } },
      { "n", "<C-w>gf",       diffview_actions.goto_file_tab,               { desc = "Open the file in a new tabpage" } },
      { "n", "<leader>e",     diffview_actions.focus_files,                 { desc = "Bring focus to the file panel" } },
      { "n", "<leader>b",     diffview_actions.toggle_files,                { desc = "Toggle the file panel" } },
      { "n", "g<C-x>",        diffview_actions.cycle_layout,                { desc = "Cycle available layouts" } },
      { "n", "g?",            diffview_actions.help("file_history_panel"),  { desc = "Open the help panel" } },
    },
    option_panel = {
      { "n", "<tab>", diffview_actions.select_entry,          { desc = "Change the current option" } },
      { "n", "q",     diffview_actions.close,                 { desc = "Close the panel" } },
      { "n", "g?",    diffview_actions.help("option_panel"),  { desc = "Open the help panel" } },
    },
    help_panel = {
      { "n", "q",     diffview_actions.close,  { desc = "Close help menu" } },
      { "n", "<esc>", diffview_actions.close,  { desc = "Close help menu" } },
    },
  },
}
