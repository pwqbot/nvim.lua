require('nvim-autopairs').setup {
    check_ts = true,
    enable_check_bracket_line = true,
    fast_wrap = {},
}
local npairs   = require 'nvim-autopairs'
local Rule     = require 'nvim-autopairs.rule'
local cond = require'nvim-autopairs.conds'

local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' } }
npairs.add_rules {
  Rule(' ', ' ')
    :with_pair(function(opts)
      local pair = opts.line:sub(opts.col -1, opts.col)
      return vim.tbl_contains({
        brackets[1][1]..brackets[1][2],
        brackets[2][1]..brackets[2][2],
        brackets[3][1]..brackets[3][2]
      }, pair)
    end)
    :with_move(cond.none())
    :with_cr(cond.none())
    :with_del(function(opts)
      local col = vim.api.nvim_win_get_cursor(0)[2]
      local context = opts.line:sub(col - 1, col + 2)
      return vim.tbl_contains({
        brackets[1][1]..'  '..brackets[1][2],
        brackets[2][1]..'  '..brackets[2][2],
        brackets[3][1]..'  '..brackets[3][2]
      }, context)
    end)
}
for _,bracket in pairs(brackets) do
  Rule('', ' '..bracket[2])
    :with_pair(cond.none())
    :with_move(function(opts) return opts.char == bracket[2] end)
    :with_cr(cond.none())
    :with_del(cond.none())
    :use_key(bracket[2])
end

npairs.add_rules {
    Rule('=', '')
    :with_pair(cond.not_inside_quote())
    :with_pair(function(opts)
        local last_char = opts.line:sub(opts.col - 1, opts.col - 1)
        if last_char:match('[%w%=%s]') then
            return true
        end
        return false
    end)
    :replace_endpair(function(opts)
        local prev_2char = opts.line:sub(opts.col - 2, opts.col - 1)
        local next_char = opts.line:sub(opts.col, opts.col)
        next_char = next_char == ' ' and '' or ' '
        if prev_2char:match('%w$') then
            return '<bs> =' .. next_char
        end
        if prev_2char:match('%=$') then
            return next_char
        end
        if prev_2char:match('=') then
            return '<bs><bs>=' .. next_char
        end
        return ''
    end)
    :set_end_pair_length(0)
    :with_move(cond.none())
    :with_del(cond.none())
}
