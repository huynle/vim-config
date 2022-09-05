if not pcall(require, "kommentary") then
  return
end

local util = require("hle.util")

-- require("kommentary.config").configure_language("default", { prefer_single_line_comments = true })
require("kommentary.config").configure_language("default", {
  prefer_single_line_comments = true,
  use_consistent_indentation = true
})

vim.g.kommentary_create_default_mappings = false

util.nnomap("<leader>v", "<Plug>kommentary_line_default")
util.vnomap("<leader>v", "<Plug>kommentary_visual_default")
