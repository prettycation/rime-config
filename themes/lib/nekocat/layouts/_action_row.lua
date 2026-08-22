-- SPDX-License-Identifier: GPL-3.0-or-later
-- 共享底部操作行，5 个基础键盘布局共用

---@type KeyColorStyles
local S = safe_require("nekocat.colors._key_colors")
local func_key_text_size = safe_require("nekocat.font_offset").func_key_text_size
local extra_style = key {
  key_text_size = 20,
  key_back_color = "0x00",
  hilited_key_back_color = "0x00",
  key_border_color = "0x00"
}

---@param opts { mode_switch: boolean?, has_menu: boolean? }
---@return { action: KeyboardRow, extra: KeyboardRow }
return function(opts)
  local has_menu = opts.has_menu and "Tab" or nil

  local action = row {
    keys = {
      key(merge(S.num, key {
        click = "KeyboardNumber",
        label_symbol = { { text = "ic@calculator-variant" } },
        popup = { "Calculator", "ThemeReload", "Deploy" },
        has_menu = has_menu,
        width = 0.15,
        key_text_size = func_key_text_size
      })),
      key(merge(S.comma, key {
        click = "/",
        label_symbol = { { text = "[" } },
        swipe_up = "[",
        hint = { { text = "ic@list-box-outline" } },
        swipe_down = "SchemeList",
        key_text_size = func_key_text_size,
        key_text_offset_y = -2
      })),
      key(merge(S.period, key {
        label = { { text = "，" } },
        click = ",",
        label_symbol = { { text = "]" } },
        swipe_up = "]",
        hint = { { text = "ic@palette-swatch-outline" } },
        swipe_down = "ThemeList",
        key_text_size = func_key_text_size,
        key_text_offset_y = -2
      })),
      key(merge(S.space, key {
        label = { { text = "schema_name" } },
        click = "Space",
        long_click = "VoiceAssist",
        hint = { { text = "◕ ‿ ◕" } },
        swipe_down = "LiquidEmoji",
        key_text_size = 15,
        key_text_offset_y = 1,
        width = 0.3
      })),
      key(merge(S.slash, key {
        label = { { text = "。" } },
        click = ".",
        label_symbol = { { text = "'", bold = true, scale = 1.5 } },
        swipe_up = "'",
        hint = { { text = "ic@lightbulb-outline" } },
        swipe_down = "HintSwitch",
        key_text_size = func_key_text_size,
        key_text_offset_y = -1
      })),
      key(merge(S.switch, key {
        click = opts.mode_switch and "ModeSwitch" or "Keyboard45Eng",
        label_symbol = { { text = "ic@keyboard-settings-outline" } },
        long_click = "KeyboardList",
        hint = { { text = "ic@web" } },
        swipe_down = "IMESwitch",
        key_text_size = func_key_text_size
      })),
      key(merge(S.enter, key {
        label = { { text = "enter_labels" } },
        click = "Enter",
        long_click = "ColorList",
        width = 0.15,
        key_text_size = func_key_text_size
      }))
    }
  }

  local extra = row {
    height = 0.085,
    keys = {
      key(merge(extra_style, { click = "IMESwitch", width = 0.17 })),
      key(merge(extra_style, { label = { { text = "ic@arrow-left-bold-outline" } }, click = "Up", width = 0.1 })),
      key(merge(extra_style, { click = "SlideCursor" })),
      key(merge(extra_style, { label = { { text = "ic@arrow-right-bold-outline" } }, click = "Down", width = 0.1 })),
      key(merge(extra_style, { label = { { text = "ic@clipboard-text-outline" } }, click = "WindowClipboard", width = 0.17 }))
    }
  }

  return { action = action, extra = extra }
end
