-- SPDX-License-Identifier: GPL-3.0-or-later
-- LSSP 动态第三码键盘工厂
-- 数据驱动生成全部 207 个第三码键盘，替代 200+ 个独立文件

local function make_key_text(val)
  if val then
    return key { label = { { text = val } } }
  else
    return key { label = { { color = "overlay1" } } }
  end
end

local function make_row(cells)
  local keys = {}
  for i, v in ipairs(cells) do
    keys[i + 1] = make_key_text(v)
  end
  return { keys = keys }
end

local template = keyboard(merge(safe_require("nekocat.layouts.38keys_hint_dynamic_first"), keyboard {
  name = "鸢鸣万象·动态第三码模板",
  rows = {
    [2] = { keys = {
      [2] = key { label = { { text = "∅" } }, key_text_size = 18, dynamic = ".original" },
      [3] = key { label = { { text = "∅" } }, key_text_size = 18, dynamic = ".original" },
      [4] = key { label = { { text = "∅" } }, key_text_size = 18, dynamic = ".original" },
      [5] = key { label = { { text = "∅" } }, key_text_size = 18, dynamic = ".original" },
      [6] = key { label = { { text = "∅" } }, key_text_size = 18, dynamic = ".original" }
    } }, [3] = { keys = {
    [2] = key { label = { { text = "∅" } }, key_text_size = 18, dynamic = ".original" },
    [3] = key { label = { { text = "∅" } }, key_text_size = 18, dynamic = ".original" },
    [4] = key { label = { { text = "∅" } }, key_text_size = 18, dynamic = ".original" },
    [5] = key { label = { { text = "∅" } }, key_text_size = 18, dynamic = ".original" },
    [6] = key { label = { { text = "∅" } }, key_text_size = 18, dynamic = ".original" }
  } }, [4] = { keys = {
    [2] = key { label = { { text = "∅" } }, key_text_size = 18, dynamic = ".original" },
    [3] = key { label = { { text = "∅" } }, key_text_size = 18, dynamic = ".original" },
    [4] = key { label = { { text = "∅" } }, key_text_size = 18, dynamic = ".original" },
    [5] = key { label = { { text = "∅" } }, key_text_size = 18, dynamic = ".original" },
    [6] = key { label = { { text = "∅" } }, key_text_size = 18, dynamic = ".original" }
  } }
  }
}))

local function make_third_code(name_suffix, rows_data)
  local rows = {}
  for idx, cells in ipairs(rows_data) do
    rows[idx + 1] = make_row(cells)
  end
  return keyboard(merge(template, keyboard {
    name = "鸢鸣万象·动态第三码" .. name_suffix,
    rows = rows
  }))
end

-- ========== 声调数据表 ==========

