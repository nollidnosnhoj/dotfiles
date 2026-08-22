return function (programs)
    local mainMod = "SUPER"
    local noctaliaIpc = "noctalia msg "

    hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(programs.terminal))
    hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(programs.fileManager))
    hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(programs.browser))

    hl.bind(mainMod .. "+Space", hl.dsp.exec_cmd(noctaliaIpc .. "panel-toggle launcher"))
    hl.bind(mainMod .. "+S", hl.dsp.exec_cmd(noctaliaIpc .. "panel-toggle control-center"))
    hl.bind(mainMod .. "+comma", hl.dsp.exec_cmd(noctaliaIpc .. "settings-toggle"))
    hl.bind(mainMod .. "+X", hl.dsp.exec_cmd(noctaliaIpc .. "panel-toggle session"))
    hl.bind(mainMod .. "+Y", hl.dsp.exec_cmd(noctaliaIpc .. "panel-toggle wallpaper"))
    hl.bind("ALT + Tab", hl.dsp.exec_cmd(noctaliaIpc .. "window-switcher"))
    hl.bind(mainMod .. "+ALT+L", hl.dsp.exec_cmd(noctaliaIpc .. "session lock"))

    hl.bind(mainMod .. " + Q", hl.dsp.window.close())
    hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
    hl.bind(mainMod .. " + Tab", hl.dsp.focus({ workspace = "previous" }))

    local directions = { left = "h", right = "l", up = "k", down = "j" }
    for direction, vim in pairs(directions) do
        hl.bind(mainMod .. " + " .. direction, hl.dsp.focus({ direction = direction }))
        hl.bind(mainMod .. " + SHIFT + " .. direction, hl.dsp.window.move({ direction = direction }))
        hl.bind(mainMod .. " + " .. vim, hl.dsp.focus({ direction = direction }))
        hl.bind(mainMod .. " + SHIFT + " .. vim, hl.dsp.window.move({ direction = direction }))
    end

    hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
    hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

    for i = 1, 10 do
        local key = i % 10
        hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
        hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
    end

    hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
    hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

    hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(noctaliaIpc .. "volume-up"), { locked = true, repeating = true })
    hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(noctaliaIpc .. "volume-down"), { locked = true, repeating = true })
    hl.bind("XF86AudioMute", hl.dsp.exec_cmd(noctaliaIpc .. "volume-mute"), { locked = true, repeating = true })
    hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd(noctaliaIpc .. "mic-mute"), { locked = true, repeating = true })
    hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(noctaliaIpc .. "brightness-up"), { locked = true, repeating = true })
    hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(noctaliaIpc .. "brightness-down"), { locked = true, repeating = true })
    hl.bind("XF86AudioNext", hl.dsp.exec_cmd(noctaliaIpc .. "media next"), { locked = true })
    hl.bind("XF86AudioPause", hl.dsp.exec_cmd(noctaliaIpc .. "media toggle"), { locked = true })
    hl.bind("XF86AudioPlay", hl.dsp.exec_cmd(noctaliaIpc .. "media toggle"), { locked = true })
    hl.bind("XF86AudioPrev", hl.dsp.exec_cmd(noctaliaIpc .. "media previous"), { locked = true })
end
