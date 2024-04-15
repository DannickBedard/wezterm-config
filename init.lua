-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

local keys = {}
local function mergeKeyMapToKeyMap(keymaps)
  for k,v in pairs(keymaps) do keys[k] = v end
end

local workspaces = {
  personalWindow="personalWindow",
  ubuntu="ubuntu",
  work="work",
  mac="mac",
}

local settings = {
  workspace = workspaces.personalWindow, -- À changer selon l'ordinateur utilisé
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
      project7 = {
        path = "C:\\Users\\danni\\wezterm-config",
        projectName = "WeztermConfig"
      },
      project8 = {
        path = "C:\\Users\\danni\\AppData\\Local\\nvim",
        projectName = "NvimConfig"
      }
    },
    personalWindow = {
      project7 = {
        path = "C:\\Users\\danni\\wezterm-config",
        projectName = "WeztermConfig"
      },
      project8 = {
        path = "C:\\Users\\danni\\AppData\\Local\\nvim",
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

config.default_prog = { 'C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe' }
--config.default_prog = { 'pwsh.exe' }

config.font = wezterm.font '0xProto Nerd Font'
config.color_scheme = 'OneHalfDark'
config.window_close_confirmation = 'NeverPrompt'

local act = wezterm.action

wezterm.on('update-right-status', function(window, pane)
  window:set_right_status(window:active_workspace())
end)

local lunchWorkSpace = function(window,pane,sessionName, path)
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
-- Voir https://wezfurlong.org/wezterm/config/lua/keyassignment/Multiple.html
  --
  -- window:perform_action(
  --   act.SplitHorizontal { domain = 'CurrentPaneDomain' },
  --   pane
  -- )
  -- TODO :: J'aimerais mettre un %... 
  -- window:perform_action(
  --   act.AdjustPaneSize { 'Right', 15 },
  --   pane
  -- )
  -- window:perform_action(
  --   act.SpawnTab 'CurrentPaneDomain',
  --   pane
  -- )
  -- -- Ne marche pas car on à ajouter un nouveau pane... 
  -- window:perform_action(
  --   act.ActivatePaneByIndex(0),
  --   pane
  -- )
end

local getWorkspaceProject = function ()
   -- Check if settings.workspace exists in workspaces table
  if workspaces[settings.workspace] then
    -- Get the corresponding workspace table from settings.workspaceProject
    local workspaceTable = settings.workspaceProject[settings.workspace]
    -- Return the projects
    return workspaceTable
  else
    -- If workspace is not found, return nil
    return nil
  end
end

local lunchWorkSpaceByProject = function(window, pane, project)
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
    -- Switch to the default workspace
    -- Create a new workspace with a random name and switch to it
    { key = 'i', mods = 'CTRL|SHIFT', action = act.SwitchToWorkspace },
    -- Show the launcher in fuzzy selection mode and have it list all workspaces
    -- and allow activating one.
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
)


mergeKeyMapToKeyMap(
  {

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

