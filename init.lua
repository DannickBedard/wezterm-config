local wezterm = require 'wezterm'

local config = wezterm.config_builder()

local keyMappings = {} -- keyMappings bindings table

local function mergeKeyMapToKeyMap(keymaps) -- Merge keymaps to the keyMappings bindings table
  for key,value in pairs(keymaps) do keyMappings[key] = value end
end

local function mergeConfig(partialConfig)
  for key,value in pairs(partialConfig) do config[key] = value end
end

local myConfig = dofile(wezterm.config_dir .. "/wezterm-config/wezterm-config.lua")
local workspace = dofile(wezterm.config_dir .. "/wezterm-config/workspace.lua")

local act = wezterm.action

mergeConfig(myConfig)

mergeKeyMapToKeyMap(
  workspace.keys
)

-- Default keymaps
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

config.keys = keyMappings
return config
