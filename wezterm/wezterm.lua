-- Pull in the wezterm API
local wezterm = require("wezterm")

-- Toggle font size between 12 and 14
wezterm.on('toggle-font-size', function(window, pane)
  local overrides = window:get_config_overrides() or {}
  if overrides.font_size == nil or overrides.font_size == 14 then
    overrides.font_size = 12
  else
    overrides.font_size = 14
  end
  window:set_config_overrides(overrides)
end)

-- Tab bar colors for focused window
local focused_tab_bar = {
    background = "rgba(1, 20, 35, 0.8)",
    active_tab = {
        bg_color = "rgba(1, 20, 35, 0.8)",
        fg_color = "#0FC5ED",
        intensity = "Bold",
    },
    inactive_tab = {
        bg_color = "rgba(1, 20, 35, 0.8)",
        fg_color = "#214969",
    },
    inactive_tab_hover = {
        bg_color = "rgba(1, 20, 35, 0.8)",
        fg_color = "#CBE0F0",
    },
    new_tab = {
        bg_color = "rgba(1, 20, 35, 0.8)",
        fg_color = "#214969",
    },
    new_tab_hover = {
        bg_color = "rgba(1, 20, 35, 0.8)",
        fg_color = "#47FF9C",
    },
}

-- Tab bar colors for unfocused window (dimmed 60% like inactive panes)
local unfocused_tab_bar = {
    background = "rgba(1, 20, 35, 0.5)",
    active_tab = {
        bg_color = "rgba(1, 20, 35, 0.5)",
        fg_color = "#0975A8",
        intensity = "Normal",
    },
    inactive_tab = {
        bg_color = "rgba(1, 20, 35, 0.5)",
        fg_color = "#142C3F",
    },
    inactive_tab_hover = {
        bg_color = "rgba(1, 20, 35, 0.5)",
        fg_color = "#798690",
    },
    new_tab = {
        bg_color = "rgba(1, 20, 35, 0.5)",
        fg_color = "#142C3F",
    },
    new_tab_hover = {
        bg_color = "rgba(1, 20, 35, 0.5)",
        fg_color = "#2B9F5D",
    },
}

-- Dim tab bar when window loses focus
wezterm.on('window-focus-changed', function(window, pane)
  local overrides = window:get_config_overrides() or {}

  -- Initialize colors if not present (preserve terminal colors)
  if not overrides.colors then
    overrides.colors = {
      foreground = "#CBE0F0",
      background = "#011423",
      cursor_bg = "#47FF9C",
      cursor_border = "#47FF9C",
      cursor_fg = "#011423",
      selection_bg = "#033259",
      selection_fg = "#CBE0F0",
      ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
      brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
    }
  end

  -- Update ONLY tab_bar (not entire colors)
  if window:is_focused() then
    overrides.colors.tab_bar = focused_tab_bar
  else
    overrides.colors.tab_bar = unfocused_tab_bar
  end

  window:set_config_overrides(overrides)
end)

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.colors = {
    foreground = "#CBE0F0",
    background = "#011423",
    cursor_bg = "#47FF9C",
    cursor_border = "#47FF9C",
    cursor_fg = "#011423",
    selection_bg = "#033259",
    selection_fg = "#CBE0F0",
    ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
    brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
}

config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size = 14

config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
config.hide_tab_bar_if_only_one_tab = false

-- Terminal-style tab bar colors
config.colors.tab_bar = {
    background = "rgba(1, 20, 35, 0.8)",
    active_tab = {
        bg_color = "rgba(1, 20, 35, 0.8)",
        fg_color = "#0FC5ED",
        intensity = "Bold",
    },
    inactive_tab = {
        bg_color = "rgba(1, 20, 35, 0.8)",
        fg_color = "#214969",
    },
    inactive_tab_hover = {
        bg_color = "rgba(1, 20, 35, 0.8)",
        fg_color = "#CBE0F0",
    },
    new_tab = {
        bg_color = "rgba(1, 20, 35, 0.8)",
        fg_color = "#214969",
    },
    new_tab_hover = {
        bg_color = "rgba(1, 20, 35, 0.8)",
        fg_color = "#47FF9C",
    },
}

