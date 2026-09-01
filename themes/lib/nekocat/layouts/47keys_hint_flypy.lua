local hint_offset = safe_require("nekocat.font_offset").auxhint

local keyboard = keyboard(merge(safe_require("nekocat.layouts.47keys"), keyboard {
  name = "万象小鹤",
  label_transform = "UPPERCASE",
  rows = {
    [1] = safe_require("nekocat.layouts._number_row").composing_row,
    [2] = row {
      keys = {
        [1] = key(merge(hint_offset, key { label = { { align = "left", valign = "top" } }, hint = {
          { text = { "\u{F801}", "\u{F802}", "犭\n" }, color = { "rosewater", "rosewater", "overlay2" }, align = "justify" },
          { text = { "求", "气", "犬\n" }, color = "overlay2", align = "justify" },
          { text = "iu", color = "blue" }
        } })),
        [2] = key(merge(hint_offset, key { label = { { align = "left", valign = "top" } }, hint = {
          { text = { "亠", "文", "夂\n" }, color = "overlay2", align = "justify" },
          { text = { "攵", "瓦", "戊\n" }, color = "overlay2", align = "justify" },
          { text = "ei", color = "blue" }
        } })),
        [3] = key(merge(hint_offset, key { label = { { align = "left", valign = "top" } }, hint = {
          { text = { "彐", "山", "\u{F803}\n" }, color = { "rosewater", "rosewater", "overlay2" }, align = "justify" },
          { text = { "阝", "卩", "耳\n" }, color = "overlay2", align = "justify" },
          { text = { "cy", "e" }, color = { "red", "blue" }, bold = { true, false }, align = "justify" }
        } })),
        [4] = key(merge(hint_offset, key { label = { { align = "left", valign = "top" } }, hint = {
          { text = { "亻", "人", "冉\n" }, color = "overlay2", align = "justify" },
          { text = { "入", "壬", "刃\n" }, color = "overlay2", align = "justify" },
          { text = "[uü]an", color = "blue" }
        } })),
        [5] = key(merge(hint_offset, key { label = { { align = "left", valign = "top" } }, hint = {
          { text = { "田", "土\n" }, color = "overlay2", align = "justify" },
          { text = { "天", "太", "屯\n" }, color = "overlay2", align = "justify" },
          { text = "[uü]e", color = "blue" }
        } })),
        [6] = key(merge(hint_offset, key { label = { { align = "left", valign = "top" } }, hint = {
          { text = { "𧘇", "讠", "⺷\n" }, color = "overlay2", align = "justify" },
          { text = { "⺶", "羊", "玉\n" }, color = "overlay2", align = "justify" },
          { text = "[uü]n", color = "blue" }
        } })),
        [7] = key(merge(hint_offset, key { label = { { align = "left", valign = "top" } }, hint = {
          { text = { "饣", "龵", "𠂇\n" }, color = "overlay2", align = "justify" },
          { text = { "氺", "石", "勺\n" }, color = "overlay2", align = "justify" },
          { text = { "ŝ", "u" }, color = { "red", "blue" }, bold = { true, false }, align = "justify" }
        } })),
        [8] = key(merge(hint_offset, key { label = { { align = "left", valign = "top" } }, hint = {
          { text = { "彳", "亍", "虫\n" }, color = "overlay2", align = "justify" },
          { text = { "川", "叉", "垂\n" }, color = "overlay2", align = "justify" },
          { text = { "ĉ", "i" }, color = { "red", "blue" }, bold = { true, false }, align = "justify" }
        } })),
        [9] = key(merge(hint_offset, key { label = { { align = "left", valign = "top" } }, hint = {
          { text = "日\n", color = "teal" },
          { text = { "月", "目\n" }, color = "overlay2", align = "justify" },
          { text = { "zy", "u?o" }, color = { "red", "blue" }, bold = { true, false, false }, align = "justify" }
        } })),
        [10] = key(merge(hint_offset, key { label = { { align = "left", valign = "top" } }, hint = {
          { text = { "丿", "礻", "衤\n" }, color = { "lavender", "rosewater", "rosewater" }, align = "justify" },
          { text = { "片", "平", "爿\n" }, color = "overlay2", align = "justify" },
          { text = "ie", color = "blue" }
        } }))
      }
    },
    [3] = row {
      keys = {
        [2] = key(merge(hint_offset, key { label = { { align = "left", valign = "top" } }, hint = {
          { text = "一\n", color = "lavender" },
          { text = { "鱼", "凹\n" }, color = { "rosewater", "overlay2" }, align = "justify" },
          { text = { "sy", "a", "er" }, color = { "red", "blue", "blue" }, bold = { true, false, false }, align = "justify" }
        } })),
        [3] = key(merge(hint_offset, key { label = { { align = "left", valign = "top" } }, hint = {
          { text = { "纟", "厶", "龴\n" }, color = "overlay2", align = "justify" },
          { text = { "罒", "巳", "肃\n" }, color = "overlay2", align = "justify" },
          { text = " i?ong", color = "blue" }
        } })),
        [4] = key(merge(hint_offset, key { label = { { align = "left", valign = "top" } }, hint = {
          { text = { "丶", "冫", "氵\n" }, color = { "lavender", "overlay2", "overlay2" }, align = "justify" },
          { text = { "⺈", "刂", "刁\n" }, color = "overlay2", align = "justify" },
          { text = "i?ai", color = "blue" }
        } })),
        [5] = key(merge(hint_offset, key { label = { { align = "left", valign = "top" } }, hint = {
          { text = { "\u{F804}", "\u{F805}", "龶\n" }, color = "overlay2", align = "justify" },
          { text = { "扌", "缶", "非\n" }, color = "overlay2", align = "justify" },
          { text = "en", color = "blue" }
        } })),
        [6] = key(merge(hint_offset, key { label = { { align = "left", valign = "top" } }, hint = {
          { text = { "\u{F806}", "艮", "鬼\n" }, color = "overlay2", align = "justify" },
          { text = { "革", "骨", "夬\n" }, color = "overlay2", align = "justify" },
          { text = "eng", color = "blue" }
        } })),
        [7] = key(merge(hint_offset, key { label = { { align = "left", valign = "top" } }, hint = {
          { text = { "灬", "虍", "\u{F807}\n" }, color = "overlay2", align = "justify" },
          { text = { "黑", "火", "乎\n" }, color = "overlay2", align = "justify" },
          { text = "ang", color = "blue" }
        } })),
        [8] = key(merge(hint_offset, key { label = { { align = "left", valign = "top" } }, hint = {
          { text = { "龹", "钅", "金\n" }, color = "overlay2", align = "justify" },
          { text = { "臼", "夹", "柬\n" }, color = "overlay2", align = "justify" },
          { text = "an", color = "blue" }
        } })),
        [9] = key(merge(hint_offset, key { label = { { align = "left", valign = "top" } }, hint = {
          { text = { "匚", "冂", "凵\n" }, color = "teal", align = "justify" },
          { text = { "囗", "㠯", "亏\n" }, color = { "teal", "overlay2", "overlay2" }, align = "justify" },
          { text = "uai ing", color = "blue" }
        } })),
        [10] = key(merge(hint_offset, key { label = { { align = "left", valign = "top" } }, hint = {
          { text = { "丨", "耂", "立\n" }, color = { "lavender", "overlay2", "overlay2" }, align = "justify" },
          { text = { "龙", "来", "丽\n" }, color = "overlay2", align = "justify" },
          { text = "[iu]ang", color = "blue" }
        } }))
      }
    },
    [4] = row {
      keys = {
        [2] = key(merge(hint_offset, key { label = { { align = "left", valign = "top" } }, hint = {
          { text = { "廴", "辶", "⻊\n" }, color = { "teal", "teal", "overlay2" }, align = "justify" },
          { text = { "再", "自", "子\n" }, color = "overlay2", align = "justify" },
          { text = "ou", color = "blue", align = "justify" }
        } })),
        [3] = key(merge(hint_offset, key { label = { { align = "left", valign = "top" } }, hint = {
          { text = { "乂", "忄", "⺍\n" }, color = { "rosewater", "overlay2", "overlay2" }, align = "justify" },
          { text = { "⺌", "⺗", "小\n" }, color = "overlay2", align = "justify" },
          { text = "[iu]a", color = "blue" }
        } })),
        [4] = key(merge(hint_offset, key { label = { { align = "left", valign = "top" } }, hint = {
          { text = { "艹", "廾", "寸\n" }, color = "overlay2", align = "justify" },
          { text = { "才", "匆", "册\n" }, color = "overlay2", align = "justify" },
          { text = "ao", color = "blue", align = "justify" }
        } })),
        [5] = key(merge(hint_offset, key { label = { { align = "left", valign = "top" } }, hint = {
          { text = { "𪛙", "⺮", "豸\n" }, color = { "lavender", "overlay2", "overlay2" }, align = "justify" },
          { text = { "主", "舟", "之\n" }, color = "overlay2", align = "justify" },
          { text = { "ẑ", "ui", "ü" }, color = { "red", "blue", "blue" }, bold = { true, false, false }, align = "justify" }
        } })),
        [6] = key(merge(hint_offset, key { label = { { align = "left", valign = "top" } }, hint = {
          { text = { "勹", "冖", "宀\n" }, color = { "rosewater", "overlay2", "overlay2" }, align = "justify" },
          { text = { "丷", "\u{F808}", "疒\n" }, color = "overlay2", align = "justify" },
          { text = "in", color = "blue" }
        } })),
        [7] = key(merge(hint_offset, key { label = { { align = "left", valign = "top" } }, hint = {
          { text = { "乀", "⺧", "牜\n" }, color = { "lavender", "overlay2", "overlay2" }, align = "justify" },
          { text = { "廿", "鸟", "年\n" }, color = "overlay2", align = "justify" },
          { text = "iao", color = "blue" }
        } })),
        [8] = key(merge(hint_offset, key { label = { { align = "left", valign = "top" } }, hint = {
          { text = { "朩", "木", "米\n" }, color = "overlay2", align = "justify" },
          { text = { "门", "马", "皿\n" }, color = "overlay2", align = "justify" },
          { text = "ian", color = "blue" }
        } }))
      }
    }
  }
}))

return keyboard
