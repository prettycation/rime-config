local toolbar = toolbar {
  button_font = { "LXGWWenKaiGB-Medium.ttf" },
  back_style = "ic@chevron-triple-left",
  primary_button = {
    action = "KeyboardSettings",
    background = {
      type = "circle",
      corner_radius = 10,
      highlight = "hilited_candidate_button_color",
      normal = "none",
      vertical_inset = 4,
      horizontal_inset = 0
    },
    foreground = {
      font_size = 18,
      padding = 2,
      normal = "text_color",
      style = "ic@cogs"
    }
  },
  buttons = {
    {
      action = "HideKeyboard",
      foreground = {
        font_size = 18,
        padding = 2,
        normal = "text_color",
        style = "ic@keyboard-close"
      }
    },
    {
      action = "VoiceSwitch",
      foreground = {
        font_size = 18,
        padding = 2,
        normal = "text_color",
        option_styles = { "ic@microphone", "ic@stop-circle" }
      }
    },
    {
      action = "LiquidHistory",
      foreground = {
        font_size = 18,
        padding = 2,
        normal = "text_color",
        style = "ic@sticker-emoji"
      }
    },
    {
      action = "WindowClipboard",
      foreground = {
        font_size = 18,
        padding = 2,
        normal = "text_color",
        style = "ic@clipboard-list-outline"
      }
    },
    {
      action = "KeyboardEditor",
      foreground = {
        font_size = 18,
        padding = 2,
        normal = "text_color",
        style = "ic@cursor-move"
      }
    },
    {
      action = "Redo",
      foreground = {
        font_size = 18,
        padding = 2,
        normal = "text_color",
        style = "ic@rotate-right"
      }
    },
    {
      action = "Undo",
      foreground = {
        font_size = 18,
        padding = 2,
        normal = "text_color",
        style = "ic@rotate-left"
      }
    },
    {
      action = "FloatingSwitch",
      foreground = {
        font_size = 18,
        padding = 2,
        normal = "text_color",
        option_styles = { "ic@dock-window", "ic@keyboard-outline" }
      }
    },
    {
      action = "OneHandSwitch",
      foreground = {
        font_size = 18,
        padding = 2,
        normal = "text_color",
        style = "ic@keyboard-variant"
      }
    }
  }
}

return toolbar
