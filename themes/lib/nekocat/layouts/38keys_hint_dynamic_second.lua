-- SPDX-License-Identifier: GPL-3.0-or-later
-- LSSP 动态第二码键盘工厂
-- 数据驱动生成全部 15 个第二码键盘，替代 15 个独立文件

local function make_cell(data)
  if data == false then
    return key { label = { { color = "overlay1" } } }
  end
  return key { dynamic = data.d, label = { { text = data.t } } }
end

local template = keyboard(merge(safe_require("nekocat.layouts.38keys_hint_dynamic_first"), keyboard {
  name = "鸢鸣万象·动态第二码模板",
  rows = {
    [2] = { keys = {
      [2] = key { label = { { text = "∅" } }, key_text_size = 13, dynamic = "lssp_three_default_aanang" },
      [3] = key { label = { { text = "∅" } }, key_text_size = 13, dynamic = "lssp_three_default_aieiao" },
      [4] = key { label = { { text = "∅" } }, key_text_size = 13, dynamic = "lssp_three_default_oouong" },
      [5] = key { label = { { text = "∅" } }, key_text_size = 13, dynamic = "lssp_three_default_eeneng" },
      [6] = key { label = { { text = "∅" } }, key_text_size = 13, dynamic = "lssp_three_default_ervan" }
    } }, [3] = { keys = {
    [2] = key { label = { { text = "∅" } }, key_text_size = 13, dynamic = "lssp_three_default_iaianiang" },
    [3] = key { label = { { text = "∅" } }, key_text_size = 13, dynamic = "lssp_three_default_iaiiiao" },
    [4] = key { label = { { text = "∅" } }, key_text_size = 13, dynamic = "lssp_three_default_ioiuiong" },
    [5] = key { label = { { text = "∅" } }, key_text_size = 13, dynamic = "lssp_three_default_ieining" },
    [6] = key { label = { { text = "∅" } }, key_text_size = 13, dynamic = "lssp_three_default_v" }
  } }, [4] = { keys = {
    [2] = key { label = { { text = "∅" } }, key_text_size = 13, dynamic = "lssp_three_default_uauanuang" },
    [3] = key { label = { { text = "∅" } }, key_text_size = 13, dynamic = "lssp_three_default_uaiui" },
    [4] = key { label = { { text = "∅" } }, key_text_size = 13, dynamic = "lssp_three_default_uou" },
    [5] = key { label = { { text = "∅" } }, key_text_size = 13, dynamic = "lssp_three_default_unueng" },
    [6] = key { label = { { text = "∅" } }, key_text_size = 13, dynamic = "lssp_three_default_vevn" }
  } }
  }
}))

local function make_second_code(name_suffix, rows_data)
  local rows = {}
  for idx, row_cells in ipairs(rows_data) do
    local keys = {}
    for ci, cd in ipairs(row_cells) do
      keys[ci + 1] = make_cell(cd)
    end
    rows[idx + 1] = { keys = keys }
  end
  return keyboard(merge(template, keyboard {
    name = "鸢鸣万象·动态第二码" .. name_suffix,
    rows = rows
  }))
end

-- ========== 声母韵母映射数据表 ==========

