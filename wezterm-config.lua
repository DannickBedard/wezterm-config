local wezterm = require 'wezterm'

return {
  default_prog = { 'C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe' },

  font = wezterm.font '0xProto Nerd Font',
  color_scheme = 'OneHalfDark',
  window_close_confirmation = 'NeverPrompt',

  -- timeout_milliseconds defaults to 1000 and can be omitted
  leader = { key = 'A', mods = 'CTRL', timeout_milliseconds = 1000 },
  audible_bell = "Disabled"

}
