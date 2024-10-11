local wezterm = require 'wezterm'

-- The filled in variant of the < symbol
local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider

-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider



return {
  -- default_prog = { 'C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe' },
  default_prog = { 'C:\\Program Files\\Git\\bin\\bash.exe' },

  font = wezterm.font '0xProto Nerd Font',
  color_scheme = 'OneHalfDark',
  window_close_confirmation = 'NeverPrompt',
  use_fancy_tab_bar = false,
  tab_bar_at_bottom  = true,
  window_padding = {
    left = 1,
    right = 1,
    top = 0,
    bottom = 0,
  },
  window_decorations = "INTEGRATED_BUTTONS|RESIZE",
  tab_bar_style = {
    window_hide = " minimize ",
    window_maximize = " maximize ",
    window_close = " close ",

    window_close_hover = " CLOSE ",
    window_hide_hover = " MINIMIZE ",
    window_maximize_hover = " MAXIMIZE ",
  },


  -- timeout_milliseconds defaults to 1000 and can be omitted
  leader = { key = 'A', mods = 'CTRL', timeout_milliseconds = 1000 },
  audible_bell = "Disabled",
  skip_close_confirmation_for_processes_named = {
    'bash',
    'sh',
    'zsh',
    'fish',
    'tmux',
    'nu',
    'cmd.exe',
    'pwsh.exe',
    'powershell.exe',
  }
}
