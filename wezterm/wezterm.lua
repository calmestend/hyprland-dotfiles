local wezterm = require("wezterm")
local act = wezterm.action

local config = {}

if wezterm.config_builder then config = wezterm.config_builder() end

-- Font Settings
config.font = wezterm.font_with_fallback({
	{ family = "Liga SFMono Nerd Font", scale = 1.2, weight = "Regular" }
})

-- General Settings
config.enable_wayland = false

-- Appearance Settings
config.color_scheme = 'Kanagawa (Gogh)'
config.window_background_opacity = 0.8
config.window_padding = {
	left = 28,
	right = 28,
	top = 26,
	bottom = 26,
}
--
-- Bar Settings
config.show_tab_index_in_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.use_fancy_tab_bar = false
config.enable_tab_bar = false

-- Zen mode
wezterm.on('user-var-changed', function(window, pane, name, value)
    local overrides = window:get_config_overrides() or {}
    if name == "ZEN_MODE" then
        local incremental = value:find("+")
        local number_value = tonumber(value)
        if incremental ~= nil then
            while (number_value > 0) do
                window:perform_action(wezterm.action.IncreaseFontSize, pane)
                number_value = number_value - 1
            end
            overrides.enable_tab_bar = false
        elseif number_value < 0 then
            window:perform_action(wezterm.action.ResetFontSize, pane)
            overrides.font_size = nil
            overrides.enable_tab_bar = true
        else
            overrides.font_size = number_value
            overrides.enable_tab_bar = false
        end
    end
    window:set_config_overrides(overrides)
end)

return config

