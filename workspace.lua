
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
end
