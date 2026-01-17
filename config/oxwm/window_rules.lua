---@module 'oxwm'
-------------------------------------------------------------------------------
-- Window Rules
-------------------------------------------------------------------------------
-- Rules allow you to automatically configure windows based on their properties
-- You can match windows by class, instance, title, or role
-- Available properties: floating, tag, fullscreen, etc.
--
-- Common use cases:
-- - Force floating for certain applications (dialogs, utilities)
-- - Send specific applications to specific workspaces
-- - Configure window behavior based on title or class

-- oxwm.rule.add({ class = "Alacritty", tag = 9, focus = true })
-- oxwm.rule.add({ class = "firefox", title = "Library", floating = true })
-- oxwm.rule.add({ class = "firefox", tag = 2 })
-- oxwm.rule.add({ instance = "mpv", floating = true })

-- To find window properties, use xprop and click on the window
-- WM_CLASS(STRING) shows both instance and class (instance, class)
