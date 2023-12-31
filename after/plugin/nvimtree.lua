-- eat warnings
local vim = vim

-- require("nvim-tree").setup()
local tree = require("nvim-tree")

tree.setup({
  hijack_unnamed_buffer_when_opening = false;
  disable_netrw = false;
  hijack_netrw = false;
  sort = {
    -- sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
    icons = {
        glyphs = {
            git = {
            }
        },
    },
  },
  filters = {
    dotfiles = false,
    git_ignored = false
  },
})

vim.keymap.set("n", "<Leader>nt", ":NvimTreeToggle<CR>")
vim.keymap.set("n", "<Leader>nf", ":NvimTreeFindFile<CR>")
vim.keymap.set("n", "<Leader>nc", ":NvimTreeCollapse<CR>")
