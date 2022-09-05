--if not pcall(require, "material") then
--  return
--end

---- vim.g.material_style = "deep ocean"
---- vim.g.material_style = "lighter"

--vim.g.sonokai_style = "atlantis"
--vim.g.sonokai_enable_italic = 1
--vim.g.sonokai_disable_italic_comment = 1
--vim.g.sonokai_diagnostic_virtual_text = "colored"

--vim.g.edge_style = "neon"
--vim.g.edge_enable_italic = 1
--vim.g.edge_disable_italic_comment = 0
--vim.g.edge_transparent_background = 1

--vim.g.one_nvim_transparent_bg = true

--vim.g.embark_terminal_italics = 1

--vim.g.nightflyTransparent = 0

--vim.g.nvcode_termcolors = 256


--vim.g.tokyonight_dev = true
--vim.g.tokyonight_style = "storm"
--vim.g.tokyonight_sidebars = {
--  "qf",
--  "vista_kind",
--  "terminal",
--  "packer",
--  "spectre_panel",
--  "NeogitStatus",
--  "help",
--}
--vim.g.tokyonight_cterm_colors = false
--vim.g.tokyonight_terminal_colors = true
--vim.g.tokyonight_italic_comments = true
--vim.g.tokyonight_italic_keywords = true
--vim.g.tokyonight_italic_functions = false
--vim.g.tokyonight_italic_variables = false
--vim.g.tokyonight_transparent = true
--vim.g.tokyonight_hide_inactive_statusline = true
--vim.g.tokyonight_dark_sidebar = true
--vim.g.tokyonight_dark_float = true
--vim.g.tokyonight_colors = {}
---- vim.g.tokyonight_colors = { border = "orange" }

--vim.g.onedark_style = 'deep'
--vim.g.onedark_transparent_background = true-- By default it is false


---- =======
---- require("tokyonight").colorscheme()

---- vim.cmd("colorscheme one-nvim") -- Put your favorite colorscheme here
----
---- vim.cmd("colorscheme edge") -- Put your favorite colorscheme here
----
---- vim.cmd('colorscheme base16-onedark')

---- require('onedark').setup()

---- ======

--require('material').setup({
--  -- contrast = {
--  --   sidebars = true, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
--  --   floating_windows = false, -- Enable contrast for floating windows
--  --   line_numbers = false, -- Enable contrast background for line numbers
--  --   sign_column = false, -- Enable contrast background for the sign column
--  --   cursor_line = false, -- Enable darker background for the cursor line
--  --   non_current_windows = false, -- Enable darker background for non-current windows
--  --   popup_menu = false, -- Enable lighter background for the popup menu
--  -- }, -- Enable contrast for sidebars, floating windows and popup menus like Nvim-Tree

--  -- italics = {
--  --   comments = false, -- Enable italic comments
--  --   keywords = false, -- Enable italic keywords
--  --   functions = false, -- Enable italic functions
--  --   strings = false, -- Enable italic strings
--  --   variables = false -- Enable italic variables
--  -- },

--  -- contrast_filetypes = { -- Specify which filetypes get the contrasted (darker) background
--  -- "terminal", -- Darker terminal background
--  -- "packer", -- Darker packer background
--  -- "qf" -- Darker qf list background
--  -- },

--  high_visibility = {
--    lighter = false, -- Enable higher contrast text for lighter style
--    darker = false -- Enable higher contrast text for darker style
--  },

--  disable = {
--    borders = false, -- Disable borders between verticaly split windows
--    background = true, -- Prevent the theme from setting the background (NeoVim then uses your teminal background)
--    term_colors = false, -- Prevent the theme from setting terminal colors
--    eob_lines = false -- Hide the end-of-buffer lines
--  },

--  -- custom_highlights = {} -- Overwrite highlights with your own

--})


---- -- Default options:
---- local kanagawa = require('kanagawa')
---- local default_colors = require("kanagawa").colors

---- kanagawa.setup({
----   undercurl = true,           -- enable undercurls
----   commentStyle = "italic",
----   functionStyle = "NONE",
----   keywordStyle = "italic",
----   statementStyle = "bold",
----   typeStyle = "NONE",
----   variablebuiltinStyle = "italic",
----   specialReturn = true,       -- special highlight for the return keyword
----   specialException = true,    -- special highlight for exception handling keywords 
----   transparent = false,        -- do not set background color
----   colors = {},
----   overrides = {
----     -- LineNr  = { fg = "#004a87" },
----     LineNr  = { fg = "LightBlue" },
----     Visual =  { fg="LightBlue", bg="#004a87"}
----   },
---- })
---- vim.cmd("colorscheme kanagawa")
