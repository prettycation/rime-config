---@type { [string]: TextKeyboard }
local tk = {
  default                = safe_require("nekocat.layouts.47keys"),
  calculator             = safe_require("nekocat.layouts.calculator"),
  editor                 = safe_require("nekocat.layouts.editor"),
  number                 = safe_require("nekocat.layouts.number"),
  settings               = safe_require("nekocat.layouts.settings"),
  layouts                = safe_require("nekocat.layouts.layouts"),
  wanxiang_zrm           = safe_require("nekocat.layouts.47keys_hint_zrm"),
  wanxiang_zrm_18keys    = safe_require("nekocat.layouts.37keys_hint_zrm"),
  wanxiang_zrm_14keys    = safe_require("nekocat.layouts.35keys_hint_zrm"),
  wanxiang_l17keys_zrm   = safe_require("nekocat.layouts.36keys_hint"),
  wanxiang_flypy         = safe_require("nekocat.layouts.47keys_hint_flypy"),
  wanxiang_flypy_18keys  = safe_require("nekocat.layouts.37keys_hint_flypy"),
  wanxiang_flypy_14keys  = safe_require("nekocat.layouts.35keys_hint_flypy"),
  wanxiang_l17keys_flypy = safe_require("nekocat.layouts.36keys_hint"),
  wanxiang_t9            = safe_require("nekocat.layouts.17keys"),
  wanxiang_english       = merge(safe_require("nekocat.layouts.47keys"),
    keyboard { name = "万象英文" }),
  luna_pinyin            = merge(safe_require("nekocat.layouts.47keys"),
    keyboard { name = "朙月拼音", label_transform = "UPPERCASE" }),
  luna_pinyin_simp       = merge(safe_require("nekocat.layouts.47keys"),
    keyboard { name = "明月拼音", label_transform = "UPPERCASE" }),
  triple_pinyin_lssp     = safe_require("nekocat.layouts.38keys_hint"),
  wanxiang_yoemin        = safe_require("nekocat.layouts.38keys_hint_dynamic_first"),
  english                = merge(safe_require("nekocat.layouts.47keys"),
    keyboard { name = "英文布局", ascii_mode = true, rows = { [5] = { keys = { [6] = key { click = "KeyboardDefault" } } } } }),
  t9_number              = merge(safe_require("nekocat.layouts.number"),
    keyboard { ascii_mode = true })
}

-- 李氏三拼动态第二码: 15 个键盘由工厂模块数据驱动生成
local lssp_two = safe_require("nekocat.layouts.38keys_hint_dynamic_second")
for k, v in pairs(lssp_two) do
  tk[k] = v
end

-- 李氏三拼动态第三码: 全部 207 个键盘由工厂模块数据驱动生成
local third = safe_require("nekocat.layouts.38keys_hint_dynamic_third")
for k, v in pairs(third) do
  tk[k] = v
end

return tk