local SECOND_CODE_DATA = {
  b = {
    {
      { d = "lssp_three_baanang", t = { "ba ban\n", "bang" } },
      { d = "lssp_three_baieiao", t = { "bai bei\n", "bao" } },
      { d = "lssp_three_bo",      t = "bo" },
      { d = "lssp_three_beneng",  t = { "ben\n", "beng" } },
      false },
    {
      { d = "lssp_three_bianiang", t = { "bian\n", "biang" } },
      { d = "lssp_three_biiao",    t = { "bi biao" } },
      false,
      { d = "lssp_three_bieining", t = { "bie bin\n", "bing" } },
      false },
    {
      false,
      false,
      { d = "lssp_three_bu", t = "bu" },
      false,
      false
    }
  },
  chc = {
    {
      { d = "lssp_three_chaanang", t = { "cha chan\n", "chang" } },
      { d = "lssp_three_chaiao",   t = { "chai chao" } },
      { d = "lssp_three_chiouong", t = { "chi chou\n", "chong" } },
      { d = "lssp_three_cheeneng", t = { "che chen\n", "cheng" } },
      { d = "lssp_three_cuan",     t = "cuan" }
    },
    {
      { d = "lssp_three_caanang", t = { "ca can\n", "cang" } },
      { d = "lssp_three_caiao",   t = { "cai cao" } },
      { d = "lssp_three_ciouong", t = { "ci cou\n", "cong" } },
      { d = "lssp_three_ceeneng", t = { "ce cen\n", "ceng" } },
      { d = "lssp_three_cuouiu",  t = { "cuo cui\n", "cu" } }
    },
    {
      { d = "lssp_three_chuauanuang", t = { "chua|uan\n", "chuang" } },
      { d = "lssp_three_chuaiui",     t = { "chuai\n", "chui" } },
      { d = "lssp_three_chuou",       t = { "chuo\n", "chu" } },
      { d = "lssp_three_chun",        t = "chun" },
      { d = "lssp_three_cun",         t = "cun" }
    }
  },
  d = {
    {
      { d = "lssp_three_daanang", t = { "da dan\n", "dang" } },
      { d = "lssp_three_daieiao", t = { "dai dei\n", "dao" } },
      { d = "lssp_three_douong",  t = { "dou\n", "dong" } },
      { d = "lssp_three_deeneng", t = { "de den\n", "deng" } },
      false
    },
    {
      { d = "lssp_three_diaian", t = { "dia dian" } },
      { d = "lssp_three_diiao",  t = { "di diao" } },
      { d = "lssp_three_diu",    t = "diu" },
      { d = "lssp_three_dieing", t = { "die ding" } },
      false
    },
    {
      { d = "lssp_three_duan", t = "duan" },
      { d = "lssp_three_dui",  t = "dui" },
      { d = "lssp_three_duou", t = { "duo du" } },
      { d = "lssp_three_dun",  t = "dun" },
      false
    }
  },
  gj = {
    {
      { d = "lssp_three_gaanang", t = { "ga gan\n", "gang" } },
      { d = "lssp_three_gaieiao", t = { "gai gei\n", "gao" } },
      { d = "lssp_three_gouong",  t = { "gou\n", "gong" } },
      { d = "lssp_three_geeneng", t = { "ge gen\n", "geng" } },
      { d = "lssp_three_jvan",    t = "juan" }
    },
    {
      { d = "lssp_three_jiaianiang", t = { "jia jian\n", "jiang" } },
      { d = "lssp_three_jiiao",      t = { "ji jiao" } },
      { d = "lssp_three_jiuiong",    t = { "jiu\n", "jiong" } },
      { d = "lssp_three_jieining",   t = { "jie jin\n", "jing" } },
      { d = "lssp_three_jv",         t = "ju" }
    },
    {
      { d = "lssp_three_guauanuang", t = { "gua guan\n", "guang" } },
      { d = "lssp_three_guaiui",     t = { "guai gui" } },
      { d = "lssp_three_guou",       t = { "guo gu" } },
      { d = "lssp_three_gun",        t = "gun" },
      { d = "lssp_three_jvevn",      t = { "jue jun" } }
    }
  },
  hx = {
    {
      { d = "lssp_three_haanang", t = { "ha han\n", "hang" } },
      { d = "lssp_three_haieiao", t = { "hai hei\n", "hao" } },
      { d = "lssp_three_houong",  t = { "hou\n", "hong" } },
      { d = "lssp_three_heeneng", t = { "he hen\n", "heng" } },
      { d = "lssp_three_xvan",    t = "xuan" }
    },
    {
      { d = "lssp_three_xiaianiang", t = { "xia xian\n", "xiang" } },
      { d = "lssp_three_xiiao",      t = { "xi xiao" } },
      { d = "lssp_three_xiuiong",    t = { "xiu\n", "xiong" } },
      { d = "lssp_three_xieining",   t = { "xie xin\n", "xing" } },
      { d = "lssp_three_xv",         t = "xu" }
    },
    {
      { d = "lssp_three_huauanuang", t = { "hua huan\n", "huang" } },
      { d = "lssp_three_huaiui",     t = { "huai hui" } },
      { d = "lssp_three_huou",       t = { "huo hu" } },
      { d = "lssp_three_hun",        t = "hun" },
      { d = "lssp_three_xvevn",      t = { "xue xun" } }
    }
  },
  kq = {
    {
      { d = "lssp_three_kaanang", t = { "ka kan\n", "kang" } },
      { d = "lssp_three_kaieiao", t = { "kai kei\n", "kao" } },
      { d = "lssp_three_kouong",  t = { "kou\n", "kong" } },
      { d = "lssp_three_keeneng", t = { "ke ken\n", "keng" } },
      { d = "lssp_three_qvan",    t = "quan" }
    },
    {
      { d = "lssp_three_qiaianiang", t = { "qia qian\n", "qiang" } },
      { d = "lssp_three_qiiao",      t = { "qi qiao" } },
      { d = "lssp_three_qiuiong",    t = { "qiu\n", "qiong" } },
      { d = "lssp_three_qieining",   t = { "qie qin\n", "qing" } },
      { d = "lssp_three_qv",         t = "qu" }
    },
    {
      { d = "lssp_three_kuauanuang", t = { "kua kuan\n", "kuang" } },
      { d = "lssp_three_kuaiui",     t = { "kuai kui" } },
      { d = "lssp_three_kuou",       t = { "kuo ku" } },
      { d = "lssp_three_kun",        t = "kun" },
      { d = "lssp_three_qvevn",      t = { "que qun" } }
    }
  },
  l = {
    {
      { d = "lssp_three_laanang", t = { "la lan\n", "lang" } },
      { d = "lssp_three_laieiao", t = { "lai lei\n", "lao" } },
      { d = "lssp_three_loouong", t = { "lo lou\n", "long" } },
      { d = "lssp_three_leeneng", t = { "le leng" } },
      false
    },
    {
      { d = "lssp_three_liaianiang", t = { "lia lian\n", "liang" } },
      { d = "lssp_three_liiao",      t = { "li liao" } },
      { d = "lssp_three_liu",        t = "liu" },
      { d = "lssp_three_lieining",   t = { "lie lin\n", "ling" } },
      { d = "lssp_three_lv",         t = "lü" }
    },
    {
      { d = "lssp_three_luan", t = "luan" },
      false,
      { d = "lssp_three_luou", t = { "luo lu" } },
      { d = "lssp_three_lun",  t = "lun" },
      { d = "lssp_three_lve",  t = "lüe" }
    }
  },
  m = {
    {
      { d = "lssp_three_maanang", t = { "ma man\n", "mang" } },
      { d = "lssp_three_maieiao", t = { "mai mei\n", "mao" } },
      { d = "lssp_three_moou",    t = { "mo mou" } },
      { d = "lssp_three_meeneng", t = { "me men\n", "meng" } },
      false
    },
    {
      { d = "lssp_three_mian",     t = "mian" },
      { d = "lssp_three_miiao",    t = { "mi miao" } },
      { d = "lssp_three_miu",      t = "miu" },
      { d = "lssp_three_mieining", t = { "mie min\n", "ming" } },
      false
    },
    {
      false,
      false,
      { d = "lssp_three_mu", t = "mu" },
      false,
      false
    }
  },
  n = {
    {
      { d = "lssp_three_naanang", t = { "na nan\n", "nang" } },
      { d = "lssp_three_naieiao", t = { "nai nei\n", "nao" } },
      { d = "lssp_three_nouong",  t = { "nou\n", "nong" } },
      { d = "lssp_three_neeneng", t = { "ne nen\n", "neng" } },
      false
    },
    {
      { d = "lssp_three_niaianiang", t = { "nian\n", "niang" } },
      { d = "lssp_three_niiao",      t = { "ni niao" } },
      { d = "lssp_three_niu",        t = "niu" },
      { d = "lssp_three_nieining",   t = { "nie nin\n", "ning" } },
      { d = "lssp_three_nv",         t = "nü" }
    },
    {
      { d = "lssp_three_nuan", t = "nuan" },
      false,
      { d = "lssp_three_nuou", t = { "nuo nu" } },
      { d = "lssp_three_nun",  t = "nun" },
      { d = "lssp_three_nve",  t = "nüe" }
    }
  },
  p = {
    {
      { d = "lssp_three_paanang", t = { "pa pan\n", "pang" } },
      { d = "lssp_three_paieiao", t = { "pai pei\n", "pao" } },
      { d = "lssp_three_poou",    t = { "po pou" } },
      { d = "lssp_three_peneng",  t = { "pen\n", "peng" } },
      false
    },
    {
      { d = "lssp_three_pian",  t = "pian" },
      { d = "lssp_three_piiao", t = { "pi piao" } },
      false,
      { d = "lssp_three_pieining", t = { "pie pin\n", "ping" } },
      false
    },
    {
      false,
      false,
      { d = "lssp_three_pu", t = "pu" },
      false,
      false
    }
  },
  rf = {
    {
      { d = "lssp_three_ranang",  t = { "ran rang" } },
      { d = "lssp_three_rao",     t = "rao" },
      { d = "lssp_three_riouong", t = { "ri rou\n", "rong" } },
      { d = "lssp_three_reeneng", t = { "re ren\n", "reng" } },
      false
    },
    {
      { d = "lssp_three_faanang", t = { "fa fan\n", "fang" } },
      { d = "lssp_three_feiiao",  t = { "fei fiao" } },
      { d = "lssp_three_foou",    t = { "fo fou" } },
      { d = "lssp_three_feneng",  t = { "fen\n", "feng" } },
      { d = "lssp_three_fu",      t = "fu" }
    },
    {
      { d = "lssp_three_ruauan", t = { "rua\n", "ruan" } },
      { d = "lssp_three_rui",    t = "rui" },
      { d = "lssp_three_ruou",   t = { "ruo ru" } },
      { d = "lssp_three_run",    t = "run" },
      false
    }
  },
  shs = {
    {
      { d = "lssp_three_shaanang", t = { "sha shan\n", "shang" } },
      { d = "lssp_three_shaieiao", t = { "shai shei\n", "shao" } },
      { d = "lssp_three_shiou",    t = { "shi shou" } },
      { d = "lssp_three_sheeneng", t = { "she shen\n", "sheng" } },
      { d = "lssp_three_suan",     t = "suan" }
    },
    {
      { d = "lssp_three_saanang", t = { "sa san\n", "sang" } },
      { d = "lssp_three_saiao",   t = { "sai sao" } },
      { d = "lssp_three_siouong", t = { "si sou\n", "song" } },
      { d = "lssp_three_seeneng", t = { "se sen\n", "seng" } },
      { d = "lssp_three_suouiu",  t = { "suo sui\n", "su" } }
    },
    {
      { d = "lssp_three_shuauanuang", t = { "shua|uan\n", "shuang" } },
      { d = "lssp_three_shuaiui",     t = { "shuai\n", "shui" } },
      { d = "lssp_three_shuou",       t = { "shuo\n", "shu" } },
      { d = "lssp_three_shun",        t = "shun" },
      { d = "lssp_three_sun",         t = "sun" }
    }
  },
  t = {
    {
      { d = "lssp_three_taanang", t = { "ta tan\n", "tang" } },
      { d = "lssp_three_taieiao", t = { "tai tei\n", "tao" } },
      { d = "lssp_three_touong",  t = { "tou\n", "tong" } },
      { d = "lssp_three_teeng",   t = { "te teng" } },
      false
    },
    {
      { d = "lssp_three_tian",  t = "tian" },
      { d = "lssp_three_tiiao", t = { "ti tiao" } },
      false,
      { d = "lssp_three_tieing", t = { "tie ting" } },
      false
    },
    {
      { d = "lssp_three_tuan", t = "tuan" },
      { d = "lssp_three_tui",  t = "tui" },
      { d = "lssp_three_tuou", t = { "tuo tu" } },
      { d = "lssp_three_tun",  t = "tun" },
      false
    }
  },
  wy = {
    {
      { d = "lssp_three_aanang", t = { "a an\n", "ang" } },
      { d = "lssp_three_aieiao", t = { "ai ê\n", "ao" } },
      { d = "lssp_three_oou",    t = { "o ou" } },
      { d = "lssp_three_eeneng", t = { "e en\n", "eng" } },
      { d = "lssp_three_eryvan", t = { "er yuan" } }
    },
    {
      { d = "lssp_three_yaanang", t = { "ya yan\n", "yang" } },
      { d = "lssp_three_yiao",    t = { "yi yao" } },
      { d = "lssp_three_yoouong", t = { "yo you\n", "yong" } },
      { d = "lssp_three_yeining", t = { "ye yin\n", "ying" } },
      { d = "lssp_three_yv",      t = "yu" }
    },
    {
      { d = "lssp_three_waanang", t = { "wa wan\n", "wang" } },
      { d = "lssp_three_waiei",   t = { "wai wei" } },
      { d = "lssp_three_wou",     t = { "wo wu" } },
      { d = "lssp_three_weneng",  t = { "wen\n", "weng" } },
      { d = "lssp_three_yvevn",   t = { "yue yun" } }
    }
  },
  zhz = {
    {
      { d = "lssp_three_zhaanang", t = { "zha zhan\n", "zhang" } },
      { d = "lssp_three_zhaieiao", t = { "zhai zhei\n", "zhao" } },
      { d = "lssp_three_zhiouong", t = { "zhi zhou\n", "zhong" } },
      { d = "lssp_three_zheeneng", t = { "zhe zhen\n", "zheng" } },
      { d = "lssp_three_zuan",     t = "zuan" }
    },
    {
      { d = "lssp_three_zaanang", t = { "za zan\n", "zang" } },
      { d = "lssp_three_zaieiao", t = { "zai zei\n", "zao" } },
      { d = "lssp_three_ziouong", t = { "zi zou\n", "zong" } },
      { d = "lssp_three_zeeneng", t = { "ze zen\n", "zeng" } },
      { d = "lssp_three_zuouiu",  t = { "zuo zui\n", "zu" } }
    },
    {
      { d = "lssp_three_zhuauanuang", t = { "zhua|uan\n", "zhuang" } },
      { d = "lssp_three_zhuaiui",     t = { "zhuai\n", "zhui" } },
      { d = "lssp_three_zhuou",       t = { "zhuo\n", "zhu" } },
      { d = "lssp_three_zhun",        t = "zhun" },
      { d = "lssp_three_zun",         t = "zun" }
    }
  }
}

-- ========== 生成全部键盘 ==========

local result = {}
for n, e in pairs(SECOND_CODE_DATA) do
  result["lssp_two_" .. n] = make_second_code(n, e)
end

return result
