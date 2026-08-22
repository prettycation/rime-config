---@type KeyColorStyles
local S = safe_require("nekocat.colors._key_colors")

local settings = key {
  key_text_size = 42,
  hint_text_size = 11,
  key_border_color = "0x00",
  key_back_color = "0x00"
}

local keyboard = keyboard {
  name = "布局与方案",
  author = "Carlson24(鹤衔春雪)",
  ascii_mode = false,
  label_transform = "NONE",
  lock = false,
  navbar = true,
  rows = {
    row {
      height = 0.3,
      keys = {
        key { spacer = true, width = 0.1 },
        key(merge(settings, key { click = "Schemazrm", hint = { { text = "自然码" } } })),
        key(merge(settings, key { click = "Schemazrm18keys", hint = { { text = "自然码 18 键" } } })),
        key(merge(settings, key { click = "Schemazrm14keys", hint = { { text = "自然码 14 键" } } })),
        key(merge(settings, key { click = "Schemal17keyszrm", hint = { { text = "乱序 17 自然辅" } } })),

        key { spacer = true, width = 0.1 }
      }
    },
    row {
      height = 0.3,
      keys = {
        key { spacer = true, width = 0.1 },
        key(merge(settings, key { click = "Schemaflypy", hint = { { text = "小鹤" } } })),
        key(merge(settings, key { click = "Schemaflypy18keys", hint = { { text = "小鹤 18 键" } } })),
        key(merge(settings, key { click = "Schemaflypy14keys", hint = { { text = "小鹤 14 键" } } })),
        key(merge(settings, key { click = "Schemal17keysflypy", hint = { { text = "乱序 17 小鹤辅" } } })),
        key { spacer = true, width = 0.1 }
      }
    },
    row {
      height = 0.3,
      keys = {
        key { spacer = true, width = 0.1 },
        key(merge(settings, key { click = "Schemayoemin", hint = { { text = "鸢鸣万象" } } })),
        key(merge(settings, key { click = "Schemalssp", hint = { { text = "李氏三拼" } } })),
        key(merge(settings, key { click = "SchemaEnglish", hint = { { text = "English" } } })),
        key(merge(settings, key { click = "Schema9keys", hint = { { text = "T9" } } })),
        key { spacer = true, width = 0.1 }
      }
    }
  }
}

return keyboard
