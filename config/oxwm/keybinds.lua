---@module 'oxwm'

-- Keybindings are defined using oxwm.key.bind(modifiers, key, action)
-- Modifiers: {"Mod4"}, {"Mod1"}, {"Shift"}, {"Control"}, or combinations like {"Mod4", "Shift"}
-- Keys: Use uppercase for letters (e.g., "Return", "H", "J", "K", "L")
-- Actions: Functions that return actions (e.g., oxwm.spawn(), oxwm.client.kill())
--
-- A list of available keysyms can be found in the X11 keysym definitions.
-- Common keys: Return, Space, Tab, Escape, Backspace, Delete, Left, Right, Up, Down

local modkey1 = "Mod4"
local modkey2 = "Mod1"

oxwm.key.bind({ modkey1, "Shift" }, "6", oxwm.spawn({ "pactl", "set-sink-volume", "0", "+10%" }))
oxwm.key.bind({ modkey1, "Shift" }, "5", oxwm.spawn({ "pactl", "set-sink-volume", "0", "-10%" }))
oxwm.key.bind({ modkey1, "Shift" }, "3", oxwm.spawn({ "pactl", "set-sink-mute", "0", "toggle" }))

oxwm.key.bind({ modkey1, "Shift" }, "9", oxwm.spawn({ "brightnessctl", "set", "+5%" }))
oxwm.key.bind({ modkey1, "Shift" }, "8", oxwm.spawn({ "brightnessctl", "set", "5%-" }))

oxwm.key.bind({ modkey2 }, "L", oxwm.spawn("xsecurelock"))

oxwm.key.bind({ modkey1 }, "V", oxwm.spawn("clipcat-menu"))

oxwm.key.bind({ modkey1 }, "Return", oxwm.spawn_terminal())
oxwm.key.bind({ modkey1 }, "Space", oxwm.spawn({ "sh", "-c", "j4-dmenu-desktop" }))
oxwm.key.bind({ modkey1 }, "E", oxwm.spawn("thunar"))

-- Launch Dmenu
oxwm.key.bind({ modkey1 }, "D", oxwm.spawn({ "sh", "-c", "dmenu_run -l 10" }))
-- Copy screenshot to clipboard
oxwm.key.bind(
	{ modkey1, "Shift" },
	"S",
	oxwm.spawn({ "sh", "-c", "maim -s | xclip -selection clipboard -t image/png" })
)
oxwm.key.bind({ modkey1 }, "Q", oxwm.client.kill())

-- Keybind overlay - Shows important keybindings on screen
oxwm.key.bind({ modkey1, "Shift" }, "Slash", oxwm.show_keybinds())

-- Window state toggles
oxwm.key.bind({ modkey1, "Shift" }, "F", oxwm.client.toggle_fullscreen())
oxwm.key.bind({ modkey1 }, "S", oxwm.client.toggle_floating())

-- Layout management
oxwm.key.bind({ modkey1 }, "F", oxwm.layout.set("normie"))
oxwm.key.bind({ modkey1 }, "C", oxwm.layout.set("tiling"))
-- Cycle through layouts
oxwm.key.bind({ modkey1 }, "N", oxwm.layout.cycle())

-- Master area controls (tiling layout)

-- Decrease/Increase master area width
oxwm.key.bind({ modkey1 }, "H", oxwm.set_master_factor(-5))
oxwm.key.bind({ modkey1 }, "L", oxwm.set_master_factor(5))
-- Increment/Decrement number of master windows
oxwm.key.bind({ modkey1 }, "I", oxwm.inc_num_master(1))
oxwm.key.bind({ modkey1 }, "P", oxwm.inc_num_master(-1))

-- Gaps toggle
oxwm.key.bind({ modkey1 }, "A", oxwm.toggle_gaps())

-- Window manager controls
oxwm.key.bind({ modkey1, "Shift" }, "Q", oxwm.quit())
oxwm.key.bind({ modkey1, "Shift" }, "R", oxwm.restart())

-- Focus movement [1 for up in the stack, -1 for down]
oxwm.key.bind({ modkey1 }, "J", oxwm.client.focus_stack(1))
oxwm.key.bind({ modkey1 }, "K", oxwm.client.focus_stack(-1))

-- Window movement (swap position in stack)
oxwm.key.bind({ modkey1, "Shift" }, "J", oxwm.client.move_stack(1))
oxwm.key.bind({ modkey1, "Shift" }, "K", oxwm.client.move_stack(-1))

-- Multi-monitor support

-- Focus next/previous Monitors
oxwm.key.bind({ modkey1 }, "Comma", oxwm.monitor.focus(-1))
oxwm.key.bind({ modkey1 }, "Period", oxwm.monitor.focus(1))
-- Move window to next/previous Monitors
oxwm.key.bind({ modkey1, "Shift" }, "Comma", oxwm.monitor.tag(-1))
oxwm.key.bind({ modkey1, "Shift" }, "Period", oxwm.monitor.tag(1))

-- Workspace (tag) navigation
for i = 0, 8 do
	-- Switch to workspace N (tags are 0-indexed, so tag "1" is index 0)
	oxwm.key.bind({ modkey1 }, "" .. i + 1, oxwm.tag.view(i))

	-- Move focused window to workspace N
	oxwm.key.bind({ modkey2 }, "" .. i + 1, oxwm.tag.move_to(i))

	-- Combo view (view multiple tags at once) {argos_nothing}
	-- Example: Mod+Ctrl+2 while on tag 1 will show BOTH tags 1 and 2
	oxwm.key.bind({ modkey1, "Control" }, "" .. i + 1, oxwm.tag.toggleview(i))

	-- Multi tag (window on multiple tags)
	-- Example: Mod+Ctrl+Shift+2 puts focused window on BOTH current tag and tag 2
	oxwm.key.bind({ modkey1, "Control", "Shift" }, "" .. i + 1, oxwm.tag.toggletag(i))
end

-- Keychords allow you to bind multiple-key sequences (like Emacs or Vim)
-- Format: {{modifiers}, key1}, {{modifiers}, key2}, ...
-- Example: Press Mod4+Space, then release and press T to spawn a terminal
-- oxwm.key.chord({
-- 	{ { modkey }, "Space" },
-- 	{ {}, "T" },
-- }, oxwm.spawn_terminal())
