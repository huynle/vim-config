local ok, bufferline = pcall(require, "bufferline")
if not ok then
  return
end

local util = require'hle.util'


bufferline.setup({
  options = {
    show_close_icon = true,
    -- diagnostics = "nvim_lsp",
    diagnostics = "",
    always_show_bufferline = false,
    separator_style = "slant",
    diagnostics_indicator = function(_, _, diagnostics_dict)
      local s = " "
      for e, n in pairs(diagnostics_dict) do
        local sym = e == "error" and " " or (e == "warning" and " " or "")
        s = s .. sym .. n
      end
      return s
    end,
  },
})


local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

util.nnoremap('L', ':BufferLineCycleNext<CR>')
util.nnoremap('H', ':BufferLineCyclePrev<CR>')
util.nnoremap('<A-h>', ':BufferLineMovePrev<CR>')
util.nnoremap('<A-l>', ':BufferLineMoveNext<CR>')
util.nnoremap('<leader>be', ':BufferLineSortByExtension<CR>')
util.nnoremap('<leader>bd', ':BufferLineSortByDirectory<CR>')
