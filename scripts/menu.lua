
GUI.cdoc = gui:LoadDoc("common/assets/scripts/menu.rml")
gui:ShowDoc(GUI.cdoc)

sys:Subscribe(5000, "ToggleUI")

function Menu_Reset()
end

function Menu_Reload()
	gui:CloseDoc(GUI.cdoc)
	GUI.cdoc = gui:LoadDoc('common/assets/scripts/menu.rml')
	gui:ShowDoc(GUI.cdoc)
end

function Menu_Resume()
	gui:HideDoc(GUI.cdoc)
	rayallowed = true
	if not theos:GetMouseLock() then
		theos:ToggleMouseLock()
	end
end

function ToggleUI(action, key)
	if (action == "Up") then
		if (key == 256) then
			if (gui:DocVisible(GUI.cdoc)) then
				OverlayEnable()
				gui:HideDoc(GUI.cdoc)
				if not theos:GetMouseLock() then
					theos:ToggleMouseLock()
				end
			else
				OverlayDisable()
				if theos:GetMouseLock() then
					theos:ToggleMouseLock()
				end
				gui:ShowDoc(GUI.cdoc)
			end
		end
	end
end

