local function rule(name, match, options)
    options = options or {}
    options.name = name
    options.match = match
    hl.window_rule(options)
end

rule("utility-windows-tiled", { class = "^(gnome-control-center|pavucontrol|nm-connection-editor)$" }, {
    float = false,
    size = { "50%", "100%" },
})
rule("utility-windows-floating", { class = "^(gnome-calculator|galculator|blueman-manager|thunar|xdg-desktop-portal)$" }, { float = true })
rule("web-workspace-programs", { class = "^(helium)$" }, { workspace = "1" })
rule("coding-workspace-programs", { class = "^(codium|dev.zed.Zed|jetbrains-rider)$" }, { workspace = "2" })
rule("chat-workspace-programs", { class = "^(vesktop)$" }, { workspace = "3" })
rule("games-workspace-programs", { class = "^(steam)$" }, { workspace = "4" })
rule("jetbrains-toolbox-position", { class = "^jetbrains-toolbox$" }, { float = true, move = "monitor_w-10-w 10" })
rule("steam-notification-toast", { class = "^steam$", title = "^notificationtoasts_[0-9]+_desktop$" }, {
    move = "monitor_w-10-w monitor_h-10-h",
    no_focus = true,
})
rule("picture-in-picture", { class = "^(zen|firefox|helium)$", title = "^Picture-in-Picture$" }, { float = true })
rule("picture-in-picture-alt", { class = "^$", title = "^Picture in picture$" }, { float = true })
rule("zoom-floating", { class = "^zoom$" }, { float = true })
rule("jetbrains-rider-focused", { class = "^jetbrains-rider$" }, { no_initial_focus = false })
rule("fastfetch-floating", { class = "^fastfetch$" }, { float = true, size = { 900, 480 } })
rule("chatterino-size", { class = "^com\\.chatterino\\.chatterino$" }, { size = { 400, "100%" } })
rule("chatterino-settings", { class = "^com\\.chatterino\\.chatterino$", title = "^Chatterino Settings$" }, {
    float = true,
    size = { 900, 480 },
})
rule("password-manager-no-screen-share", { class = "^(bitwarden|org\\.gnome\\.World\\.Secrets)$" }, { no_screen_share = true })
rule("suppress-maximize-events", { class = ".*" }, { suppress_event = "maximize" })
rule("fix-xwayland-drags", {
    class = "^$",
    title = "^$",
    xwayland = true,
    float = true,
    fullscreen = false,
    pin = false,
}, { no_focus = true })
rule("move-hyprland-run", { class = "hyprland-run" }, { move = "20 monitor_h-120", float = true })

hl.window_rule({
    match = { class = "dev.noctalia.Noctalia" },
    float = true,
    size = { 1080, 920 },
})
hl.window_rule({ match = { class = "thunar" }, size = { 1080, 920 } })
rule("steam-floating-windows", {
    class = "^steam$",
    title = "^(Friends List|Steam Settings|Steam Guard|Screenshot Uploader|Special Offers|Gamepad-UI)$",
}, { float = true, center = true })

hl.layer_rule({
    name = "noctalia",
    match = { namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd|window-switcher)$" },
    no_anim = true,
    ignore_alpha = 0.5,
    blur = true,
    blur_popups = true,
})
