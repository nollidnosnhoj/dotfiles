-- Hyprland configuration entrypoint.
-- Each section lives in its own module so it can be changed independently.

require("monitors")
local programs = require("programs")
require("autostart")
require("environment")
require("permissions")
require("look-and-feel")
require("misc")
require("input")
require("keybindings")(programs)
require("window-rules")
