-- SPDX-License-Identifier: GPL-3.0-or-later
-- 共享数字行 (0-9)，5 个基础键盘布局共用
-- 共享选字/声调行，7 个 hint 布局共用

---@type KeyColorStyles
local S = safe_require("nekocat.colors._key_colors")
local offset = safe_require("nekocat.font_offset").num_key_symbol_offset_y

return {
  number_row = function()
    return row {
      height = 0.11,
      keys = {
        key(merge(S.num1, key { click = "1", label_symbol = { { text = { "1", "!" }, align = { "left", "right" } } }, swipe_up = "!", key_symbol_offset_y = offset })),
        key(merge(S.num2, key { click = "2", label_symbol = { { text = { "2", "@" }, align = { "left", "right" } } }, swipe_up = "@", key_symbol_offset_y = offset })),
        key(merge(S.num3, key { click = "3", label_symbol = { { text = { "3", "#" }, align = { "left", "right" } } }, swipe_up = "#", key_symbol_offset_y = offset })),
        key(merge(S.num4, key { click = "4", label_symbol = { { text = { "4", "$" }, align = { "left", "right" } } }, swipe_up = "$", key_symbol_offset_y = offset })),
        key(merge(S.num5, key { click = "5", label_symbol = { { text = { "5", "%" }, align = { "left", "right" } } }, swipe_up = "%", key_symbol_offset_y = offset })),
        key(merge(S.num6, key { click = "6", label_symbol = { { text = { "6", "^" }, align = { "left", "right" } } }, swipe_up = "^", key_symbol_offset_y = offset })),
        key(merge(S.num7, key { click = "7", label_symbol = { { text = { "7", "&" }, align = { "left", "right" } } }, swipe_up = "&", key_symbol_offset_y = offset })),
        key(merge(S.num8, key { click = "8", label_symbol = { { text = { "8", "*" }, align = { "left", "right" } } }, swipe_up = "*", key_symbol_offset_y = offset })),
        key(merge(S.num9, key { click = "9", label_symbol = { { text = { "9", "(" }, align = { "left", "right" } } }, swipe_up = "(", key_symbol_offset_y = offset })),
        key(merge(S.num0, key { click = "0", label_symbol = { { text = { "0", ")" }, align = { "left", "right" } } }, swipe_up = ")", key_symbol_offset_y = offset }))
      }
    }
  end,

  composing_row = row {
    keys = {
      [1] = key { composing = "SelectCandOne" },
      [2] = key { composing = "SelectCandTwo" },
      [3] = key { composing = "SelectCandThree" },
      [4] = key { composing = "SelectCandFour" },
      [5] = key { composing = "SelectCandFive" },
      [6] = key { composing = "SelectToneOne" },
      [7] = key { composing = "SelectToneTwo" },
      [8] = key { composing = "SelectToneThree" },
      [9] = key { composing = "SelectToneFour" },
      [10] = key { composing = "SelectToneNull" }
    }
  }
}
