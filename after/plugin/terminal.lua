if not pcall(require, "toggleterm") then
  return
end

local util = require "hle.util"
require("toggleterm").setup({
  size = 20,
  hide_numbers = true,
  open_mapping = [[<M-`>]],
  shade_filetypes = {},
  shade_terminals = false,
  shading_factor = 0.3, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  start_in_insert = true,
  persist_size = true,
  direction = "horizontal",
})

-- Hide number column for
-- vim.cmd [[au TermOpen * setlocal nonumber norelativenumber]]

local Terminal = require('toggleterm.terminal').Terminal
--toggleterm = require 'toggleterm'

--toggleterm.setup{
--  -- size = 20,
--  hide_numbers = false,
--  open_mapping = [[<A-`>]],
--  shade_filetypes = {},
--  shade_terminals = false,
--  shading_factor = 1, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
--  start_in_insert = false,
--  insert_mappings = true,
--  persist_size = true,
--  direction = "horizontal",

--  -- size can be a number or function which is passed the current terminal
--  size = function(term)
--    if term.direction == "horizontal" then
--      return 15
--    elseif term.direction == "vertical" then
--      return vim.o.columns * 0.4
--    end
--  end,
--}

local lazygit = Terminal:new({ cmd = "top", count = 1 })

-- local lazygit = Terminal:new({
--   -- cmd = "top",
--   count = 5,
--   -- dir = "git_dir",
--   direction = "float",
--   float_opts = {
--     border = "double",
--   },
--   -- -- function to run on opening the terminal
--   -- on_open = function(term)
--   --   vim.cmd("startinsert!")
--   --   vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
--   -- end,
--   -- -- function to run on closing the terminal
--   -- on_close = function(term)
--   --   vim.cmd("Closing terminal")
--   -- end,
-- })

local function _lazygit_toggle()
  lazygit:toggle()
end

-- FIXME: integrate some of this stuff into vim
-- just open neovim terminal, for the current file under the cursor using visidata
-- nnoremap g1 <cmd>vsplit term://vd <cfile><CR>
-- using tmux terminal
-- nnoremap g1 <cmd>!tmux new-window vd <cfile><CR>
-- Send Commands to a Terminal
-- Open a vertical split with a terminal :vsp | terminal.
-- Open a Python interpreter (type python).
-- Now type :echo b:terminal_job_id to get the terminal job id. In my case the id is 4.
-- Run the command :call chansend(4, [“print(‘hello’)”, “print(‘world’)”, “”]). This will send 2 Python statements to the Python interpreter.

-- Send Commands to a Terminal
-- Type :h chansend to read the documentation.
-- Check out this article on the plugins that we can use for this purpose, including integration with Jupyter notebook.



---- Hide number column for
--vim.cmd [[au TermOpen * setlocal nonumber norelativenumber]]

-- -- much better to exit, since you could be in a nvim terminal inside the
-- -- Esc twice to get to normal mode
-- util.tnoremap('<esc><esc>', '<C-\\><C-N>')
-- -- util.tnoremap('<C-o><C-i>', '<C-\\><C-n>')
-- util.tnoremap('<A-j><A-k>', '<C-\\><C-n>')
-- util.tnoremap('<C-j><C-k>', '<C-\\><C-n>')

---- NOTE: can be toggled with M-` also
-- util.nnoremap([[<A-`>]], "<cmd>lua _lazygit_toggle()<CR>")
util.nnoremap([[<A-`>]], "<cmd>1ToggleTerm direction='float'<CR>")
---- util.nnoremap([[<A-1>]], "<cmd>2ToggleTerm direction='horizontal'<CR>")
---- util.nnoremap([[<A-2>]], "<cmd>3ToggleTerm direction='horizontal'<CR>")
---- util.nnoremap([[<A-3>]], "<cmd>4ToggleTerm direction='horizontal'<CR>")
---- util.nnoremap([[<leader>4v]], "<cmd>4ToggleTerm direction='vertical'<CR>")
