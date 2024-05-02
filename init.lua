local wezterm = require 'wezterm'
local mux = wezterm.mux;

local config = wezterm.config_builder()

local keyMappings = {} -- keyMappings bindings table

local function mergeKeyMapToKeyMap(keymaps) -- Merge keymaps to the keyMappings bindings table
  for key,value in pairs(keymaps) do keyMappings[key] = value end
end

local function mergeConfig(partialConfig)
  for key,value in pairs(partialConfig) do config[key] = value end
end

local myConfig = dofile(wezterm.config_dir .. "/wezterm-config/wezterm-config.lua")

local act = wezterm.action

mergeConfig(myConfig)

local configs = {
  personalWindow="personalWindow",
  ubuntu="ubuntu",
  work="work",
  mac="mac",
}

local windowNvimPath = "C:\\Users\\Dannick.bedard\\AppData\\Local\\nvim"
local windowWeztermPath = "C:\\Users\\Dannick.bedard\\wezterm-config"
local windowNotesPath = "C:\\Users\\Dannick.bedard\\Documents\\Notes"

local settings = {
  currentConfig = configs.work, -- À changer selon l'ordinateur utilisé
  workspaceProject = {
    work = {
      project1 = {
        path = "/viridem",
        projectName = "Viridem",
      },
      project2 = {
        path = "/viridem/api",
        projectName = "Viridem-api",
      },
      project6 = {
        path = windowNotesPath,
        projectName = "Notes obsidian"
      },
      project7 = {
        path = windowWeztermPath,
        projectName = "WeztermConfig"
      },
      project8 = {
        path = windowNvimPath,
        projectName = "NvimConfig"
      }
    },
    personalWindow = {
      project7 = {
        path = windowWeztermPath,
        projectName = "WeztermConfig"
      },
      project8 = {
        path = windowNvimPath,
        projectName = "NvimConfig"
      }
    },
    ubuntu = {
      project8 = {
        path = "~/.config/nvim",
        projectName = "NvimConfig"
      }
    },
    mac = {
      project8 = {
        path = "~/.config/nvim",
        projectName = "NvimConfig"
      }
    },
  }
}

-- Function to check if a session exists
local function sessionExists(name)

  local workspace = mux.get_active_workspace()
 wezterm.log_warn(workspace);
 wezterm.log_warn(mux.get_workspace_names())
  local workspaceNames = mux.get_workspace_names()

  for index in ipairs(mux.get_workspace_names()) do
    wezterm.log_warn(workspaceNames[index]);
    if workspaceNames[index] == name then
      wezterm.log_warn("return true");
      return true
    end
  end
  wezterm.log_warn("return false");
  return false
end

local lunchWorkSpace = function(window,pane,sessionName, path)
    wezterm.log_warn("Ol session");
    window:perform_action(
      act.SwitchToWorkspace {
        name = sessionName,
        spawn = {
          cwd = path,
          args = { 'nvim', '.' },
        },
      },
      pane
    )
  -- Check to open another tab if not on first workspace creation
  -- TODO :: Check if workspace exist
  -- if false : create workspace + add tab and split
  -- if true : juste switch to workspace 
end

local getWorkspaceProject = function ()
   -- Check if settings.currentConfig exists in configs table
  if configs[settings.currentConfig] then
    -- Get the corresponding currentConfig table from settings.workspaceProject
    local workspaceTable = settings.workspaceProject[settings.currentConfig]
    return workspaceTable
  else
    -- If currentConfig is not found, return nil
    return nil
  end
end

local lunchWorkSpaceByProject = function(window, pane, project)
  print("test");
  print(project)
  local projects = getWorkspaceProject()

  if projects then
    lunchWorkSpace(window, pane, projects[project].projectName,projects[project].path)
  else
    window:perform_action(
      act.SwitchToWorkspace {
        name = 'default',
      },
      pane
    )
  end
end


wezterm.on('lunchWorkSpace1', function(window, pane)
  lunchWorkSpaceByProject(window,pane, "project1");
end)
wezterm.on('lunchWorkSpace2', function(window, pane)
  lunchWorkSpaceByProject(window,pane, "project2");
end)
wezterm.on('lunchWorkSpace3', function(window, pane)
  lunchWorkSpaceByProject(window,pane, "project3");
end)
wezterm.on('lunchWorkSpace4', function(window, pane)
  lunchWorkSpaceByProject(window,pane, "project4");
end)
wezterm.on('lunchWorkSpace5', function(window, pane)
  lunchWorkSpaceByProject(window,pane, "project5");
end)
wezterm.on('lunchWorkSpace6', function(window, pane)
  lunchWorkSpaceByProject(window,pane, "project6");
end)
wezterm.on('lunchWorkSpace7', function(window, pane)
  lunchWorkSpaceByProject(window,pane, "project7");
end)
wezterm.on('lunchWorkSpace8', function(window, pane)
  lunchWorkSpaceByProject(window,pane, "project8");
end)
mergeKeyMapToKeyMap(
  {
  }
)

-- Default keymaps
mergeKeyMapToKeyMap(
  {
  }
)

config.keys = {

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

    -- Switch to the default workspace
    -- Create a new workspace with a random name and switch to it
    { key = 'i', mods = 'CTRL|SHIFT', action = act.SwitchToWorkspace },
    -- Show the launcher in fuzzy selection mode and have it list all workspaces
    -- and allow activating one.
    {
      key = '1',
      mods = 'ALT',
      action = act.EmitEvent 'lunchWorkSpace1'
    },
    {
      key = '2',
      mods = 'ALT',
      action = act.EmitEvent 'lunchWorkSpace2'
    },
    {
      key = '3',
      mods = 'ALT',
      action = act.EmitEvent 'lunchWorkSpace3'
    },
    {
      key = '4',
      mods = 'ALT',
      action = act.EmitEvent 'lunchWorkSpace4'
    },
    {
      key = '5',
      mods = 'ALT',
      action = act.EmitEvent 'lunchWorkSpace5'
    },
    {
      key = '6',
      mods = 'ALT',
      action = act.EmitEvent 'lunchWorkSpace6'
    },
    {
      key = '7',
      mods = 'ALT',
      action = act.EmitEvent 'lunchWorkSpace7'
    },
    {
      key = '8',
      mods = 'ALT',
      action = act.EmitEvent 'lunchWorkSpace8'
    },
    {
      key = 'W',
      mods = 'CTRL|SHIFT',
      action = act.PromptInputLine {
        description = wezterm.format {
          { Attribute = { Intensity = 'Bold' } },
          { Foreground = { AnsiColor = 'Fuchsia' } },
          { Text = 'Enter name for new workspace' },
        },
        action = wezterm.action_callback(function(window, pane, line)
          -- line will be `nil` if they hit escape without entering anything
          -- An empty string if they just hit enter
          -- Or the actual line of text they wrote
          if line then
            window:perform_action(
              act.SwitchToWorkspace {
                name = line,
              },
              pane
            )
          end
        end),
      },
    },
}
return config
