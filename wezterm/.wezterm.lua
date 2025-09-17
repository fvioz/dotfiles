-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will be used later to construct key bindings
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Configuration options
config.color_scheme = "Bamboo"

config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size = 13

config.window_background_opacity = 0.9
config.macos_window_background_blur = 10

-- Keybindings
config.keys = {
    { mods = "OPT",     key = "LeftArrow",  action = act.SendKey({ mods = "ALT", key = "b" }) },
    { mods = "OPT",     key = "RightArrow", action = act.SendKey({ mods = "ALT", key = "f" }) },
    { mods = "CMD",     key = "LeftArrow",  action = act.SendKey({ mods = "CTRL", key = "a" }) },
    { mods = "CMD",     key = "RightArrow", action = act.SendKey({ mods = "CTRL", key = "e" }) },
    { mods = "CMD",     key = "Backspace",  action = act.SendKey({ mods = "CTRL", key = "u" }) },
    { mods = 'CMD|ALT', key = 'LeftArrow',  action = act.ActivateTabRelative(-1) },
    { mods = 'CMD|ALT', key = 'RightArrow', action = act.ActivateTabRelative(1) },
}

-- Use the defaults as a base
config.hyperlink_rules = wezterm.default_hyperlink_rules()

-- Make IP addresses with port clickable (e.g., 127.0.0.1:5053)
table.insert(config.hyperlink_rules, {
    regex = [[\b(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}):(\d+)\b]],
    format = 'http://$1:$2',
})

-- Match local file paths ending in .html
table.insert(config.hyperlink_rules, {
    regex = [[\b(?:[a-zA-Z0-9_-]+(?:/[a-zA-Z0-9_-]+)*)+\.html\b]],
    format = 'file://$0',
})

local bind = function(mods, key, action)
    table.insert(config.keys, {
        key = key,
        mods = mods,
        action = action,
    })
end

bind('CMD', 'k', act.Multiple {
    act.ClearScrollback 'ScrollbackAndViewport',
    act.SendKey { key = 'L', mods = 'CTRL' },
})

bind('CMD', ']', wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' })
bind('CMD', '\\', wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' })

local function toast(window, message)
    window:toast_notification('wezterm', message .. ' - ' .. os.date('%I:%M:%S %p'), nil, 1000)
end

wezterm.on('window-config-reloaded', function(window, _pane)
    toast(window, 'Configuration reloaded!')
end)

-- Finally, return the configuration to wezterm:
return config
