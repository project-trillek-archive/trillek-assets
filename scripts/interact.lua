
movit = false
movn = 0
rayallowed = false
ovisdisplay = false
interacting = false
ovdoc = nil;
ovinter = nil;

GUI.ovlay = gui:sync_load_doc("common/assets/scripts/overlay.rml")

sys:Subscribe(1, "RayUpdate")
sys:Subscribe(5000, "InteractCtl")
sys:Subscribe(5001, "RayBtn")

ovdoc = gui:get_doc(GUI.ovlay)
if not (ovdoc == nil) then
	ovinter = ovdoc:getElementById("inter")
end


function OverlayShow(which)
	ovinter:setInnerRML("[E] Interact with " .. which)
	gui:show_doc(GUI.ovlay)
	ovisdisplay = true
end

function OverlayHide()
	gui:hide_doc(GUI.ovlay)
	ovisdisplay = false
	InteractDisable()
end

function InteractEnable(thing)
	Log("Interact On " .. thing)
	KeybMoveDisable()
	interacting = true
	if ovisdisplay then
		gui:hide_doc(GUI.ovlay)
	end
end

function InteractDisable()
	KeybMoveEnable()
	if interacting then
		Log("Interact Off")
		interacting = false
		if ovisdisplay then
			gui:show_doc(GUI.ovlay)
		end
	end
end

function OverlayDisable()
	rayallowed = false
	OverlayHide()
	InteractDisable()
end

function OverlayEnable()
	rayallowed = true
end

function InteractCtl(action, key)
	if not interacting and action == "Down" then
		if key == 69 then
			InteractEnable(movn)
		end
	end
end

function RayBtn(state, btn)
	if (state == "Down") and (btn == "Left") then
		if interacting then
			InteractDisable()
		elseif rayallowed then
			if movit then
				phys:set_moving(movn, false)
				movit = false
			else
				movn = phys:ray_cast()
				editit = phys:get_movable(movn)
				if editit then
					phys:set_moving(movn, true)
					movit = true
				end
			end
		end
	end
end

function RayUpdate()
	if rayallowed then
		if movit then
			phys:ray_casti(movn)
			howfar = phys:ray_dist()
			if howfar < 1.1 or howfar > 1.75 then
				phys:ray_invalidate()
			end
		else
			movn = phys:ray_cast()
			howfar = phys:ray_dist()
			editit = phys:get_movable(movn)
			if editit and howfar < 1.2 then
				if not ovisdisplay then
					OverlayShow(movn)
				end
			else
				if ovisdisplay then
					OverlayHide()
				end
			end
		end
	end
end
