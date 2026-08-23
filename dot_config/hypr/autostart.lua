-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
hl.on("hyprland.start", function ()
    hl.exec_cmd("noctalia")
    hl.exec_cmd("bash -c wl-paste --watch cliphist store")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
end)
