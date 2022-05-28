local comment = require('Comment')

comment.setup {
  padding = true,
  sticky = true,
  toggler = {
    ---Line-comment toggle keymap
    line = '<leader>gl',
    ---Block-comment toggle keymap
    block = '<leader>gb',
  },
  opleader = {
    ---Line-comment keymap
    line = '<leader>gl',
    ---Block-comment keymap
    block = '<leader>gb',
  },
  extra = {
    ---Add comment on the line above
    above = '<leader>gO',
    ---Add comment on the line below
    below = '<leader>go',
    ---Add comment at the end of line
    eol = '<leader>gA',
  },
  mappings = {
    ---Operator-pending mapping
    ---Includes `<leader>gl`, `<leader>gb`, `gc[count]{motion}` and `gb[count]{motion}`
    ---NOTE: These mappings can be changed individually by `opleader` and `toggler` config
    basic = true,
    ---Extra mapping
    ---Includes `<leader>go`, `<leader>gO`, `<leader>gA`
    extra = true,
    ---Extended mapping
    ---Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
    extended = false,
  },

}
