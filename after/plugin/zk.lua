if not pcall(require, "zk") then
  return
end


local zk = require("zk")
local wk = require "which-key"
local util = require("hle.util")
local zk_util = require("zk.util")
local commands = require("zk.commands")
local Path = require "plenary.path"

local function map(...) vim.api.nvim_buf_set_keymap(0, ...) end

local opts = { noremap = true, silent = false }

local function pasteMdLink(link, name)
  vim.api.nvim_paste(' [' .. name .. ']' .. '(' .. link .. ')', true, -1)
end

local function trueFileName(file)
  return file:match("[^/]*.$")
end

local link_selection = function(entry)
  local type = "rel"
  local link = ""
  local current_path = vim.fn.expand('%:p:h')

  if type == "abs" then
    link = entry.path
  elseif type == "rel" then
    -- resolve any symlink that is goin on
    local r = Path:new(vim.fn.resolve(current_path))
    local p = Path:new(vim.fn.resolve(entry.path))
    link = p:make_relative(r .. r._sep)
  elseif type == "file" then
    link = trueFileName(entry.absPath)
  end

  -- Check if we can write on buffer
  if vim.api.nvim_buf_get_option(vim.api.nvim_get_current_buf(), "modifiable") then
    local linkname = vim.fn.input("Link Name: ")
    if linkname == "" then
      linkname = entry.title
    end
    pasteMdLink(link, linkname)
  end
end


local function make_edit_fn(defaults, picker_options)
  return function(options)
    options = vim.tbl_extend("force", defaults, options or {})
    zk.edit(options, picker_options)
  end
end

commands.add("ZkOrphans", make_edit_fn({ orphan = true }, { title = "Zk Orphans" }))
commands.add("ZkRecents", make_edit_fn({ createdAfter = "2 weeks ago" }, { title = "Zk Recents" }))

commands.add("ZkFlimsyNotes", function(options)
  options = vim.tbl_extend("force", { orphan = true, sort = { "word-count" } }, options or {})
  zk.edit(options, { title = "Zk Flimsy Notes" })
end)

commands.add("ZkMention", function(options)
  options = vim.tbl_extend("force", { mention = { vim.api.nvim_buf_get_name(0) } }, options or {})
  zk.edit(options, { title = "Zk Mentions" })
end)

-- Part of writing a great notebook is to establish links between related notes.
-- The --related <path> option can help by listing results having a linked note in common,
-- but not yet connected to the note.
commands.add("ZkRelated", function(options)
  options = vim.tbl_extend("force", { related = { vim.api.nvim_buf_get_name(0) } }, options or {})
  zk.edit(options, { title = "Zk Related" })
end)

commands.add("ZkFindAndLink", function(options)
  zk.pick_notes(options, { title = "Zk Find and Link", multi_select = false }, link_selection)
end)

commands.add("ZkNewEntry", function(options)
  local options = options or {}
  local location = zk_util.get_lsp_location_from_selection()
  local input_tags = vim.fn.input("Tag: ")
  local input_reference = vim.fn.input("Reference: ")
  local input_title = vim.fn.input("Title: ")
  zk.new(vim.tbl_extend("force", {
    -- insertLinkAtLocation = location,
    dir = options.dir or string.format('%s', util.getEnv('ZK_NOTEBOOK_DIR')),
    -- dir = 'wiki',
    group = options.group or "fleeting",
    title = input_title or "NONE",
    extra = {
      reference = input_reference,
      tag = input_tags }
  },
    options or {}))
end)


commands.add("ZkNewWorkEntry", function(options)
  local options = options or {}
  -- local location = zk_util.get_lsp_location_from_selection()
  -- local input_content = vim.fn.input("Content: ")
  -- TODO: need to parse multiple tags
  local input_tags = vim.fn.input("Tag: ")
  local input_reference = vim.fn.input("Reference: ")
  local input_title = vim.fn.input("Title: ")
  zk.new(vim.tbl_extend("force", {
    -- insertLinkAtLocation = location,
    dir = options.dir or string.format('%s', util.getEnv('ZK_WORK_NOTEBOOK_DIR')),
    -- dir = 'wiki',
    group = options.group or "fleeting",
    -- content = input_content,
    title = input_title or "NONE",
    extra = {
      reference = input_reference,
      tag = input_tags }
  },
    options or {}))
end)


