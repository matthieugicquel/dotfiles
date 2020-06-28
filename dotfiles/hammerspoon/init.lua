-- -----------------
-- Setup
-- -----------------

local logger = hs.logger.new("MG", "info")
logger.i("⏳ Loading configuration")
hs.hotkey.setLogLevel("warning")

hs.window.animationDuration = 0.2

hs.alert.defaultStyle["radius"] = 8
hs.alert.defaultStyle["fillColor"] = { white = 0, alpha = 0.65 }
hs.alert.defaultStyle["textSize"] = 20

-- -----------------
-- Modifiers
-- -----------------
local alt = {"⌥"}
local hyper = {"⌘", "⌥", "⌃", "⇧"}
local nudgekey = {"⌥", "⌃"}
local yankkey = {"⌥", "⌃","⇧"}
local pushkey = {"⌃", "⌘"}
local shiftpushkey= {"⌃", "⌘", "⇧"}

-- -----------------
-- Layout management
-- -----------------
local function toggleFullScreenForFocusedWindow()
    local window = hs.window.focusedWindow()
    if window ~= nil then
        window:setFullScreen(not window:isFullScreen())
    end
end

hs.hotkey.bind(hyper, "up", toggleFullScreenForFocusedWindow)
hs.hotkey.bind(hyper, "left", function() hs.window.focusedWindow():moveOneScreenWest() end)
hs.hotkey.bind(hyper, "right", function() hs.window.focusedWindow():moveOneScreenEast() end)

-- ---------------------
-- Application shortcuts
-- ---------------------
local function rotateBetweenWindows(filter, appName)
    local windows = filter:getWindows()
    local focusedWindow = hs.window.focusedWindow()

    if windows[1] == nil then
        hs.application.launchOrFocus(appName)
    else
        local targetIndex = 1
        for i, window in pairs(windows) do
            if window == focusedWindow and windows[i+1] ~= nil then
                targetIndex = i+1
            end
        end
        windows[targetIndex]:focus()
    end
end

local function hotkeyForApp(key, appName)
    local filter = hs.window.filter.new(false):allowApp(appName)
    hs.hotkey.bind(hyper, key, function() rotateBetweenWindows(filter, appName) end)
end
-- From the docs:
-- "Spaces-aware windowfilters might experience a (sometimes significant) delay after every Space switch"
-- Won't be perfect...

hotkeyForApp("@", "Safari Technology Preview")
hotkeyForApp("&", "Visual Studio Code") -- 1
hotkeyForApp("é", "Terminal") -- 2
hotkeyForApp('"', "Fork") -- 3
hotkeyForApp("d", "Discord")
hotkeyForApp("m", "Spotify")

-- --------------------
-- Quit all apps
-- --------------------
local function quitAllAppsConfirmed(prompt_id)
    hs.alert.closeSpecific(prompt_id)
    hs.alert("🧨 Quitting all apps")
    local apps = hs.application.runningApplications()
    for i, app in pairs(apps) do
        if app:name() == "Finder" or app:name() == "Spotify" then
            for j, window in pairs(app:allWindows()) do
                window:close()
            end
        elseif app:kind() == 1 then  -- 1 is for "dock"/"real" app
            app:kill()
        end
    end
end

local function quitAllAppsPromptExpired(prompt_id, hotkey)
    hs.alert.closeSpecific(prompt_id)
    hotkey:delete() -- Will reactivate the prompt hotkey that was "overloaded"
end

local function promptQuitAllAppsConfirmation()
    local prompt_id = hs.alert("⌨️ Press again to quit all apps", nil, nil , nil)
    local hotkey = hs.hotkey.bind(hyper, "Q", function() quitAllAppsConfirmed(prompt_id) end)
    hs.timer.doAfter(2, function() quitAllAppsPromptExpired(prompt_id, hotkey) end)
end

hs.hotkey.bind(hyper, "Q", promptQuitAllAppsConfirmation)

logger.i("🚀 Configuration loaded")
