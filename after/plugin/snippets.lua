if not pcall(require, "luasnip") then
  return
end

local util = require("hle.util")
local ls = require("luasnip")

ls.config.set_config({
  history = true,
  -- Update more often, :h events for more info.
  updateevents = "TextChanged,TextChangedI",
})


--- <tab> to jump to next snippet's placeholder
local function on_tab()
  return ls.jump(1) and "" or util.t("<Tab>")
end

--- <s-tab> to jump to next snippet's placeholder
local function on_s_tab()
  return ls.jump(-1) and "" or util.t("<S-Tab>")
end

util.imap("<Tab>", on_tab, { expr = true })
util.smap("<Tab>", on_tab, { expr = true })
util.imap("<S-Tab>", on_s_tab, { expr = true })
util.smap("<S-Tab>", on_s_tab, { expr = true })
util.imap("<C-l>", "<Plug>luasnip-next-choice", {})
util.smap("<C-l>", "<Plug>luasnip-next-choice", {})

---------------------

local snippet = ls.snippet
local text = ls.text_node
local f = ls.function_node
local insert = ls.insert_node


-- Add More snippets here!!
ls.snippets = {
  lua = {
    -- credit: akinsho
    snippet({
      trig = "use",
      name = "packer use",
      dscr = {
        "packer use plugin block",
        "e.g.",
        "use {'author/plugin'}",
      },
    }, {
      text "use { '",
      -- Get the author and URL in the clipboard and auto populate the author and project
      f(function(_)
        local default = "author/plugin"
        local clip = vim.fn.getreg "*"
        if not vim.startswith(clip, "https://github.com/") then
          return default
        end
        local parts = vim.split(clip, "/")
        if #parts < 2 then
          return default
        end
        local author, project = parts[#parts - 1], parts[#parts]
        return author .. "/" .. project
      end, {}),
      text "' ",
      insert(2, { ", config = function()", "", "end" }),
      text "}",
    }),
  },
}



-- LOAD all other snippets here.. including vscode style snippets
-- NOTE: snippet requires package.json file for luasnip to load in the vscode snippets
require('luasnip/loaders/from_vscode').load({paths = './snippets'})

-- NOTE: this second line is required to load in friendly-snippets, AFTER the custom snippets has been added
require("luasnip/loaders/from_vscode").load()

