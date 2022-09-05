if not pcall(require, "which-key") then
  return
end

-- NOTE: if a function is used, there has to be a name associated to it
local wk = require("which-key")
local util = require("hle.util")

-- run before calling setup
local presets = require("which-key.plugins.presets")

--= disabling these operators
presets.objects["a("] = nil
presets.operators["v"] = nil

wk.setup({ show_help = false, triggers = "auto", plugins = { spelling = true }, key_labels = { ["<leader>"] = "SPC" } })

local normal_opts = {
  mode = "n", -- NORMAL mode
  -- prefix: use "<leader>f" for example for mapping everything related to finding files
  -- the prefix is prepended to every mapping part of `mappings`
  prefix = "",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
}

local localleader = {
  -- t = {"<cmd>Template<CR>"},
  y = {
    name = "+yanking",
    f = { ':let @"=expand("%:p")<CR>:OSCYankReg "<CR>', "File Path" },
    p = { ':let @"=expand("%:p:h")<CR>:OSCYankReg "<CR>', "Dir Path" },
  },

  c = {
    name = "+code",
    o = { "<cmd>Vista focus<CR>", "Code Outline" },
  },

  t = {
    name = "+toggle",
    w = {
      function()
        util.toggle("wrap")
      end,
      "Word Wrap",
    },
    o = { "<cmd>Vista!!<CR>", "Code Outline" },
    n = {
      function()
        util.toggle("relativenumber", true)
        util.toggle("number")
      end,
      "Line Numbers",
    },
    s = {
      function()
        util.toggle("spell")
      end,
      "Spelling",
    },
  },

  g = {
    name = "+git/diff",
    d = {
      function()
        local branch   = vim.fn.input("branch > ")
        local filepath = vim.fn.expand("%")
        local exec_cmd = "DiffviewOpen " .. branch .. " -- " .. filepath
        P(exec_cmd)
        vim.cmd(exec_cmd)
      end, "Against <branch>"
    },
    h = {
      function()
        local filepath = vim.fn.expand("%")
        local exec_cmd = "DiffviewFileHistory " .. filepath
        P(exec_cmd)
        vim.cmd(exec_cmd)
      end, "Git History"
    },
    r = {
      function()
        local filepath = vim.fn.expand("%")
        local exec_cmd = "DiffviewOpen HEAD~1 -- " .. filepath
        P(exec_cmd)
        vim.cmd(exec_cmd)
      end, "Against most recent"
    },
  },

  a = { "<cmd>NvimTreeFindFile<CR>", 'NvimTree File' },
  e = { "<cmd>NvimTreeToggle<CR>", 'NvimTree Toggle' },

}




-- #############


local leader = {
  a = {
    name = "+attach",
    c = { [[<cmd>PasteImg<CR>]], "Clipboard Image" },
  },


  l = {
    name = "+LSP",
    i = { "<cmd>LspInfo<CR>", "LspInfo" },
    l = { "<cmd>LspLog<CR>", "LspLog" },
    r = { "<cmd>LspRestart<CR>", "LspRestart" }
  },


  g = {
    name = "+git/diff",
    s = { "<cmd>Neogit<CR>", "NeoGit" },
    l = {
      function()
        require("hle.util").float_terminal("lazygit")
      end,
      "lazygit",
    },

    d = {
      function()
        local branch = vim.fn.input("branch > ")
        local path   = vim.fn.input("path > ")
        vim.cmd("DiffviewOpen " .. branch .. " -- " .. path)
      end, "DiffOpen <branch>"
    },
    h = {
      function()
        local path = vim.fn.input("folder > ")
        vim.cmd("DiffviewFileHistory " .. path)
      end, "DiffOpenHistory <path>"
    },
    o = { "<cmd>DiffviewOpen<CR>", "DiffOpen" },
    m = { "<cmd>DiffviewOpen master<CR>", "DiffOpen master" },
    r = { "<cmd>DiffviewOpen HEAD~1<CR>", "DiffOpen HEAD~1" },
  },

  p = {
    name = "+Packer",
    p = { "<cmd>PackerSync<cr>", "Sync" },
    s = { "<cmd>PackerStatus<cr>", "Status" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    c = { "<cmd>PackerCompile<cr>", "Compile" },
  },

  S = { "<cmd>Scratch<CR>", "Scratch Pad" },

  t = {
    name = "+Tasks/Tests",
    -- t = {":!task add", "add"},
    t = {
      -- function()
      --   local t = vim.fn.input("task > ")
      --   vim.cmd(":!task add ".. t)
      -- end, "add"
      function()
        require("hle.util").float_terminal("tui")
      end,
      "TaskTUI",
    },


  },

  -- for neovim test files
  T = { "<Plug>PlenaryTestFile", "Test Spec file" },

  d = {
    name = "+dev",
    t = { "<cmd>TSPlaygroundToggle<CR>", "TS Playground" },
    h = { "<cmd>lua require('osv').launch({port=6161, log=true})<CR>", "Nvim DAP Server" },
    H = { "<cmd>lua require('osv').stop()<CR>", "Stop Nvim DAP Server" },
  },

  o = {
    name = "+open",
    q = { require 'hle.util.user'.qflist.toggle, "Quickfix" },
    l = { require 'hle.util.user'.loclist.toggle, "Location" },
    k = { "<cmd>GkeepToggle<CR>", "Gkeep" },
    d = { '<cmd>DBUIToggle<CR>', "DadbodUI" },
    p = { "<cmd>MarkdownPreview<CR>", 'MarkdownPreview' },
  },

  x = {
    name = "+errors",
    x = { "<cmd>TroubleToggle<cr>", "Trouble" },
    w = { "<cmd>TroubleWorkspaceToggle<cr>", "Workspace Trouble" },
    d = { "<cmd>TroubleDocumentToggle<cr>", "Document Trouble" },
    t = { "<cmd>TodoTrouble<cr>", "Todo Trouble" },
    T = { "<cmd>TodoTelescope<cr>", "Todo Telescope" },
    l = { "<cmd>lopen<cr>", "Open Location List" },
    q = { "<cmd>copen<cr>", "Open Quickfix List" },
    -- ["?"] = { "<cmd>", "Open Quickfix List" },
  },

  ["e"] = {
    name = "+edit configs",
    n = { R('hle.telescope')['edit_neovim'], "Edit Nvim" },
    d = { R('hle.telescope')['edit_dotfiles'], "Edit Dotfiles" },
    e = { "<cmd>:LocalVimRCEdit<cr>", "Edit LocalVimRC (editor settings)" }
  },


  ["<tab>"] = {
    name = "workspace",
    ["<tab>"] = { "<cmd>tabnew<CR>", "New Tab" },

    n = { "<cmd>tabnext<CR>", "Next" },
    d = { "<cmd>tabclose<CR>", "Close" },
    p = { "<cmd>tabprevious<CR>", "Previous" },
    ["]"] = { "<cmd>tabnext<CR>", "Next" },
    ["["] = { "<cmd>tabprevious<CR>", "Previous" },
    f = { "<cmd>tabfirst<CR>", "First" },
    l = { "<cmd>tablast<CR>", "Last" },
  },

}


for i = 0, 10 do
  leader[tostring(i)] = "which_key_ignore"
end

util.nnoremap("!!", "<cmd>Dispatch!<cr>")

wk.register(leader, { prefix = "<leader>" }, normal_opts)
wk.register(localleader, { prefix = "<localleader>" }, normal_opts)
