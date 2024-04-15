# wezterm-config

if not already done create the config file .wezterm.lua inside your home directory

- window
   C:Users\\userName\\.wezterm.lua

- ubuntu / macos
    /.wezterm.lua


To install this config git clone in the directory of the .wezterm.lua file. : git clone https://github.com/DannickBedard/wezterm-config.git 

then you can put this config into the .wezterm.lua

```lua
local wezterm = require 'wezterm'
local config = dofile(wezterm.config_dir .. "/wezterm-config/init.lua")
return config
```

# Configs
You can edit your config for wordspace inside the workspace file and change the currentConfig
