-- Update Count — package update checker
-- Author - Sovereign, Mathew-D
-- Forked by nollidnosnhoj
--
-- Configure the keyboard device in your bar config:
-- [widget.updatecount]
-- script = "/path/to/scripts/updatecount.lua"
-- type = "scripted"
-- glyph = "packages"
-- update_interval = 60
-- aur_helper = "paru"
-- color_bool = false
-- color_count = 100
-- color_is = "error"

local update_count_script = (os.getenv("HOME") or "") .. "/.local/bin/update-count"
local update_list_script = (os.getenv("HOME") or "") .. "/.local/bin/update-list"
local update_script = (os.getenv("HOME") or "") .. "/.local/bin/update"

barWidget.define({
    label = "Pacman Update Count",
    icon = "packages",
    version = "1.0.0",
    description = "Tells you how many arch packages need updating.",
    settings = {
        { key = "glyph", type = "glyph", label = "Glyph", default = "packages" },
        {
            key = "update_interval",
            type = "integer",
            label = "Update check interval (in minutes)",
            default = 60,
            min = 30,
            max = 720,
        },
        {
            key = "color_bool",
            type = "bool",
            label = "Enable color change based on update count",
            default = false,
        },
        {
            key = "color_count",
            type = "integer",
            label = "Warn on update count greater than",
            default = 100,
            min = 1,
            max = 500,
            visible_when = { key = "color_bool", values = { "true" } }
        },
        {
            key = "color_is",
            type = "color",
            label = "Warn color",
            default = "error",
            visible_when = { key = "color_bool", values = { "true" } }
        },
    }
})

local glyph = barWidget.getConfig("glyph", "packages")
local color_bool = barWidget.getConfig("color_bool", false)
local color_count = barWidget.getConfig("color_count", 100)
local color_is = barWidget.getConfig("color_is", "error")
local update_interval = barWidget.getConfig("update_interval", 60) * 60 * 1000

barWidget.setGlyph(glyph)
barWidget.setText("--")
barWidget.setUpdateInterval(update_interval)

local function checkCommandsExists()
    if not noctalia.commandExists(update_count_script) then
        noctalia.notifyError(
            "Pacman Update Count",
            update_count_script .. " is not installed or executable."
        )
        return false
    end

    return true
end

local function checkForUpdates()
    noctalia.runAsync(update_count_script, function(result)
        local updateCount = (result.stdout or ""):gsub("%s+", "")

        setTooltip(updateCount)
        if updateCount:match("^%d+$") then
            updateColor(updateCount)
            barWidget.setText(updateCount)
        else
            noctalia.notifyError(
                "Pacman Update Count",
                "Invalid output: " .. updateCount
            )
            barWidget.setText("??")
        end
    end)
end

function updateColor(total)
    if not color_bool then return end

    local num = tonumber(total)
    if num > color_count then
        barWidget.setColor(color_is, "script")
        barWidget.setGlyphColor(color_is, "script")
    end
end

local function echoStringCreation()
    local echoString =
    "echo \"Noctailia Pacman Update Count\" && echo \"Updating system...\" && echo \"=================\""
    return echoString
end

local function pauseStringCreation()
    local echoString = "read -n 1 -s -r -p \"Press any key to close.\""
    return echoString
end

function setTooltip(total)
    local options = {
        { key = "Left click",   value = "Refresh" },
        { key = "Middle click", value = "View" },
        { key = "Right click",  value = "Update" },
        { key = "updates",      value = total or "--" },
    }
    barWidget.setTooltip(options)
end

function update()
    barWidget.setText("--")
    setTooltip()

    if not checkCommandsExists() then return end

    checkForUpdates()
end

function onClick()
    update()
end

function onMiddleClick()
    if not noctalia.commandExists(update_list_script) then
        noctalia.notifyError(
            "Pacman Update Count",
            update_list_script .. " is not installed or executable."
        )
        return
    end

    local middleCommand = update_list_script .. " && " .. pauseStringCreation()
    noctalia.runInTerminal(middleCommand)
end

function onRightClick()
    if not noctalia.commandExists(update_script) then
        noctalia.notifyError(
            "Pacman Update Count",
            update_script .. " is not installed or executable."
        )
        return
    end

    local rightCommand = echoStringCreation() .. " && " .. update_script .. " && " .. pauseStringCreation()
    noctalia.runInTerminal(rightCommand)
end

function onIpc(event, payload)
    if event == "refresh" then
        update()
    end
end
