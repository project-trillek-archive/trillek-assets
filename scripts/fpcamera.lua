
sys:Subscribe(1, "MouseUpdate")
sys:Subscribe(5000, "MoveCamera")
sys:Subscribe(5001, "MouseBFPS")
sys:Subscribe(5002, "MouseMFPS")

cameraVelocity = {x = 0.0, y = 0.0, z = 0.0, rx = 0.0, ry = 0.0, rz = 0.0}
cameraR = {x = 0.0, y = 0.0, z = 0.0}
gravityEnabled = true
enableKeyMove = true

function KeybMoveDisable()
	enableKeyMove = false
	cameraVelocity.x = 0
	cameraVelocity.y = 0
	cameraVelocity.z = 0
end

function KeybMoveEnable()
	enableKeyMove = true
end

function MouseBFPS(state, btn)
	if (state == "Down") and (btn == "Right") then
		theos:ToggleMouseLock()
	end
end

function MoveCamera(action, key)
    if not enableKeyMove then
        return
    end
    if (action == "Down") then
        if (key == 87) then
            cameraVelocity.z = -0.1
        elseif key == 83 then
            cameraVelocity.z = 0.1
        elseif key == 65 then
            cameraVelocity.x = -0.1
        elseif key == 68 then
            cameraVelocity.x = 0.1
        elseif (key == 328) then
            cameraVelocity.rx = 5.0
        elseif (key == 322) then
            cameraVelocity.rx = -5.0
        elseif (key == 324) then
            cameraVelocity.ry = 5.0
        elseif (key == 326) then
            cameraVelocity.ry = -5.0
        elseif (key == 327) then
            cameraVelocity.rz = 5.0
        elseif (key == 329) then
            cameraVelocity.rz = -5.0
        elseif (key == 320) then
            if gravityEnabled then
                gravityEnabled = false
                phys:set_gravity(10, { x = 0.0, y = 0.0, z = 0.0 })
            else
                gravityEnabled = true
                phys:set_gravity(10, nil)
            end
        end
    elseif (action == "Up") then
        if (key == 87) then
            cameraVelocity.z = 0
        elseif (key == string.byte("S")) then
            cameraVelocity.z = 0
        elseif (key == 65) then
            cameraVelocity.x = 0
        elseif (key == string.byte("D")) then
            cameraVelocity.x = 0
        elseif (key == 328) then
            cameraVelocity.rx = 0
        elseif (key == 322) then
            cameraVelocity.rx = 0
        elseif (key == 324) then
            cameraVelocity.ry = 0
        elseif (key == 326) then
            cameraVelocity.ry = 0
        elseif (key == 327) then
            cameraVelocity.rz = 0
        elseif (key == 329) then
            cameraVelocity.rz = 0
        elseif (key == 320) then
        end
    end
    phys:set_velocity(10, cameraVelocity)
end

function MouseMFPS(pixelx, pixely, oldx, oldy, x, y)
	if theos:GetMouseLock() then
	cameraR.x = cameraR.x + ((pixelx - oldx) * 0.125)
	cameraR.y = cameraR.y + ((pixely - oldy) * 0.125)
	end
end

function MouseUpdate(delta)
	camera = Transform.Get(10)
	cameraAn = {x = cameraVelocity.x, y = cameraVelocity.y, z = cameraVelocity.z,
		rx = -cameraR.y, ry = -cameraR.x, rz = 0}
	cameraR.x = 0
	cameraR.y = 0
	phys:set_velocity(10, cameraAn)
end