-- Hide workspace status on right side of tab bar
wezterm.on('update-status', function(window, pane)
  window:set_right_status('')
end)

config.window_decorations = "TITLE|RESIZE"
config.window_background_opacity = 0.9
config.macos_window_background_blur = 40

-- Dim inactive panes to make active pane more visible
config.inactive_pane_hsb = {
    hue = 1,
    saturation = 0.75,
    brightness = 0.8,
}

-- ---- Keybindings ----
config.keys = {
    -- Split panes
    {key = "RightArrow", mods = "SUPER|SHIFT", action = wezterm.action{SplitPane = {direction = "Right"}}},
    {key = "DownArrow", mods = "SUPER|SHIFT", action = wezterm.action{SplitPane = {direction = "Down"}}},
    {key = "LeftArrow", mods = "SUPER|SHIFT", action = wezterm.action{SplitPane = {direction = "Left"}}},
    {key = "UpArrow", mods = "SUPER|SHIFT", action = wezterm.action{SplitPane = {direction = "Up"}}},

    -- Navigate between panes
    {key = "RightArrow", mods = "SUPER|ALT", action = wezterm.action{ActivatePaneDirection = "Right"}},
    {key = "DownArrow", mods = "SUPER|ALT", action = wezterm.action{ActivatePaneDirection = "Down"}},
    {key = "LeftArrow", mods = "SUPER|ALT", action = wezterm.action{ActivatePaneDirection = "Left"}},
    {key = "UpArrow", mods = "SUPER|ALT", action = wezterm.action{ActivatePaneDirection = "Up"}},

    -- Navigate between panes with Ctrl
    {key = "RightArrow", mods = "CTRL", action = wezterm.action{ActivatePaneDirection = "Right"}},
    {key = "DownArrow", mods = "CTRL", action = wezterm.action{ActivatePaneDirection = "Down"}},
    {key = "LeftArrow", mods = "CTRL", action = wezterm.action{ActivatePaneDirection = "Left"}},
    {key = "UpArrow", mods = "CTRL", action = wezterm.action{ActivatePaneDirection = "Up"}},

    -- Close pane
    {key = "w", mods = "SUPER|SHIFT", action = wezterm.action{CloseCurrentPane = {confirm = true}}},

    -- Toggle pane zoom
    {key = "z", mods = "SUPER|SHIFT", action = wezterm.action.TogglePaneZoomState},

    -- Undo in shell (sends Ctrl+_)
    {key = "z", mods = "SUPER", action = wezterm.action.SendKey{key = "_", mods = "CTRL"}},

    -- Clear terminal
    {key = "k", mods = "SUPER", action = wezterm.action.ClearScrollback('ScrollbackAndViewport')},

    -- Jump to end of line
    {key = "RightArrow", mods = "SUPER", action = wezterm.action.SendKey{key = "e", mods = "CTRL"}},

    -- Jump to beginning of line
    {key = "LeftArrow", mods = "SUPER", action = wezterm.action.SendKey{key = "a", mods = "CTRL"}},

    -- Additional keybindings
    {key="Enter", mods="SHIFT", action=wezterm.action{SendString="\x1b\r"}},
    {key="Backspace", mods="SUPER", action=wezterm.action.SendKey{key="u", mods="CTRL"}},

    -- Toggle full screen for the window
    {key = "Enter", mods = "SUPER|CTRL", action = wezterm.action.ToggleFullScreen},

    -- Toggle font size between 12 and 14
    {key = "f", mods = "SUPER|SHIFT", action = wezterm.action.EmitEvent('toggle-font-size')},
}

-- and finally, return the configuration to wezterm
return config
