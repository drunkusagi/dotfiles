local colors = require("themes").default

return {
	oxwm.bar.block.ram({
		format = "  {used}/{total} GB",
		interval = 5,
		color = colors.light_blue,
		underline = true,
	}),
	oxwm.bar.block.static({
		text = " │  ",
		interval = 999999999,
		color = colors.lavender,
		underline = false,
	}),
	oxwm.bar.block.shell({
		format = "{}",
		command = "printf '%s@%s' $(whoami) $(cat /etc/hostname)",
		interval = 999999999,
		color = colors.red,
		underline = true,
	}),
	oxwm.bar.block.static({
		text = " │  ",
		interval = 999999999,
		color = colors.lavender,
		underline = false,
	}),
	oxwm.bar.block.datetime({
		format = "{}",
		date_format = "%a, %b %d - %-I:%M %P",
		interval = 1,
		color = colors.cyan,
		underline = true,
	}),
	oxwm.bar.block.static({
		text = " │  ",
		interval = 999999999,
		color = colors.lavender,
		underline = false,
	}),
	oxwm.bar.block.battery({
		format = "Bat: {}%",
		charging = "󰂄 {}%",
		discharging = "󱊣 {}%",
		full = "󱟢 {}%",
		interval = 30,
		color = colors.green,
		underline = true,
	}),
}