-- commands.add("ZkNewFromContentSelectionHuy", function(options)
--   local location = util.get_lsp_location_from_selection()
--   -- local selected_text = util.get_text_in_range(location.range)
--   local search_text = vim.fn.VisualSelection()
--   dump(selected_text)
--   assert(selected_text ~= nil, "No selected text")
--   zk.new(vim.tbl_extend("force", { insertLinkAtLocation = location, content = selected_text }, options or {}))
-- end, { needs_selection = true })


-- " " some autocommands to help
-- " augroup hleVimwiki
-- "     au!
-- "     " automatically update links on read diary
-- "     " au BufRead,BufNewFile */wiki/journal/_index.md VimwikiDiaryGenerateLinks
-- "     au BufNewFile */wiki/journal/[0-9]*.md :read ~/docs/wiki/templates/notes.md
-- "     " allow all wiki notes to close with C-c
-- "     au BufRead,BufNewFile */wiki/journal/*.md nnoremap <buffer><silent> <C-c> :bdelete<CR>
-- "     au BufRead,BufNewFile */wiki/journal/*.md nnoremap <buffer><silent> q :bdelete<CR>
-- "     " this is the filetype we should be using for vimwiki
-- "     au FileType vimwiki.markdown setlocal concealcursor=c
-- "     " au BufWritePre vimwiki.markdown :HugoHelperLastmodIsNow<CR>
-- " augroup end

-- definitions = {
--   hleWiki = {
--     {"BufRead,BufNewFile", "*/journal/*.md", "nnoremap <buffer><silent> <C-c> :close!<CR>"},
--     {"BufRead,BufNewFile", "*/journal/*.md", "nnoremap <buffer><silent> q :close!<CR>"}
--   },
--   journalEntry = {
--     {"BufRead,BufNewFile", "*/journal/*.md", "G:<C-u>put =strftime('### %H:%M ')<CR>A"},
--   }
-- }

-- util.augroups(definitions)

