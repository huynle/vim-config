if not pcall(require, "cmp") then
  return
end

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local cmp = require'cmp'
local luasnip = require("luasnip")
local util = require("hle.util")


local lsp_symbols = {
    Text = "   (Text) ",
    Method = "   (Method)",
    Function = "   (Function)",
    Constructor = "   (Constructor)",
    Field = " ﴲ  (Field)",
    Variable = "[] (Variable)",
    Class = "   (Class)",
    Interface = " ﰮ  (Interface)",
    Module = "   (Module)",
    Property = " 襁 (Property)",
    Unit = "   (Unit)",
    Value = "   (Value)",
    Enum = " 練 (Enum)",
    Keyword = "   (Keyword)",
    Snippet = "   (Snippet)",
    Color = "   (Color)",
    File = "   (File)",
    Reference = "   (Reference)",
    Folder = "   (Folder)",
    EnumMember = "   (EnumMember)",
    Constant = " ﲀ  (Constant)",
    Struct = " ﳤ  (Struct)",
    Event = "   (Event)",
    Operator = "   (Operator)",
    TypeParameter = "   (TypeParameter)"
}

local cmp_settings = {
  completion = {

    -- autocomplete = {require('cmp.types').cmp.TriggerEvent.CursorHold},
    autocomplete = {require('cmp.types').cmp.TriggerEvent.TextChanged},
    -- autocomplete = false,
    completeopt = "menu,menuone,noselect",
  },

  snippet = {
    expand = function(args)
      -- For `luasnip` user.
      require("luasnip").lsp_expand(args.body)
    end,
  },

  mapping = {
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),

    -- dont do any auto selecting
    ["<CR>"] = cmp.mapping.confirm(),

  },

  sources = {
    { name = 'nvim_lsp' },
    { name = 'tags', keyword_length = 3 },
    { name = 'nvim_lua' },
    { name = 'luasnip', keyword_length = 2},
    { name = 'buffer', keyword_length = 3 },
    { name = 'path' },
    { name = 'treesitter' },
    { name = 'spell', keyword_length = 4 },
  },

  formatting = {
    format = require("hle.lsp.kind").cmp_format(),
  },

  sorting = {
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      require "cmp-under-comparator".under,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
    },
  },

  experimental = {
    native_menu = false,
    ghost_text = {
      hl_group = "LineNr",
    },
  },

  -- filetype = {
  --   markdown = {
  --     -- default shutdown filetype
  --     autocomplete = false
  --   }
  -- }


}


function toggleAutoCmp(mode)
  if mode then
    -- if set to true, then set completion
    -- cmp_settings.completion.autocomplete={require('cmp.types').cmp.TriggerEvent.CursorHold}
    cmp_settings.completion.autocomplete={require('cmp.types').cmp.TriggerEvent.TextChanged}
  elseif cmp_settings.completion.autocomplete == nil or cmp_settings.completion.autocomplete ~= false then
    cmp_settings.completion.autocomplete=false
    print("Cmp Off")
  else
    -- cmp_settings.completion.autocomplete={require('cmp.types').cmp.TriggerEvent.CursorHold}
    cmp_settings.completion.autocomplete={require('cmp.types').cmp.TriggerEvent.TextChanged}
    print("Cmp On")
  end

  cmp.setup(cmp_settings)
end

toggleAutoCmp(true)

vim.cmd('command ToggleCmp lua toggleAutoCmp()')
util.nnoremap( "<leader>tc", "<Cmd>lua toggleAutoCmp()<CR>")

-- manually trigger autocompletion
util.inoremap( "<C-space>", "<Cmd>lua require('cmp').complete()<CR>")
