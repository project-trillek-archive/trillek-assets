
GUI.cdoc = gui:load_doc("common/assets/scripts/menu.rml")
gui:show_doc(GUI.cdoc)

sys:Subscribe(5000, "ToggleUI")

function Menu_Reset()
end

function Menu_Reload()
	gui:close_doc(GUI.cdoc)
	GUI.cdoc = gui:load_doc('common/assets/scripts/menu.rml')
	gui:show_doc(GUI.cdoc)
end

function Menu_Resume()
	gui:hide_doc(GUI.cdoc)
	rayallowed = true
	if not theos:GetMouseLock() then
		theos:ToggleMouseLock()
	end
end

function ToggleUI(action, key)
	if (action == "Up") then
		if (key == 256) then
			if (gui:doc_visible(GUI.cdoc)) then
				OverlayEnable()
				gui:hide_doc(GUI.cdoc)
				if not theos:GetMouseLock() then
					theos:ToggleMouseLock()
				end
			else
				OverlayDisable()
				if theos:GetMouseLock() then
					theos:ToggleMouseLock()
				end
				gui:show_doc(GUI.cdoc)
			end
		end
	end
end

