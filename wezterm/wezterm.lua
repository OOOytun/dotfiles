-- Pull in the wezterm API
local wezterm = require("wezterm")

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
config.font_size = 16

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

config.window_decorations = "RESIZE"
config.window_background_opacity = 0.8
config.macos_window_background_blur = 10

-- Dim inactive panes to make active pane more visible
config.inactive_pane_hsb = {
    hue = 1,
    saturation = 1,
    brightness = 0.6,
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
    {key = "z", mods = "SUPER", action = wezterm.action.TogglePaneZoomState},

    -- Clear terminal
    {key = "k", mods = "SUPER", action = wezterm.action{SendString = "clear\n"}},

    -- Jump to end of line
    {key = "RightArrow", mods = "SUPER", action = wezterm.action.SendKey{key = "e", mods = "CTRL"}},

    -- Jump to beginning of line
    {key = "LeftArrow", mods = "SUPER", action = wezterm.action.SendKey{key = "a", mods = "CTRL"}},

    -- Additional keybindings
    {key="Enter", mods="SHIFT", action=wezterm.action{SendString="\x1b\r"}},
    {key="Backspace", mods="SUPER", action=wezterm.action.SendKey{key="u", mods="CTRL"}},
}

-- and finally, return the configuration to wezterm
return config
