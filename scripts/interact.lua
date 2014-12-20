
movit = false
movn = 0
rayallowed = false
ovisdisplay = false
interacting = false
ovdoc = nil
ovinter = nil
ovtool = nil
usingid = 0
usingtrig = 0
irlim = 0

GUI.ovlay = gui:sync_load_doc("common/assets/scripts/overlay.rml")

sys:Subscribe(1, "RayUpdate")
sys:Subscribe(5000, "InteractCtl")
sys:Subscribe(5001, "RayBtn")

ovdoc = gui:get_doc(GUI.ovlay)
if not (ovdoc == nil) then
	ovinter = ovdoc:getElementById("inter")
	ovtool = ovdoc:getElementById("tool")
end


function OverlayShow(which)
	if interacting then
		InteractDisable()
	end
	if Entity.is_interactive(which) then
		acts = Entity.get_actions(which)
		atext = ""
		irlim = #acts
		for i = 1, irlim do
			if i == 1 then
				ovtool:setInnerRML("[LMB] " .. acts[i].text)
			elseif i == 2 then
				atext = atext .. "<div>[E] " .. acts[i].text .. "</div>"
			else
				atext = atext .. "<div>[" .. i .. "] " .. acts[i].text .. "</div>"
			end
		end
		ovinter:setInnerRML(atext)
	else
		irlim = 0
		ovtool:setInnerRML("")
		ovinter:setInnerRML("")
	end
	gui:show_doc(GUI.ovlay)
	ovisdisplay = true
end

function OverlayHide()
	irlim = 0
	gui:hide_doc(GUI.ovlay)
	ovisdisplay = false
	InteractDisable()
end

function InteractTrigger(thing, snum)
	if irlim > 0 then
		if snum <= irlim then
			acts = Entity.get_actions(thing)
			Log("Trigger Interact " .. acts[snum].text .. " On " .. thing)
			if acts[snum].text == "use" then
				InteractEnable(thing, snum)
			end
			Entity.trigger(thing, snum)
		else
			Log("Can not Trigger " .. snum .. " On " .. thing)
		end
	else
		Log("Can not Interact with " .. thing)
	end
end

function InteractEnable(thing, snum)
	Log("Interact Lock On " .. thing)
	KeybMoveDisable()
	interacting = true
	usingid = thing
	usingtrig = snum
	if ovisdisplay then
		gui:hide_doc(GUI.ovlay)
	end
end

function InteractDisable()
	KeybMoveEnable()
	if interacting then
		Log("Interact Lock Off")
		interacting = false
		Entity.trigger(usingid, usingtrig)
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
			InteractTrigger(movn, 2)
		elseif key == 51 then
			InteractTrigger(movn, 3)
		elseif key == 52 then
			InteractTrigger(movn, 4)
		end
	end
end

function InteractMove()
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

function RayBtn(state, btn)
	if (state == "Down") and (btn == "Left") then
		if interacting then
			InteractDisable()
		elseif rayallowed then
			InteractTrigger(movn, 1)
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
			scnid = phys:ray_cast()
			howfar = phys:ray_dist()
			editit = phys:get_movable(scnid)
			if editit and howfar < 1.2 then
				if not ovisdisplay then
					movn = scnid
					OverlayShow(movn)
				elseif not (scnid == movn) then
					movn = scnid
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
