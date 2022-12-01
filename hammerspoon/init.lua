hs.logger.defaultLogLevel = "info"
local log = hs.logger.new("utz")

hs.loadSpoon("SpoonInstall")

spoon.SpoonInstall:andUse("ReloadConfiguration", { start = true })

local make_annotations = coroutine.create(function()
	hs.coroutineApplicationYield()
	spoon.SpoonInstall:andUse("EmmyLua")
	log:i("Hammerspoon annotations written")
end)

require("utzwm")

hs.hotkey.bind({ "cmd" }, "g", function()
	local app = hs.application.get("kitty")
	if app then
		if not app:mainWindow() then
			app:selectMenuItem({ "Shell", "New OS Window" })
		elseif app:isFrontmost() then
			app:hide()
		else
			app:activate()
		end
	else
		hs.application.launchOrFocus("kitty")
		app = hs.application.get("kitty")
	end

	app:mainWindow():moveToUnit("100,50,0,0")
	app:mainWindow().setShadows(false)
end)

log:i("Hammerspoon Reloaded")
hs.notify.show("Hammerspoon", "", "Config reloaded")

coroutine.resume(make_annotations)
