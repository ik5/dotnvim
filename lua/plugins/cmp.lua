local cmp = require 'cmp'
local lspkind = require 'lspkind'
local ultisnips = require "cmp_nvim_ultisnips"

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col(".") - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
end

ultisnips.setup {}
local cmp_ultisnips_mappings = ultisnips.mappings

cmp.setup {
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  sources = {
    { name = 'nvim_lsp', group_index = 1, },
    { name = 'omni', group_index = 1, },
    { name = 'treesitter', group_index = 1, },
    { name = 'nvim-lua', group_index = 1, },
    { name = 'buffer', group_index = 1, },
    { name = 'path', group_index = 2, },
    { name = 'cmdline', group_index = 2, },
    { name = 'spell', group_index = 2, },
    { name = 'ultisnips', group_index = 1, },
    {
      name = 'look', group_index = 2,
      keyword_length = 2,
      option = {
        convert_case = true,
        loud = true -- Convert the candidates to UPPERCASE if all input characters are uppercase.
      },
    },
    {
      name = 'tmux',
      group_index = 2,
      option = {
        all_panes = true,
        trigger_characters = { '.' },
        trigger_characters_ft = {} -- { filetype = { '.' } }
      },
    },
  },

  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      before = function (entry, vim_item)
        vim_item.menu = ({
          buffer = "[BUF]",
          nvim_lsp = "[LSP]",
          nvim_lua = "[LUA]",
          path = "[PATH]",
          omni = "[OMNI]",
          cmdline = "[CMDLINE]",
          spell = "[SPELL]",
          tmux = '[TMUX]',
          treesitter = '[TS]',
          ultisnips = '[SNIPS]',
          look = '[LOOK]',
        })[entry.source.name]
        return vim_item
      end
    })
  },

  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },

  completion = {
    keyword_length = 2,
    completeopt = 'menu,menuone,noinsert',
  },

  mapping = cmp.mapping.preset.insert({
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true
    }),
  }),

}