local TONE_DATA = {
  ["lssp_three_aanang"] = {
    { "ā",   "á",   "ǎ",   "à",   "a" },
    { "ān",  false, "ǎn",  "àn",  "an" },
    { "āng", "áng", false, "àng", "ang" }
  },
  ["lssp_three_aieiao"] = {
    { "āi", "ái", "ǎi", "ài", "ai" },
    { "ê̄", "ế", "ê̌", "ề", "ê" },
    { "āo", "áo", "ǎo", "ào", "ao" }
  },
  ["lssp_three_baanang"] = {
    { "bā",   "bá",   "bǎ",   "bà",   "ba" },
    { "bān",  "bán",  "bǎn",  "bàn",  "ban" },
    { "bāng", "báng", "bǎng", "bàng", "bang" }
  },
  ["lssp_three_baieiao"] = {
    { "bāi", "bái", "bǎi", "bài", "bai" },
    { "bēi", "béi", "běi", "bèi", "bei" },
    { "bāo", "báo", "bǎo", "bào", "bao" }
  },
  ["lssp_three_beneng"] = {
    { false,  false,  false,  false,  false },
    { "bēn",  "bén",  "běn",  "bèn",  "ben" },
    { "bēng", "béng", "běng", "bèng", "beng" }
  },
  ["lssp_three_bianiang"] = {
    { false,  false,   false,  false,  false },
    { "biān", "bián",  "biǎn", "biàn", "bian" },
    { false,  "biáng", false,  false,  "biang" }
  },
  ["lssp_three_bieining"] = {
    { "biē",  "bié",  "biě",  "biè",  "bie" },
    { "bīn",  "bín",  "bǐn",  "bìn",  "bin" },
    { "bīng", "bíng", "bǐng", "bìng", "bing" }
  },
  ["lssp_three_biiao"] = {
    { false,  false,  false,  false,  false },
    { "bī",   "bí",   "bǐ",   "bì",   "bi" },
    { "biāo", "biáo", "biǎo", "biào", "biao" }
  },
  ["lssp_three_bo"] = {
    { "bō",  "bó",  "bǒ",  "bò",  "bo" },
    { false, false, false, false, false },
    { false, false, false, false, false }
  },
  ["lssp_three_bu"] = {
    { false, false, false, false, false },
    { false, false, false, false, false },
    { "bū",  "bú",  "bǔ",  "bù",  "bu" }
  },
  ["lssp_three_caanang"] = {
    { "cā",   "cá",   "cǎ",   "cà",   "ca" },
    { "cān",  "cán",  "cǎn",  "càn",  "can" },
    { "cāng", "cáng", "cǎng", "càng", "cang" }
  },
  ["lssp_three_caiao"] = {
    { "cāi", "cái", "cǎi", "cài", "cai" },
    { false, false, false, false, false },
    { "cāo", "cáo", "cǎo", "cào", "cao" }
  },
  ["lssp_three_ceeneng"] = {
    { "cē",   "cé",   "cě",   "cè",   "ce" },
    { "cēn",  "cén",  "cěn",  "cèn",  "cen" },
    { "cēng", "céng", "cěng", "cèng", "ceng" }
  },
  ["lssp_three_chaanang"] = {
    { "chā",   "chá",   "chǎ",   "chà",   "cha" },
    { "chān",  "chán",  "chǎn",  "chàn",  "chan" },
    { "chāng", "cháng", "chǎng", "chàng", "chang" }
  },
  ["lssp_three_chaiao"] = {
    { "chāi", "chái", "chǎi", "chài", "chai" },
    { false,  false,  false,  false,  false },
    { "chāo", "cháo", "chǎo", "chào", "chao" }
  },
  ["lssp_three_cheeneng"] = {
    { "chē",   "ché",   "chě",   "chè",   "che" },
    { "chēn",  "chén",  "chěn",  "chèn",  "chen" },
    { "chēng", "chéng", "chěng", "chèng", "cheng" }
  },
  ["lssp_three_chiouong"] = {
    { "chī",   "chí",   "chǐ",   "chì",   "chi" },
    { "chōu",  "chóu",  "chǒu",  "chòu",  "chou" },
    { "chōng", "chóng", "chǒng", "chòng", "chong" }
  },
  ["lssp_three_chuaiui"] = {
    { "chuāi", "chuái", "chuǎi", "chuài", "chuai" },
    { "chuī",  "chuí",  "chuǐ",  "chuì",  "chui" },
    { false,   false,   false,   false,   false }
  },
  ["lssp_three_chuauanuang"] = {
    { "chuā",   "chuá",   "chuǎ",   "chuà",   "chua" },
    { "chuān",  "chuán",  "chuǎn",  "chuàn",  "chuan" },
    { "chuāng", "chuáng", "chuǎng", "chuàng", "chuang" }
  },
  ["lssp_three_chun"] = {
    { false,  false,  false,  false,  false },
    { "chūn", "chún", "chǔn", "chùn", "chun" },
    { false,  false,  false,  false,  false }
  },
  ["lssp_three_chuou"] = {
    { "chuō", "chuó", "chuǒ", "chuò", "chuo" },
    { false,  false,  false,  false,  false },
    { "chū",  "chú",  "chǔ",  "chù",  "chu" }
  },
  ["lssp_three_ciouong"] = {
    { "cī",   "cí",   "cǐ",   "cì",   "ci" },
    { "cōu",  "cóu",  "cǒu",  "còu",  "cou" },
    { "cōng", "cóng", "cǒng", "còng", "cong" }
  },
  ["lssp_three_cuan"] = {
    { false,  false,  false,  false,  false },
    { "cuān", "cuán", "cuǎn", "cuàn", "cuan" },
    { false,  false,  false,  false,  false }
  },
  ["lssp_three_cun"] = {
    { false, false, false, false, false },
    { "cūn", "cún", "cǔn", "cùn", "cun" },
    { false, false, false, false, false }
  },
  ["lssp_three_cuouiu"] = {
    { "cuō", "cuó", "cuǒ", "cuò", "cuo" },
    { "cuī", "cuí", "cuǐ", "cuì", "cui" },
    { "cū",  "cú",  "cǔ",  "cù",  "cu" }
  },
  ["lssp_three_daanang"] = {
    { "dā",   "dá",   "dǎ",   "dà",   "da" },
    { "dān",  "dán",  "dǎn",  "dàn",  "dan" },
    { "dāng", "dáng", "dǎng", "dàng", "dang" }
  },
  ["lssp_three_daieiao"] = {
    { "dāi", "dái", "dǎi", "dài", "dai" },
    { "dēi", "déi", "děi", "dèi", "dei" },
    { "dāo", "dáo", "dǎo", "dào", "dao" }
  },
  ["lssp_three_deeneng"] = {
    { "dē",   "dé",   "dě",   "dè",   "de" },
    { "dēn",  "dén",  "děn",  "dèn",  "den" },
    { "dēng", "déng", "děng", "dèng", "deng" }
  },
  ["lssp_three_default_aanang"] = {
    { "ā",   "á",   "ǎ",   "à",   "a" },
    { "ān",  "án",  "ǎn",  "àn",  "an" },
    { "āng", "áng", "ǎng", "àng", "ang" }
  },
  ["lssp_three_default_aieiao"] = {
    { "āi", "ái", "ǎi", "ài", "ai" },
    { "ê̄", "ế", "ê̌", "ề", "ê" },
    { "āo", "áo", "ǎo", "ào", "ao" }
  },
  ["lssp_three_default_eeneng"] = {
    { "ē",   "é",   "ě",   "è",   "e" },
    { "ēn",  "én",  "ěn",  "èn",  "en" },
    { "ēng", "éng", "ěng", "èng", "eng" }
  },
  ["lssp_three_default_ervan"] = {
    { "ēr",  "ér",  "ěr",  "èr",  "er" },
    { "üān", "üán", "üǎn", "üàn", "üan" },
    { false, false, false, false, false }
  },
  ["lssp_three_default_iaianiang"] = {
    { "iā",   "iá",   "iǎ",   "ià",   "ia" },
    { "iān",  "ián",  "iǎn",  "iàn",  "ian" },
    { "iāng", "iáng", "iǎng", "iàng", "iang" }
  },
  ["lssp_three_default_iaiiiao"] = {
    { "iāi", "iái", "iǎi", "iài", "iai" },
    { "ī",   "í",   "ǐ",   "ì",   "i" },
    { "iāo", "iáo", "iǎo", "iào", "iao" }
  },
  ["lssp_three_default_ieining"] = {
    { "iē",  "ié",  "iě",  "iè",  "ie" },
    { "īn",  "ín",  "ǐn",  "ìn",  "in" },
    { "īng", "íng", "ǐng", "ìng", "ing" }
  },
  ["lssp_three_default_ioiuiong"] = {
    { "iō",   "ió",   "iǒ",   "iò",   "io" },
    { "iū",   "iú",   "iǔ",   "iù",   "iu" },
    { "iōng", "ióng", "iǒng", "iòng", "iong" }
  },
  ["lssp_three_default_oouong"] = {
    { "ō",   "ó",   "ǒ",   "ò",   "o" },
    { "ōu",  "óu",  "ǒu",  "òu",  "ou" },
    { "ōng", "óng", "ǒng", "òng", "ong" }
  },
  ["lssp_three_default_uaiui"] = {
    { "uāi", "uái", "uǎi", "uài", "uai" },
    { "uī",  "uí",  "uǐ",  "uì",  "ui" },
    { false, false, false, false, false }
  },
  ["lssp_three_default_uauanuang"] = {
    { "uā",   "uá",   "uǎ",   "uà",   "ua" },
    { "uān",  "uán",  "uǎn",  "uàn",  "uan" },
    { "uāng", "uáng", "uǎng", "uàng", "uang" }
  },
  ["lssp_three_default_unueng"] = {
    { false,  false,  false,  false,  false },
    { "ūn",   "ún",   "ǔn",   "ùn",   "un" },
    { "uēng", "uéng", "uěng", "uèng", "ueng" }
  },
  ["lssp_three_default_uou"] = {
    { "uō",  "uó",  "uǒ",  "uò",  "uo" },
    { false, false, false, false, false },
    { "ū",   "ú",   "ǔ",   "ù",   "u" }
  },
  ["lssp_three_default_v"] = {
    { false, false, false, false, false },
    { false, false, false, false, false },
    { "ǖ",   "ǘ",   "ǚ",   "ǜ",   "ü" }
  },
  ["lssp_three_default_vevn"] = {
    { "üē",  "üé",  "üě",  "üè",  "üe" },
    { "ǖn",  "ǘn",  "ǚn",  "ǜn",  "ün" },
    { false, false, false, false, false }
  },
  ["lssp_three_diaian"] = {
    { "diā",  "diá",  "diǎ",  "dià",  "dia" },
    { "diān", "dián", "diǎn", "diàn", "dian" },
    { false,  false,  false,  false,  false }
  },
  ["lssp_three_dieing"] = {
    { "diē",  "dié",  "diě",  "diè",  "die" },
    { false,  false,  false,  false,  false },
    { "dīng", "díng", "dǐng", "dìng", "ding" }
  },
  ["lssp_three_diiao"] = {
    { false,  false,  false,  false,  false },
    { "dī",   "dí",   "dǐ",   "dì",   "di" },
    { "diāo", "diáo", "diǎo", "diào", "diao" }
  },
  ["lssp_three_diu"] = {
    { false, false, false, false, false },
    { "diū", "diú", "diǔ", "diù", "diu" },
    { false, false, false, false, false }
  },
  ["lssp_three_douong"] = {
    { false,  false,  false,  false,  false },
    { "dōu",  "dóu",  "dǒu",  "dòu",  "dou" },
    { "dōng", "dóng", "dǒng", "dòng", "dong" }
  },
  ["lssp_three_duan"] = {
    { false,  false,  false,  false,  false },
    { "duān", "duán", "duǎn", "duàn", "duan" },
    { false,  false,  false,  false,  false }
  },
  ["lssp_three_dui"] = {
    { false, false, false, false, false },
    { "duī", "duí", "duǐ", "duì", "dui" },
    { false, false, false, false, false }
  },
  ["lssp_three_dun"] = {
    { false, false, false, false, false },
    { "dūn", "dún", "dǔn", "dùn", "dun" },
    { false, false, false, false, false }
  },
  ["lssp_three_duou"] = {
    { "duō", "duó", "duǒ", "duò", "duo" },
    { false, false, false, false, false },
    { "dū",  "dú",  "dǔ",  "dù",  "du" }
  },
  ["lssp_three_eeneng"] = {
    { "ē",   "é",   "ě",   "è",   "e" },
    { "ēn",  false, false, "èn",  "en" },
    { "ēng", false, false, false, "eng" }
  },
  ["lssp_three_eryvan"] = {
    { false,  "ér",   "ěr",   "èr",   "er" },
    { "yuān", "yuán", "yuǎn", "yuàn", "yuan" },
    { false,  false,  false,  false,  false }
  },
  ["lssp_three_faanang"] = {
    { "fā",   "fá",   "fǎ",   "fà",   "fa" },
    { "fān",  "fán",  "fǎn",  "fàn",  "fan" },
    { "fāng", "fáng", "fǎng", "fàng", "fang" }
  },
  ["lssp_three_feiiao"] = {
    { false, false, false, false,  false },
    { "fēi", "féi", "fěi", "fèi",  "fei" },
    { false, false, false, "fiào", "fiao" }
  },
  ["lssp_three_feneng"] = {
    { false,  false,  false,  false,  false },
    { "fēn",  "fén",  "fěn",  "fèn",  "fen" },
    { "fēng", "féng", "fěng", "fèng", "feng" }
  },
  ["lssp_three_foou"] = {
    { "fō",  "fó",  "fǒ",  "fò",  "fo" },
    { "fōu", "fóu", "fǒu", "fòu", "fou" },
    { false, false, false, false, false }
  },
  ["lssp_three_fu"] = {
    { false, false, false, false, false },
    { false, false, false, false, false },
    { "fū",  "fú",  "fǔ",  "fù",  "fu" }
  },
  ["lssp_three_gaanang"] = {
    { "gā",   "gá",   "gǎ",   "gà",   "ga" },
    { "gān",  "gán",  "gǎn",  "gàn",  "gan" },
    { "gāng", "gáng", "gǎng", "gàng", "gang" }
  },
  ["lssp_three_gaieiao"] = {
    { "gāi", "gái", "gǎi", "gài", "gai" },
    { "gēi", "géi", "gěi", "gèi", "gei" },
    { "gāo", "gáo", "gǎo", "gào", "gao" }
  },
  ["lssp_three_geeneng"] = {
    { "gē",   "gé",   "gě",   "gè",   "ge" },
    { "gēn",  "gén",  "gěn",  "gèn",  "gen" },
    { "gēng", "géng", "gěng", "gèng", "geng" }
  },
  ["lssp_three_gouong"] = {
    { false,  false,  false,  false,  false },
    { "gōu",  "góu",  "gǒu",  "gòu",  "gou" },
    { "gōng", "góng", "gǒng", "gòng", "gong" }
  },
  ["lssp_three_guaiui"] = {
    { "guāi", "guái", "guǎi", "guài", "guai" },
    { "guī",  "guí",  "guǐ",  "guì",  "gui" },
    { false,  false,  false,  false,  false }
  },
  ["lssp_three_guauanuang"] = {
    { "guā",   "guá",   "guǎ",   "guà",   "gua" },
    { "guān",  "guán",  "guǎn",  "guàn",  "guan" },
    { "guāng", "guáng", "guǎng", "guàng", "guang" }
  },
  ["lssp_three_gun"] = {
    { false, false, false, false, false },
    { "gūn", "gún", "gǔn", "gùn", "gun" },
    { false, false, false, false, false }
  },
  ["lssp_three_guou"] = {
    { "guō", "guó", "guǒ", "guò", "guo" },
    { false, false, false, false, false },
    { "gū",  "gú",  "gǔ",  "gù",  "gu" }
  },
  ["lssp_three_haanang"] = {
    { "hā",   "há",   "hǎ",   "hà",   "ha" },
    { "hān",  "hán",  "hǎn",  "hàn",  "han" },
    { "hāng", "háng", "hǎng", "hàng", "hang" }
  },
  ["lssp_three_haieiao"] = {
    { "hāi", "hái", "hǎi", "hài", "hai" },
    { "hēi", "héi", "hěi", "hèi", "hei" },
    { "hāo", "háo", "hǎo", "hào", "hao" }
  },
  ["lssp_three_heeneng"] = {
    { "hē",   "hé",   "hě",   "hè",   "he" },
    { "hēn",  "hén",  "hěn",  "hèn",  "hen" },
    { "hēng", "héng", "hěng", "hèng", "heng" }
  },
  ["lssp_three_houong"] = {
    { false,  false,  false,  false,  false },
    { "hōu",  "hóu",  "hǒu",  "hòu",  "hou" },
    { "hōng", "hóng", "hǒng", "hòng", "hong" }
  },
  ["lssp_three_huaiui"] = {
    { "huāi", "huái", "huǎi", "huài", "huai" },
    { "huī",  "huí",  "huǐ",  "huì",  "hui" },
    { false,  false,  false,  false,  false }
  },
  ["lssp_three_huauanuang"] = {
    { "huā",   "huá",   "huǎ",   "huà",   "hua" },
    { "huān",  "huán",  "huǎn",  "huàn",  "huan" },
    { "huāng", "huáng", "huǎng", "huàng", "huang" }
  },
  ["lssp_three_hun"] = {
    { false, false, false, false, false },
    { "hūn", "hún", "hǔn", "hùn", "hun" },
    { false, false, false, false, false }
  },
  ["lssp_three_huou"] = {
    { "huō", "huó", "huǒ", "huò", "huo" },
    { false, false, false, false, false },
    { "hū",  "hú",  "hǔ",  "hù",  "hu" }
  },
  ["lssp_three_jiaianiang"] = {
    { "jiā",   "jiá",   "jiǎ",   "jià",   "jia" },
    { "jiān",  "jián",  "jiǎn",  "jiàn",  "jian" },
    { "jiāng", "jiáng", "jiǎng", "jiàng", "jiang" }
  },
  ["lssp_three_jieining"] = {
    { "jiē",  "jié",  "jiě",  "jiè",  "jie" },
    { "jīn",  "jín",  "jǐn",  "jìn",  "jin" },
    { "jīng", "jíng", "jǐng", "jìng", "jing" }
  },
  ["lssp_three_jiiao"] = {
    { false,  false,  false,  false,  false },
    { "jī",   "jí",   "jǐ",   "jì",   "ji" },
    { "jiāo", "jiáo", "jiǎo", "jiào", "jiao" }
  },
  ["lssp_three_jiuiong"] = {
    { false,   false,   false,   false,   false },
    { "jiū",   "jiú",   "jiǔ",   "jiù",   "jiu" },
    { "jiōng", "jióng", "jiǒng", "jiòng", "jiong" }
  },
  ["lssp_three_jv"] = {
    { false, false, false, false, false },
    { false, false, false, false, false },
    { "jū",  "jú",  "jǔ",  "jù",  "ju" }
  },
  ["lssp_three_jvan"] = {
    { false,  false,  false,  false,  false },
    { "juān", "juán", "juǎn", "juàn", "juan" },
    { false,  false,  false,  false,  false }
  },
  ["lssp_three_jvevn"] = {
    { "juē", "jué", "juě", "juè", "jue" },
    { "jūn", "jún", "jǔn", "jùn", "jun" },
    { false, false, false, false, false }
  },
  ["lssp_three_kaanang"] = {
    { "kā",   "ká",   "kǎ",   "kà",   "ka" },
    { "kān",  "kán",  "kǎn",  "kàn",  "kan" },
    { "kāng", "káng", "kǎng", "kàng", "kang" }
  },
  ["lssp_three_kaieiao"] = {
    { "kāi", "kái", "kǎi", "kài", "kai" },
    { "kēi", "kéi", "kěi", "kèi", "kei" },
    { "kāo", "káo", "kǎo", "kào", "kao" }
  },
  ["lssp_three_keeneng"] = {
    { "kē",   "ké",   "kě",   "kè",   "ke" },
    { "kēn",  "kén",  "kěn",  "kèn",  "ken" },
    { "kēng", "kéng", "kěng", "kèng", "keng" }
  },
  ["lssp_three_kouong"] = {
    { false,  false,  false,  false,  false },
    { "kōu",  "kóu",  "kǒu",  "kòu",  "kou" },
    { "kōng", "kóng", "kǒng", "kòng", "kong" }
  },
  ["lssp_three_kuaiui"] = {
    { "kuāi", "kuái", "kuǎi", "kuài", "kuai" },
    { "kuī",  "kuí",  "kuǐ",  "kuì",  "kui" },
    { false,  false,  false,  false,  false }
  },
  ["lssp_three_kuauanuang"] = {
    { "kuā",   "kuá",   "kuǎ",   "kuà",   "kua" },
    { "kuān",  "kuán",  "kuǎn",  "kuàn",  "kuan" },
    { "kuāng", "kuáng", "kuǎng", "kuàng", "kuang" }
  },
  ["lssp_three_kun"] = {
    { false, false, false, false, false },
    { "kūn", "kún", "kǔn", "kùn", "kun" },
    { false, false, false, false, false }
  },
  ["lssp_three_kuou"] = {
    { "kuō", "kuó", "kuǒ", "kuò", "kuo" },
    { false, false, false, false, false },
    { "kū",  "kú",  "kǔ",  "kù",  "ku" }
  },
  ["lssp_three_laanang"] = {
    { "lā",   "lá",   "lǎ",   "là",   "la" },
    { "lān",  "lán",  "lǎn",  "làn",  "lan" },
    { "lāng", "láng", "lǎng", "làng", "lang" }
  },
  ["lssp_three_laieiao"] = {
    { "lāi", "lái", "lǎi", "lài", "lai" },
    { "lēi", "léi", "lěi", "lèi", "lei" },
    { "lāo", "láo", "lǎo", "lào", "lao" }
  },
  ["lssp_three_leeneng"] = {
    { "lē",   "lé",   "lě",   "lè",   "le" },
    { "lēn",  "lén",  "lěn",  "lèn",  "len" },
    { "lēng", "léng", "lěng", "lèng", "leng" }
  },
  ["lssp_three_liaianiang"] = {
    { "liā",   "liá",   "liǎ",   "lià",   "lia" },
    { "liān",  "lián",  "liǎn",  "liàn",  "lian" },
    { "liāng", "liáng", "liǎng", "liàng", "liang" }
  },
  ["lssp_three_lieining"] = {
    { "liē",  "lié",  "liě",  "liè",  "lie" },
    { "līn",  "lín",  "lǐn",  "lìn",  "lin" },
    { "līng", "líng", "lǐng", "lìng", "ling" }
  },
  ["lssp_three_liiao"] = {
    { false,  false,  false,  false,  false },
    { "lī",   "lí",   "lǐ",   "lì",   "li" },
    { "liāo", "liáo", "liǎo", "liào", "liao" }
  },
  ["lssp_three_liu"] = {
    { false, false, false, false, false },
    { "liū", "liú", "liǔ", "liù", "liu" },
    { false, false, false, false, false }
  },
  ["lssp_three_loouong"] = {
    { "lō",   "ló",   "lǒ",   "lò",   "lo" },
    { "lōu",  "lóu",  "lǒu",  "lòu",  "lou" },
    { "lōng", "lóng", "lǒng", "lòng", "long" }
  },
  ["lssp_three_luan"] = {
    { false,  false,  false,  false,  false },
    { "luān", "luán", "luǎn", "luàn", "luan" },
    { false,  false,  false,  false,  false }
  },
  ["lssp_three_lun"] = {
    { false, false, false, false, false },
    { "lūn", "lún", "lǔn", "lùn", "lun" },
    { false, false, false, false, false }
  },
  ["lssp_three_luou"] = {
    { "luō", "luó", "luǒ", "luò", "luo" },
    { false, false, false, false, false },
    { "lū",  "lú",  "lǔ",  "lù",  "lu" }
  },
  ["lssp_three_lv"] = {
    { false, false, false, false, false },
    { false, false, false, false, false },
    { "lǖ",  "lǘ",  "lǚ",  "lǜ",  "lü" }
  },
  ["lssp_three_lve"] = {
    { "lüē", "lüé", "lüě", "lüè", "lüe" },
    { false, false, false, false, false },
    { false, false, false, false, false }
  },
  ["lssp_three_maanang"] = {
    { "mā",   "má",   "mǎ",   "mà",   "ma" },
    { "mān",  "mán",  "mǎn",  "màn",  "man" },
    { "māng", "máng", "mǎng", "màng", "mang" }
  },
  ["lssp_three_maieiao"] = {
    { "māi", "mái", "mǎi", "mài", "mai" },
    { "mēi", "méi", "měi", "mèi", "mei" },
    { "māo", "máo", "mǎo", "mào", "mao" }
  },
  ["lssp_three_meeneng"] = {
    { "mē",   "mé",   "mě",   "mè",   "me" },
    { "mēn",  "mén",  "měn",  "mèn",  "men" },
    { "mēng", "méng", "měng", "mèng", "meng" }
  },
  ["lssp_three_mian"] = {
    { false,  false,  false,  false,  false },
    { "miān", "mián", "miǎn", "miàn", "mian" },
    { false,  false,  false,  false,  false }
  },
  ["lssp_three_mieining"] = {
    { "miē",  "mié",  "miě",  "miè",  "mie" },
    { "mīn",  "mín",  "mǐn",  "mìn",  "min" },
    { "mīng", "míng", "mǐng", "mìng", "ming" }
  },
  ["lssp_three_miiao"] = {
    { false,  false,  false,  false,  false },
    { "mī",   "mí",   "mǐ",   "mì",   "mi" },
    { "miāo", "miáo", "miǎo", "miào", "miao" }
  },
  ["lssp_three_miu"] = {
    { false, false, false, false, false },
    { "miū", "miú", "miǔ", "miù", "miu" },
    { false, false, false, false, false }
  },
  ["lssp_three_moou"] = {
    { "mō",  "mó",  "mǒ",  "mò",  "mo" },
    { "mōu", "móu", "mǒu", "mòu", "mou" },
    { false, false, false, false, false }
  },
  ["lssp_three_mu"] = {
    { false, false, false, false, false },
    { false, false, false, false, false },
    { "mū",  "mú",  "mǔ",  "mù",  "mu" }
  },
  ["lssp_three_naanang"] = {
    { "nā",   "ná",   "nǎ",   "nà",   "na" },
    { "nān",  "nán",  "nǎn",  "nàn",  "nan" },
    { "nāng", "náng", "nǎng", "nàng", "nang" }
  },
  ["lssp_three_naieiao"] = {
    { "nāi", "nái", "nǎi", "nài", "nai" },
    { "nēi", "néi", "něi", "nèi", "nei" },
    { "nāo", "náo", "nǎo", "nào", "nao" }
  },
  ["lssp_three_neeneng"] = {
    { "nē",   "né",   "ně",   "nè",   "ne" },
    { "nēn",  "nén",  "něn",  "nèn",  "nen" },
    { "nēng", "néng", "něng", "nèng", "neng" }
  },
  ["lssp_three_niaianiang"] = {
    { "niā",   "niá",   "niǎ",   "nià",   "nia" },
    { "niān",  "nián",  "niǎn",  "niàn",  "nian" },
    { "niāng", "niáng", "niǎng", "niàng", "niang" }
  },
  ["lssp_three_nieining"] = {
    { "niē",  "nié",  "niě",  "niè",  "nie" },
    { "nīn",  "nín",  "nǐn",  "nìn",  "nin" },
    { "nīng", "níng", "nǐng", "nìng", "ning" }
  },
  ["lssp_three_niiao"] = {
    { false,  false,  false,  false,  false },
    { "nī",   "ní",   "nǐ",   "nì",   "ni" },
    { "niāo", "niáo", "niǎo", "niào", "niao" }
  },
  ["lssp_three_niu"] = {
    { false, false, false, false, false },
    { "niū", "niú", "niǔ", "niù", "niu" },
    { false, false, false, false, false }
  },
  ["lssp_three_nouong"] = {
    { "nōu",  "nóu",  "nǒu",  "nòu",  "nou" },
    { false,  false,  false,  false,  false },
    { "nōng", "nóng", "nǒng", "nòng", "nong" }
  },
  ["lssp_three_nuan"] = {
    { false,  false,  false,  false,  false },
    { "nuān", "nuán", "nuǎn", "nuàn", "nuan" },
    { false,  false,  false,  false,  false }
  },
  ["lssp_three_nun"] = {
    { false, false, false, false, false },
    { "nūn", "nún", "nǔn", "nùn", "nun" },
    { false, false, false, false, false }
  },
  ["lssp_three_nuou"] = {
    { "nuō", "nuó", "nuǒ", "nuò", "nuo" },
    { false, false, false, false, false },
    { "nū",  "nú",  "nǔ",  "nù",  "nu" }
  },
  ["lssp_three_nv"] = {
    { false, false, false, false, false },
    { false, false, false, false, false },
    { "nǖ",  "nǘ",  "nǚ",  "nǜ",  "nü" }
  },
  ["lssp_three_nve"] = {
    { "nüē", "nüé", "nüě", "nüè", "nüe" },
    { false, false, false, false, false },
    { false, false, false, false, false }
  },
  ["lssp_three_oou"] = {
    { "ō",   "ó",   "ǒ",   "ò",   "o" },
    { "ōu",  "óu",  "ǒu",  "òu",  "ou" },
    { false, false, false, false, false }
  },
  ["lssp_three_paanang"] = {
    { "pā",   "pá",   "pǎ",   "pà",   "pa" },
    { "pān",  "pán",  "pǎn",  "pàn",  "pan" },
    { "pāng", "páng", "pǎng", "pàng", "pang" }
  },
  ["lssp_three_paieiao"] = {
    { "pāi", "pái", "pǎi", "pài", "pai" },
    { "pēi", "péi", "pěi", "pèi", "pei" },
    { "pāo", "páo", "pǎo", "pào", "pao" }
  },
  ["lssp_three_peneng"] = {
    { false,  false,  false,  false,  false },
    { "pēn",  "pén",  "pěn",  "pèn",  "pen" },
    { "pēng", "péng", "pěng", "pèng", "peng" }
  },
  ["lssp_three_pian"] = {
    { false,  false,  false,  false,  false },
    { "piān", "pián", "piǎn", "piàn", "pian" },
    { false,  false,  false,  false,  false }
  },
  ["lssp_three_pieining"] = {
    { "piē",  "pié",  "piě",  "piè",  "pie" },
    { "pīn",  "pín",  "pǐn",  "pìn",  "pin" },
    { "pīng", "píng", "pǐng", "pìng", "ping" }
  },
  ["lssp_three_piiao"] = {
    { false,  false,  false,  false,  false },
    { "pī",   "pí",   "pǐ",   "pì",   "pi" },
    { "piāo", "piáo", "piǎo", "piào", "piao" }
  },
  ["lssp_three_poou"] = {
    { "pō",  "pó",  "pǒ",  "pò",  "po" },
    { "pōu", "póu", "pǒu", "pòu", "pou" },
    { false, false, false, false, false }
  },
  ["lssp_three_pu"] = {
    { false, false, false, false, false },
    { false, false, false, false, false },
    { "pū",  "pú",  "pǔ",  "pù",  "pu" }
  },
  ["lssp_three_qiaianiang"] = {
    { "qiā",   "qiá",   "qiǎ",   "qià",   "qia" },
    { "qiān",  "qián",  "qiǎn",  "qiàn",  "qian" },
    { "qiāng", "qiáng", "qiǎng", "qiàng", "qiang" }
  },
  ["lssp_three_qieining"] = {
    { "qiē",  "qié",  "qiě",  "qiè",  "qie" },
    { "qīn",  "qín",  "qǐn",  "qìn",  "qin" },
    { "qīng", "qíng", "qǐng", "qìng", "qing" }
  },
  ["lssp_three_qiiao"] = {
    { false,  false,  false,  false,  false },
    { "qī",   "qí",   "qǐ",   "qì",   "qi" },
    { "qiāo", "qiáo", "qiǎo", "qiào", "qiao" }
  },
  ["lssp_three_qiuiong"] = {
    { false,   false,   false,   false,   false },
    { "qiū",   "qiú",   "qiǔ",   "qiù",   "qiu" },
    { "qiōng", "qióng", "qiǒng", "qiòng", "qiong" }
  },
  ["lssp_three_qv"] = {
    { false, false, false, false, false },
    { false, false, false, false, false },
    { "qū",  "qú",  "qǔ",  "qù",  "qu" }
  },
  ["lssp_three_qvan"] = {
    { false,  false,  false,  false,  false },
    { "quān", "quán", "quǎn", "quàn", "quan" },
    { false,  false,  false,  false,  false }
  },
  ["lssp_three_qvevn"] = {
    { "quē", "qué", "quě", "què", "que" },
    { "qūn", "qún", "qǔn", "qùn", "qun" },
    { false, false, false, false, false }
  },
  ["lssp_three_ranang"] = {
    { false,  false,  false,  false,  false },
    { "rān",  "rán",  "rǎn",  "ràn",  "ran" },
    { "rāng", "ráng", "rǎng", "ràng", "rang" }
  },
  ["lssp_three_rao"] = {
    { false, false, false, false, false },
    { false, false, false, false, false },
    { "rāo", "ráo", "rǎo", "rào", "rao" }
  },
  ["lssp_three_reeneng"] = {
    { "rē",   "ré",   "rě",   "rè",   "re" },
    { "rēn",  "rén",  "rěn",  "rèn",  "ren" },
    { "rēng", "réng", "rěng", "rèng", "reng" }
  },
  ["lssp_three_riouong"] = {
    { "rī",   "rí",   "rǐ",   "rì",   "ri" },
    { "rōu",  "róu",  "rǒu",  "ròu",  "rou" },
    { "rōng", "róng", "rǒng", "ròng", "rong" }
  },
  ["lssp_three_ruauan"] = {
    { "ruā",  "ruá",  "ruǎ",  "ruà",  "rua" },
    { "ruān", "ruán", "ruǎn", "ruàn", "ruan" },
    { false,  false,  false,  false,  false }
  },
  ["lssp_three_rui"] = {
    { false, false, false, false, false },
    { "ruī", "ruí", "ruǐ", "ruì", "rui" },
    { false, false, false, false, false }
  },
  ["lssp_three_run"] = {
    { false, false, false, false, false },
    { "rūn", "rún", "rǔn", "rùn", "run" },
    { false, false, false, false, false }
  },
  ["lssp_three_ruou"] = {
    { "ruō", "ruó", "ruǒ", "ruò", "ruo" },
    { false, false, false, false, false },
    { "rū",  "rú",  "rǔ",  "rù",  "ru" }
  },
  ["lssp_three_saanang"] = {
    { "sā",   "sá",   "sǎ",   "sà",   "sa" },
    { "sān",  "sán",  "sǎn",  "sàn",  "san" },
    { "sāng", "sáng", "sǎng", "sàng", "sang" }
  },
  ["lssp_three_saiao"] = {
    { "sāi", "sái", "sǎi", "sài", "sai" },
    { false, false, false, false, false },
    { "sāo", "sáo", "sǎo", "sào", "sao" }
  },
  ["lssp_three_seeneng"] = {
    { "sē",   "sé",   "sě",   "sè",   "se" },
    { "sēn",  "sén",  "sěn",  "sèn",  "sen" },
    { "sēng", "séng", "sěng", "sèng", "seng" }
  },
  ["lssp_three_shaanang"] = {
    { "shā",   "shá",   "shǎ",   "shà",   "sha" },
    { "shān",  "shán",  "shǎn",  "shàn",  "shan" },
    { "shāng", "sháng", "shǎng", "shàng", "shang" }
  },
  ["lssp_three_shaieiao"] = {
    { "shāi", "shái", "shǎi", "shài", "shai" },
    { "shēi", "shéi", "shěi", "shèi", "shei" },
    { "shāo", "sháo", "shǎo", "shào", "shao" }
  },
  ["lssp_three_sheeneng"] = {
    { "shē",   "shé",   "shě",   "shè",   "she" },
    { "shēn",  "shén",  "shěn",  "shèn",  "shen" },
    { "shēng", "shéng", "shěng", "shèng", "sheng" }
  },
  ["lssp_three_shiou"] = {
    { "shī",  "shí",  "shǐ",  "shì",  "shi" },
    { "shōu", "shóu", "shǒu", "shòu", "shou" },
    { false,  false,  false,  false,  false }
  },
  ["lssp_three_shuaiui"] = {
    { "shuāi", "shuái", "shuǎi", "shuài", "shuai" },
    { "shuī",  "shuí",  "shuǐ",  "shuì",  "shui" },
    { false,   false,   false,   false,   false }
  },
  ["lssp_three_shuauanuang"] = {
    { "shuā",   "shuá",   "shuǎ",   "shuà",   "shua" },
    { "shuān",  "shuán",  "shuǎn",  "shuàn",  "shuan" },
    { "shuāng", "shuáng", "shuǎng", "shuàng", "shuang" }
  },
  ["lssp_three_shun"] = {
    { false,  false,  false,  false,  false },
    { "shūn", "shún", "shǔn", "shùn", "shun" },
    { false,  false,  false,  false,  false }
  },
  ["lssp_three_shuou"] = {
    { "shuō", "shuó", "shuǒ", "shuò", "shuo" },
    { false,  false,  false,  false,  false },
    { "shū",  "shú",  "shǔ",  "shù",  "shu" }
  },
  ["lssp_three_siouong"] = {
    { "sī",   "sí",   "sǐ",   "sì",   "si" },
    { "sōu",  "sóu",  "sǒu",  "sòu",  "sou" },
    { "sōng", "sóng", "sǒng", "sòng", "song" }
  },
  ["lssp_three_suan"] = {
    { false,  false,  false,  false,  false },
    { "suān", "suán", "suǎn", "suàn", "suan" },
    { false,  false,  false,  false,  false }
  },
  ["lssp_three_sun"] = {
    { false, false, false, false, false },
    { "sūn", "sún", "sǔn", "sùn", "sun" },
    { false, false, false, false, false }
  },
  ["lssp_three_suouiu"] = {
    { "suō", "suó", "suǒ", "suò", "suo" },
    { "suī", "suí", "suǐ", "suì", "sui" },
    { "sū",  "sú",  "sǔ",  "sù",  "su" }
  },
  ["lssp_three_taanang"] = {
    { "tā",   "tá",   "tǎ",   "tà",   "ta" },
    { "tān",  "tán",  "tǎn",  "tàn",  "tan" },
    { "tāng", "táng", "tǎng", "tàng", "tang" }
  },
  ["lssp_three_taieiao"] = {
    { "tāi", "tái", "tǎi", "tài", "tai" },
    { "tēi", "téi", "těi", "tèi", "tei" },
    { "tāo", "táo", "tǎo", "tào", "tao" }
  },
  ["lssp_three_teeng"] = {
    { "tē",   "té",   "tě",   "tè",   "te" },
    { false,  false,  false,  false,  false },
    { "tēng", "téng", "těng", "tèng", "teng" }
  },
  ["lssp_three_tian"] = {
    { false,  false,  false,  false,  false },
    { "tiān", "tián", "tiǎn", "tiàn", "tian" },
    { false,  false,  false,  false,  false }
  },
  ["lssp_three_tieing"] = {
    { "tiē",  "tié",  "tiě",  "tiè",  "tie" },
    { false,  false,  false,  false,  false },
    { "tīng", "tíng", "tǐng", "tìng", "ting" }
  },
  ["lssp_three_tiiao"] = {
    { false,  false,  false,  false,  false },
    { "tī",   "tí",   "tǐ",   "tì",   "ti" },
    { "tiāo", "tiáo", "tiǎo", "tiào", "tiao" }
  },
  ["lssp_three_touong"] = {
    { false,  false,  false,  false,  false },
    { "tōu",  "tóu",  "tǒu",  "tòu",  "tou" },
    { "tōng", "tóng", "tǒng", "tòng", "tong" }
  },
  ["lssp_three_tuan"] = {
    { false,  false,  false,  false,  false },
    { "tuān", "tuán", "tuǎn", "tuàn", "tuan" },
    { false,  false,  false,  false,  false }
  },
  ["lssp_three_tui"] = {
    { false, false, false, false, false },
    { "tuī", "tuí", "tuǐ", "tuì", "tui" },
    { false, false, false, false, false }
  },
  ["lssp_three_tun"] = {
    { false, false, false, false, false },
    { "tūn", "tún", "tǔn", "tùn", "tun" },
    { false, false, false, false, false }
  },
  ["lssp_three_tuou"] = {
    { "tuō", "tuó", "tuǒ", "tuò", "tuo" },
    { false, false, false, false, false },
    { "tū",  "tú",  "tǔ",  "tù",  "tu" }
  },
  ["lssp_three_waanang"] = {
    { "wā",   "wá",   "wǎ",   "wà",   "wa" },
    { "wān",  "wán",  "wǎn",  "wàn",  "wan" },
    { "wāng", "wáng", "wǎng", "wàng", "wang" }
  },
  ["lssp_three_waiei"] = {
    { "wāi", "wái", "wǎi", "wài", "wai" },
    { "wēi", "wéi", "wěi", "wèi", "wei" },
    { false, false, false, false, false }
  },
  ["lssp_three_weneng"] = {
    { false,  false,  false,  false,  false },
    { "wēn",  "wén",  "wěn",  "wèn",  "wen" },
    { "wēng", "wéng", "wěng", "wèng", "weng" }
  },
  ["lssp_three_wou"] = {
    { "wō",  "wó",  "wǒ",  "wò",  "wo" },
    { false, false, false, false, false },
    { "wū",  "wú",  "wǔ",  "wù",  "wu" }
  },
  ["lssp_three_xiaianiang"] = {
    { "xiā",   "xiá",   "xiǎ",   "xià",   "xia" },
    { "xiān",  "xián",  "xiǎn",  "xiàn",  "xian" },
    { "xiāng", "xiáng", "xiǎng", "xiàng", "xiang" }
  },
  ["lssp_three_xieining"] = {
    { "xiē",  "xié",  "xiě",  "xiè",  "xie" },
    { "xīn",  "xín",  "xǐn",  "xìn",  "xin" },
    { "xīng", "xíng", "xǐng", "xìng", "xing" }
  },
  ["lssp_three_xiiao"] = {
    { false,  false,  false,  false,  false },
    { "xī",   "xí",   "xǐ",   "xì",   "xi" },
    { "xiāo", "xiáo", "xiǎo", "xiào", "xiao" }
  },
  ["lssp_three_xiuiong"] = {
    { false,   false,   false,   false,   false },
    { "xiū",   "xiú",   "xiǔ",   "xiù",   "xiu" },
    { "xiōng", "xióng", "xiǒng", "xiòng", "xiong" }
  },
  ["lssp_three_xv"] = {
    { false, false, false, false, false },
    { false, false, false, false, false },
    { "xū",  "xú",  "xǔ",  "xù",  "xu" }
  },
  ["lssp_three_xvan"] = {
    { false,  false,  false,  false,  false },
    { "xuān", "xuán", "xuǎn", "xuàn", "xuan" },
    { false,  false,  false,  false,  false }
  },
  ["lssp_three_xvevn"] = {
    { "xuē", "xué", "xuě", "xuè", "xue" },
    { "xūn", "xún", "xǔn", "xùn", "xun" },
    { false, false, false, false, false }
  },
  ["lssp_three_yaanang"] = {
    { "yā",   "yá",   "yǎ",   "yà",   "ya" },
    { "yān",  "yán",  "yǎn",  "yàn",  "yan" },
    { "yāng", "yáng", "yǎng", "yàng", "yang" }
  },
  ["lssp_three_yeining"] = {
    { "yē",   "yé",   "yě",   "yè",   "ye" },
    { "yīn",  "yín",  "yǐn",  "yìn",  "yin" },
    { "yīng", "yíng", "yǐng", "yìng", "ying" }
  },
  ["lssp_three_yiao"] = {
    { false, false, false, false, false },
    { "yī",  "yí",  "yǐ",  "yì",  "yi" },
    { "yāo", "yáo", "yǎo", "yào", "yao" }
  },
  ["lssp_three_yoouong"] = {
    { "yō",   "yó",   "yǒ",   "yò",   "yo" },
    { "yōu",  "yóu",  "yǒu",  "yòu",  "you" },
    { "yōng", "yóng", "yǒng", "yòng", "yong" }
  },
  ["lssp_three_yv"] = {
    { false, false, false, false, false },
    { false, false, false, false, false },
    { "yū",  "yú",  "yǔ",  "yù",  "yu" }
  },
  ["lssp_three_yvevn"] = {
    { "yuē", "yué", "yuě", "yuè", "yue" },
    { "yūn", "yún", "yǔn", "yùn", "yun" },
    { false, false, false, false, false }
  },
  ["lssp_three_zaanang"] = {
    { "zā",   "zá",   "zǎ",   "zà",   "za" },
    { "zān",  "zán",  "zǎn",  "zàn",  "zan" },
    { "zāng", "záng", "zǎng", "zàng", "zang" }
  },
  ["lssp_three_zaieiao"] = {
    { "zāi", "zái", "zǎi", "zài", "zai" },
    { "zēi", "zéi", "zěi", "zèi", "zei" },
    { "zāo", "záo", "zǎo", "zào", "zao" }
  },
  ["lssp_three_zeeneng"] = {
    { "zē",   "zé",   "zě",   "zè",   "ze" },
    { "zēn",  "zén",  "zěn",  "zèn",  "zen" },
    { "zēng", "zéng", "zěng", "zèng", "zeng" }
  },
  ["lssp_three_zhaanang"] = {
    { "zhā",   "zhá",   "zhǎ",   "zhà",   "zha" },
    { "zhān",  "zhán",  "zhǎn",  "zhàn",  "zhan" },
    { "zhāng", "zháng", "zhǎng", "zhàng", "zhang" }
  },
  ["lssp_three_zhaieiao"] = {
    { "zhāi", "zhái", "zhǎi", "zhài", "zhai" },
    { "zhēi", "zhéi", "zhěi", "zhèi", "zhei" },
    { "zhāo", "zháo", "zhǎo", "zhào", "zhao" }
  },
  ["lssp_three_zheeneng"] = {
    { "zhē",   "zhé",   "zhě",   "zhè",   "zhe" },
    { "zhēn",  "zhén",  "zhěn",  "zhèn",  "zhen" },
    { "zhēng", "zhéng", "zhěng", "zhèng", "zheng" }
  },
  ["lssp_three_zhiouong"] = {
    { "zhī",   "zhí",   "zhǐ",   "zhì",   "zhi" },
    { "zhōu",  "zhóu",  "zhǒu",  "zhòu",  "zhou" },
    { "zhōng", "zhóng", "zhǒng", "zhòng", "zhong" }
  },
  ["lssp_three_zhuaiui"] = {
    { "zhuāi", "zhuái", "zhuǎi", "zhuài", "zhuai" },
    { "zhuī",  "zhuí",  "zhuǐ",  "zhuì",  "zhui" },
    { false,   false,   false,   false,   false }
  },
  ["lssp_three_zhuauanuang"] = {
    { "zhuā",   "zhuá",   "zhuǎ",   "zhuà",   "zhua" },
    { "zhuān",  "zhuán",  "zhuǎn",  "zhuàn",  "zhuan" },
    { "zhuāng", "zhuáng", "zhuǎng", "zhuàng", "zhuang" }
  },
  ["lssp_three_zhun"] = {
    { false,  false,  false,  false,  false },
    { "zhūn", "zhún", "zhǔn", "zhùn", "zhun" },
    { false,  false,  false,  false,  false }
  },
  ["lssp_three_zhuou"] = {
    { "zhuō", "zhuó", "zhuǒ", "zhuò", "zhuo" },
    { false,  false,  false,  false,  false },
    { "zhū",  "zhú",  "zhǔ",  "zhù",  "zhu" }
  },
  ["lssp_three_ziouong"] = {
    { "zī",   "zí",   "zǐ",   "zì",   "zi" },
    { "zōu",  "zóu",  "zǒu",  "zòu",  "zou" },
    { "zōng", "zóng", "zǒng", "zòng", "zong" }
  },
  ["lssp_three_zuan"] = {
    { false,  false,  false,  false,  false },
    { "zuān", "zuán", "zuǎn", "zuàn", "zuan" },
    { false,  false,  false,  false,  false }
  },
  ["lssp_three_zun"] = {
    { false, false, false, false, false },
    { "zūn", "zún", "zǔn", "zùn", "zun" },
    { false, false, false, false, false }
  },
  ["lssp_three_zuouiu"] = {
    { "zuō", "zuó", "zuǒ", "zuò", "zuo" },
    { "zuī", "zuí", "zuǐ", "zuì", "zui" },
    { "zū",  "zú",  "zǔ",  "zù",  "zu" }
  }
}

-- ========== 生成全部键盘 ==========

local result = {}
for key_name, rows_data in pairs(TONE_DATA) do
  local suffix = key_name:sub(12) -- strip "lssp_three_"
  result[key_name] = make_third_code(suffix, rows_data)
end

return result
