---@module 'oxwm'

require("window_rules")
require("keybinds")

local colors = require("themes").default
local blocks = require("bar")

require("window_rules")
require("keybinds")

-- Modifier key: "Mod4" is the Super/Windows key, "Mod1" is Alt
local modkey = "Mod4"

-- Terminal emulator command (defaults to alacritty)
local terminal = "alacritty"

-- Workspace tags - can be numbers, names, or icons (requires a Nerd Font)
local tags = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }
-- local tags = { "", "󰊯", "", "", "󰙯", "󱇤", "", "󱘶", "󰧮" } -- Example of nerd font icon tags

-- Font for the status bar (use "fc-list" to see available fonts)
-- local bar_font = "monospace:style=Bold:size=18"
local bar_font = "ZedMono Nerd Font,ZedMono NF:style=Regular:size=13"

oxwm.set_terminal(terminal)
oxwm.set_modkey(modkey) -- This is for Mod + mouse binds, such as drag/resize
oxwm.set_tags(tags)

-- Set custom symbols for layouts (displayed in the status bar)
-- Available layouts: "tiling", "normie" (floating), "grid", "monocle", "tabbed"
oxwm.set_layout_symbol("tiling", "[T]")
oxwm.set_layout_symbol("normie", "[F]")
oxwm.set_layout_symbol("tabbed", "[=]")

-- Width in pixels
oxwm.border.set_width(1)
-- Color of focused window border
oxwm.border.set_focused_color(colors.blue)
-- Color of unfocused window borders
oxwm.border.set_unfocused_color(colors.grey)

-- Smart Enabled = No border if 1 window
oxwm.gaps.set_smart(true)
-- Inner gaps (horizontal, vertical) in pixels
oxwm.gaps.set_inner(5, 5)
-- Outer gaps (horizontal, vertical) in pixels
oxwm.gaps.set_outer(5, 5)

-- Font configuration
oxwm.bar.set_font(bar_font)
-- Set your blocks here (defined above)
oxwm.bar.set_blocks(blocks)

-- Bar color schemes (for workspace tag display)
-- Parameters: foreground, background, border
-- Unoccupied tags
oxwm.bar.set_scheme_normal(colors.fg, colors.bg, "#444444")
-- Occupied tags
oxwm.bar.set_scheme_occupied(colors.cyan, colors.bg, colors.cyan)
-- Currently selected tag
oxwm.bar.set_scheme_selected(colors.cyan, colors.bg, colors.purple)
-- Urgent tags (windows requesting attention)
oxwm.bar.set_scheme_urgent(colors.red, colors.bg, colors.red)

-- Hide tags that have no windows and are not selected
-- oxwm.bar.set_hide_vacant_tags(true)

-- Commands to run once when OXWM starts
-- Uncomment and modify these examples, or add your own
oxwm.autostart("picom")
oxwm.autostart("feh --bg-fill ~/.wallpaper.jpg")
oxwm.autostart("dunst")
oxwm.autostart("clipcatd")
oxwm.autostart("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
