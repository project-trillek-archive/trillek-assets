
gui = GUI.Get()
gui:LoadFont("assets/mona.ttf")
GUI.cdoc = gui:LoadDoc("assets/scripts/menu.rml")
gui:ShowDoc(GUI.cdoc)

LuaSys.Get():Subscribe(5000, "ToggleUI")

function Menu_Reset()
end

function Menu_Reload()
	gui:CloseDoc(GUI.cdoc)
	GUI.cdoc = gui:LoadDoc('assets/scripts/menu.rml')
	gui:ShowDoc(GUI.cdoc)
end

function Menu_Resume()
	gui:HideDoc(GUI.cdoc)
	if not OS.Get():GetMouseLock() then
		OS.Get():ToggleMouseLock()
	end
end

function ToggleUI(action, key)
	if (action == "Up") then
		if (key == 256) then
			if (gui:DocVisible(GUI.cdoc)) then
				gui:HideDoc(GUI.cdoc)
				if not OS.Get():GetMouseLock() then
					OS.Get():ToggleMouseLock()
				end
			else
				if OS.Get():GetMouseLock() then
					OS.Get():ToggleMouseLock()
				end
				gui:ShowDoc(GUI.cdoc)
			end
		end
	end
end
