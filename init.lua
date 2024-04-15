-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

local keys = {}
local function mergeKeyMapToKeyMap(keymaps)
  for k,v in pairs(keymaps) do keys[k] = v end
end

config.default_prog = { 'C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe' }

config.font = wezterm.font '0xProto Nerd Font'
config.color_scheme = 'OneHalfDark'
config.window_close_confirmation = 'NeverPrompt'

local act = wezterm.action

local workspace = dofile(wezterm.config_dir .. "/wezterm-config/workspace.lua")

mergeKeyMapToKeyMap(
  workspace.keys
)


mergeKeyMapToKeyMap(
  {
    {
      key = '9',
      mods = 'ALT',
      action = act.ShowLauncherArgs {
        flags = 'FUZZY|WORKSPACES',
      },
    },
    {
      key = '0',
      mods = 'ALT',
      action = act.SwitchToWorkspace {
        name = 'default',
      },
    },
    {
      key = 's',
      mods = 'ALT',
      action = act.SplitHorizontal {domain = "CurrentPaneDomain"}
    },
    {
      key = 'S',
      mods = 'ALT',
      action = act.SplitVertical {domain = "CurrentPaneDomain"}
    },
  }
)

-- timeout_milliseconds defaults to 1000 and can be omitted
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }

config.keys = keys
return config