local zk_maps = {
  ["<leader>z"] = { name = "+Zk" },
  -- ["<leader>z "] = { R('hle.telescope')['find_zettel'], "Tele Finds File" },
  ["<leader>z "] = { "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", "Recently Modified" },
  ["<leader>zo"] = { "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", "Recently Modified" },
  -- ["<leader>zo"] = { "<Cmd>ZkOrphans { sort = { 'modified', 'word-count'} }<CR>", "Find Orphans" },
  ["<leader>zg"] = { R('hle.telescope')['grep_zettels'], "Tele Live Grep" },
  ["<leader>zR"] = { "<cmd>source $VIMPATH/after/plugin/zk.lua<CR>", "Reload Zk" },
  ["<leader>zr"] = { "<cmd>ZkRelated<CR>", "Reload Zk" },
  ["<leader>zf"] = { "<Cmd>ZkNotes { sort = { 'modified' }, match = vim.fn.input('Search: ') }<CR>", "Notes Match" },
  ["<leader>zz"] = { "<Cmd>ZkFindAndLink { sort = { 'modified' }, match = vim.fn.input('Search: ') }<CR>",
    "Match and Link" },
  ["<leader>zn"] = { "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", "New Notes" },
  ["<leader>zt"] = { "<Cmd>ZkTags<CR>", "Search Tags" },
  ["<leader>zB"] = { "<Cmd>ZkFlimsyNotes<CR>", "Find Flimsy Notes" },
  ["<leader>zl"] = { "<Cmd>ZkLinks { sort= {'modified'}}<CR>", "Find Links" },
  ["<leader>zb"] = { "<Cmd>ZkBacklinks{ sort={'modified'}}<CR>", "Find Backlinks" },

  -- only work in ZK_NOTEBOOK_DIR
  ["<leader>n."] = { name = "+NewZk Here" },
  ["<leader>n.r"] = { "<Cmd>ZkNew { dir = vim.fn.expand('%:p:h'), group='reference', title = vim.fn.input('Title: ') }<CR>",
    "reference" },
  ["<leader>n.p"] = { "<Cmd>ZkNew { dir = vim.fn.expand('%:p:h'), group='permanent', title = vim.fn.input('Title: ') }<CR>",
    "permanent" },
  ["<leader>n.l"] = { "<Cmd>ZkNew { dir = vim.fn.expand('%:p:h'), group='literature', title = vim.fn.input('Title: ') }<CR>",
    "literature" },
  ["<leader>n.m"] = { "<Cmd>ZkNew { dir = vim.fn.expand('%:p:h'), group='moc', title = vim.fn.input('Title: ') }<CR>",
    "MOC" },
  ["<leader>n.f"] = { "<Cmd>ZkNew { dir = vim.fn.expand('%:p:h'), group='fleeting', title = vim.fn.input('Title: ') }<CR>",
    "fleeting" },

  ["<leader>nw"] = { name = "+NewZk Wiki" },
  ["<leader>nwr"] = { "<Cmd>ZkNewEntry {dir='wiki', group='reference'}<CR>", "reference" },
  ["<leader>nwp"] = { "<Cmd>ZkNewEntry {dir='wiki', group='permanent'}<CR>", "permanent" },
  ["<leader>nwl"] = { "<Cmd>ZkNewEntry {dir='wiki', group='literature'}<CR>", "literature" },
  ["<leader>nwm"] = { "<Cmd>ZkNewEntry {dir='wiki', group='moc'}<CR>", "MOC" },
  ["<leader>nwf"] = { "<Cmd>ZkNewEntry {dir='wiki', group='fleeting'}<CR>", "fleeting" },

  ["<leader>nl"] = { name = "+NewZk Life" },
  ["<leader>nlr"] = { "<Cmd>ZkNewEntry {dir='life', group='reference'}<CR>", "reference" },
  ["<leader>nlp"] = { "<Cmd>ZkNewEntry {dir='life', group='permanent'}<CR>", "permanent" },
  ["<leader>nll"] = { "<Cmd>ZkNewEntry {dir='life', group='literature'}<CR>", "literature" },
  ["<leader>nlm"] = { "<Cmd>ZkNewEntry {dir='life', group='moc'}<CR>", "MOC" },
  ["<leader>nlf"] = { "<Cmd>ZkNewEntry {dir='life', group='fleeting'}<CR>", "fleeting" },


  ["<leader>nd"] = { name = "+NewZk Work" },
  ["<leader>ndr"] = { "<Cmd>ZkNewWorkEntry { group='reference'}<CR>", "reference" },
  ["<leader>ndp"] = { "<Cmd>ZkNewWorkEntry { group='permanent'}<CR>", "permanent" },
  ["<leader>ndl"] = { "<Cmd>ZkNewWorkEntry { group='literature'}<CR>", "literature" },
  ["<leader>ndm"] = { "<Cmd>ZkNewWorkEntry { group='moc'}<CR>", "MOC" },
  ["<leader>ndf"] = { "<Cmd>ZkNewWorkEntry { group='fleeting'}<CR>", "fleeting" },

}

wk.register(zk_maps)




