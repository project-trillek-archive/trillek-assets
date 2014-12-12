
movit = false
movn = 0
rayallowed = false
ovisdisplay = false
interacting = false

GUI.ovlay = gui:LoadDoc("common/assets/scripts/overlay.rml")

sys:Subscribe(1, "RayUpdate")
sys:Subscribe(5001, "RayBtn")

function OverlayShow(which)
	Log("OVL Showing " .. which)
	gui:ShowDoc(GUI.ovlay)
	ovisdisplay = true
end

function OverlayHide()
	Log("OVL Hiding")
	gui:HideDoc(GUI.ovlay)
	ovisdisplay = false
end

function OverlayDisable()
	rayallowed = false
	OverlayHide()
end

function OverlayEnable()
	rayallowed = true
end

function RayBtn(state, btn)
	if rayallowed and (state == "Down") and (btn == "Left") then
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
					Log("dist=" .. howfar .. ",ent=" .. movn)
					OverlayShow("interact")
				end
			else
				if ovisdisplay then
					Log("dist=" .. howfar .. ",ent=" .. movn)
					OverlayHide()
				end
			end
		end
	end
end
