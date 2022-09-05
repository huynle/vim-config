local util = require("hle.util")
local wk = require("which-key")
local bufnr = vim.api.nvim_get_current_buf()
local log = require("hle.util.log")

vim.wo.concealcursor = "c"
vim.wo.conceallevel = 3


util.augroup("hleWiki", {
  -- {"BufNewFile", "*/wiki/journal/[0-9]*.md", ":read ~/docs/wiki/templates/notes.md"},
  -- " allow all wiki notes to close with C-c
  { "BufRead,BufNewFile", "*/journal/*.md", "nnoremap <buffer><silent> <C-c> :close!<CR>" },
  { "BufRead,BufNewFile", "*/journal/*.md", "nnoremap <buffer><silent> q :close!<CR>" },
  -- " this is the filetype we should be using for vimwiki
  { "BufEnter", "*", "setlocal concealcursor=c" },
  -- " run hugo post maintenance
  { "BufWritePre", "*/docs/*.md", "silent! HugoHelperLastmodIsNow" },

  -- -- Set textwidth for easy writing
  -- { "BufRead,BufNewFile", "*.md", "setlocal textwidth=80" },
})

-- loads BEFORE global plugins, so it might get overridden by ther plugins

vim.g.markdown_lua_loaded = 1

-- util.nnoremap("\\d", "<cmd>put =strftime(\"%Y-%m-%d\")<CR>")

local opts = { noremap = true, silent = true }

local keymap_goto = {
  f = {
    name = "+find",
    r = { "<cmd>Telescope lsp_references<cr>", "References" },
  }
}

local keymap = {
  i = {
    name = "+insert",
    i = { "<cmd>PasteImg<CR>", "Image" },
  },
}

wk.register(keymap, { buffer = bufnr, prefix = "<localleader>" }, opts)
wk.register(keymap_goto, { buffer = bufnr, prefix = "<localleader>" }, opts)

-- Add the key mappings only for Markdown files in a zk notebook.
if require("zk.util").notebook_root(vim.fn.expand('%:p')) ~= nil then
  local function map(...) vim.api.nvim_buf_set_keymap(0, ...) end

  local opts = { noremap = true, silent = false }

  -- Open the link under the caret.
  map("n", "<CR>", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  map("n", "<C-CR>", "<Cmd>vsplit | lua vim.lsp.buf.definition()<CR>", opts)

  -- Create a new note after asking for its title.
  -- This overrides the global `<leader>zn` mapping to create the note in the same directory as the current buffer.
  -- map("n", "<leader>zn", "<Cmd>ZkNew { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>", opts)
  -- Create a new note in the same directory as the current buffer, using the current selection for title.
  -- map("v", "<leader>znt", ":'<,'>ZkNewFromTitleSelection { dir = vim.fn.expand('%:p:h') , group = 'fleeting'}<CR>", opts)
  -- Create a new note in the same directory as the current buffer, using the current selection for note content and asking for its title.
  -- map("v", "<leader>znc",
  --   ":'<,'>ZkNewFromContentSelection { dir = vim.fn.expand('%:p:h'), grou = 'fleeting', title = vim.fn.input('Title: ') }<CR>"
  --   , opts)

  -- Open notes linking to the current buffer.
  -- map("n", "<leader>zb", "<Cmd>ZkBacklinks<CR>", opts)
  -- Alternative for backlinks using pure LSP and showing the source context.
  --map('n', '<leader>zb', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- Open notes linked by the current buffer.
  -- map("n", "<leader>zl", "<Cmd>ZkLinks<CR>", opts)

else
  log.error("CANNOT load zk for markdown")
end