local v_zk_maps = {
  ["<leader>z"] = { name = "+Zk" },
  ["<leader>zm"] = { ":'<,'>ZkMatch<CR>", "ZkMatch" },

  ["<leader>n"] = { name = "+NewZk" },

  -- only work in ZK_NOTEBOOK_DIR
  ["<leader>n."] = { name = "+NewZk Here" },
  ["<leader>n.r"] = { ":'<,'>ZkNewFromContentSelection {dir=vim.fn.expand('%:p:h'), group='reference', title=vim.fn.input('Title: ')}<CR>",
    "reference" },
  ["<leader>n.p"] = { ":'<,'>ZkNewFromContentSelection {dir=vim.fn.expand('%:p:h'), group='permanent', title=vim.fn.input('Title: ')}<CR>",
    "permanent" },
  ["<leader>n.l"] = { ":'<,'>ZkNewFromContentSelection {dir=vim.fn.expand('%:p:h'), group='literature', title=vim.fn.input('Title: ')}<CR>",
    "literature" },
  ["<leader>n.m"] = { ":'<,'>ZkNewFromContentSelection {dir=vim.fn.expand('%:p:h'), group='moc', title=vim.fn.input('Title: ')}<CR>",
    "MOC" },
  ["<leader>n.f"] = { ":'<,'>ZkNewFromContentSelection {dir=vim.fn.expand('%:p:h'), group='fleeting', title=vim.fn.input('Title: ')}<CR>",
    "fleeting" },

  ["<leader>nw"] = { name = "+NewZk Wiki" },
  ["<leader>nwr"] = { ":'<,'>ZkNewFromContentSelection {dir='wiki', group='reference', title=vim.fn.input('Title: ')}<CR>",
    "reference" },
  ["<leader>nwp"] = { ":'<,'>ZkNewFromContentSelection {dir='wiki', group='permanent', title=vim.fn.input('Title: ')}<CR>",
    "permanent" },
  ["<leader>nwl"] = { ":'<,'>ZkNewFromContentSelection {dir='wiki', group='literature', title=vim.fn.input('Title: ')}<CR>",
    "literature" },
  ["<leader>nwm"] = { ":'<,'>ZkNewFromContentSelection {dir='wiki', group='moc', title=vim.fn.input('Title: ')}<CR>",
    "MOC" },
  ["<leader>nwf"] = { ":'<,'>ZkNewFromContentSelection {dir='wiki', group='fleeting', title=vim.fn.input('Title: ')}<CR>",
    "fleeting" },

  ["<leader>nl"] = { name = "+NewZk Life" },
  ["<leader>nlr"] = { ":'<,'>ZkNewFromContentSelection {dir='life', group='reference', title=vim.fn.input('Title: ')}<CR>",
    "reference" },
  ["<leader>nlp"] = { ":'<,'>ZkNewFromContentSelection {dir='life', group='permanent', title=vim.fn.input('Title: ')}<CR>",
    "permanent" },
  ["<leader>nll"] = { ":'<,'>ZkNewFromContentSelection {dir='life', group='literature', title=vim.fn.input('Title: ')}<CR>",
    "literature" },
  ["<leader>nlm"] = { ":'<,'>ZkNewFromContentSelection {dir='life', group='moc', title=vim.fn.input('Title: ')}<CR>",
    "MOC" },
  ["<leader>nlf"] = { ":'<,'>ZkNewFromContentSelection {dir='life', group='fleeting', title=vim.fn.input('Title: ')}<CR>",
    "fleeting" },

  ["<leader>nd"] = { name = "+NewZk Work" },
  ["<leader>ndr"] = { ":'<,'>ZkNewFromContentSelection {dir='dts', group='reference', title=vim.fn.input('Title: ')}<CR>",
    "reference" },
  ["<leader>ndp"] = { ":'<,'>ZkNewFromContentSelection {dir='dts', group='permanent', title=vim.fn.input('Title: ')}<CR>",
    "permanent" },
  ["<leader>ndl"] = { ":'<,'>ZkNewFromContentSelection {dir='dts', group='literature', title=vim.fn.input('Title: ')}<CR>",
    "literature" },
  ["<leader>ndm"] = { ":'<,'>ZkNewFromContentSelection {dir='dts', group='moc', title=vim.fn.input('Title: ')}<CR>",
    "MOC" },
  ["<leader>ndf"] = { ":'<,'>ZkNewFromContentSelection {dir='dts', group='fleeting', title=vim.fn.input('Title: ')}<CR>",
    "fleeting" },
}

-- wk.register(v_zk_maps, {prefix="<leader>", mode="v"})
wk.register(v_zk_maps, { mode = "v" })
