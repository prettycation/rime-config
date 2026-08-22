local offset = safe_require("nekocat.font_offset").lsspdynamic

local keyboard = keyboard(merge(safe_require("nekocat.layouts.38keys_hint"), keyboard {
  name = "鸢鸣万象·动态键盘",
  dynamic_mode = true,
  dynamic_original = "wanxiang_yoemin",
  rows = {
    [2] = {
      keys = {
        [2] = key(merge(offset, key { dynamic = "lssp_two_b" })),
        [3] = key(merge(offset, key { dynamic = "lssp_two_p" })),
        [4] = key(merge(offset, key { dynamic = "lssp_two_m" })),
        [5] = key(merge(offset, key { dynamic = "lssp_two_rf" })),
        [6] = key(merge(offset, key { dynamic = "lssp_two_zhz" }))
      }
    },
    [3] = {
      keys = {
        [2] = key(merge(offset, key { dynamic = "lssp_two_d" })),
        [3] = key(merge(offset, key { dynamic = "lssp_two_t" })),
        [4] = key(merge(offset, key { dynamic = "lssp_two_n" })),
        [5] = key(merge(offset, key { dynamic = "lssp_two_l" })),
        [6] = key(merge(offset, key { dynamic = "lssp_two_chc" }))
      }
    },
    [4] = {
      keys = {
        [2] = key(merge(offset, key { dynamic = "lssp_two_gj" })),
        [3] = key(merge(offset, key { dynamic = "lssp_two_kq" })),
        [4] = key(merge(offset, key { dynamic = "lssp_two_hx" })),
        [5] = key(merge(offset, key { dynamic = "lssp_two_wy" })),
        [6] = key(merge(offset, key { dynamic = "lssp_two_shs" }))
      }
    }
  }
}))

return keyboard
