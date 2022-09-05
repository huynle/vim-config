if not pcall(require, "nvim-treesitter") then
  return
end

-- local present, ts_config = pcall(require, "nvim-treesitter.configs")
-- if not present then
--     return
-- end

-- vim.api.nvim_command('set foldmethod=expr')
-- vim.api.nvim_command('set foldexpr=nvim_treesitter#foldexpr()')
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'

-- -- neorg stuff
-- local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()
-- parser_configs.norg = {
--   install_info = {
--     url = "https://github.com/nvim-neorg/tree-sitter-norg",
--     files = { "src/parser.c", "src/scanner.cc" },
--     branch = "main"
--   },
-- }

-- parser for go templating -- need this in order for ensure_installed to work
local parser_config = require'nvim-treesitter.parsers'.get_parser_configs()
parser_config.gotmpl = {
  install_info = {
    url = "https://github.com/ngalaiko/tree-sitter-go-template",
    files = {"src/parser.c"}
  },
  filetype = "gotmpl",
  -- used_by = {"gohtmltmpl", "gotexttmpl", "gotmpl", "yaml"}
  -- used_by = {"gohtmltmpl", "gotexttmpl", "gotmpl"}
  used_by = {"gohtmltmpl", "gotexttmpl", "gotmpl", "helm"}
}



require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    'c',
    'cmake',
    'comment',
    'python',
    'html',
    'cpp',
    'lua',
    'yaml',
    'toml',
    'dockerfile',
    'bash',
    'json',
    'gotmpl',
    'regex',
    'go',
    'javascript',
    'typescript',
    'vim'
  },

  -- extra extensions
  highlight = {
    enable = true,
    use_languagetree = true,
    additional_vim_regex_highlighting = { "markdown" },
  },
  indent = { enable = false },
  autopairs = { enable = true },


  -- NOTE: conflicting with localleader key in visual mode
  -- textsubjects = {
  --   enable = true,
  --   keymaps = {
  --     ["."] = "textsubjects-smart",
  --     [";"] = "textsubjects-container-outer",
  --   },
  -- },

  context_commentstring = {
    enable = true,
    enable_autocmd = false,
    config = {
      c = "// %s",
      cpp = "// %s",
      -- typescript = { __default = '// %s', __multiline = '/* %s */' },
      lua = "-- %s",
      helm = "{{- /* <!-- %s  --> */ -}}",
      gotmpl = "{{/* <!-- %s  --> */}}",
      yaml = "# %s",
      typescript = "// %s",
      html = {
         __default  = '<!-- %s -->',
        text = "{{- /* <!-- %s  --> */ -}}"
      },
    }
  },

  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["as"] = "@statement.outer",
        ["il"] = "@loop.inner",
        ["al"] = "@loop.outer",
        ["ib"] = "@block.inner",
        ["ab"] = "@block.outer",
        -- [""] = "@call.inner",
        -- [""] = "@call.outer",
        ["icl"] = "@class.inner",
        ["acl"] = "@class.outer",
        ["acm"] = "@comment.outer",
        ["icd"] = "@conditional.inner",
        ["acd"] = "@conditional.outer",
        -- [""] = "@frame.inner",
        -- [""] = "@frame.outer",
        ["ir"] = "@parameter.inner",
        ["ar"] = "@parameter.outer",
        -- [""] = "@scopename.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]]"] = "@function.outer",
        -- ["]c"] = "@class.outer",
      },
      goto_next_end = {
        ["]["] = "@function.outer",
        -- ["]C"] = "@class.outer",
      },
      goto_previous_start = {
        ["[["] = "@function.outer",
        -- ["[c"] = "@class.outer",
      },
      goto_previous_end = {
        ["[]"] = "@function.outer",
        -- ["[C"] = "@class.outer",
      },
    },
  },
}



vim.cmd [[nnoremap <space>th :TSHighlightCapturesUnderCursor<CR>]]
