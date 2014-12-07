
theos = OS.Get()

LuaSys.Get():Subscribe(1, "MouseUpdate")
LuaSys.Get():Subscribe(5000, "MoveCamera")
LuaSys.Get():Subscribe(5001, "MouseBFPS")
LuaSys.Get():Subscribe(5002, "MouseMFPS")
phys = Physics.Get()
cameraVelocity = {x = 0.0, y = 0.0, z = 0.0, rx = 0.0, ry = 0.0, rz = 0.0}
cameraR = {x = 0.0, y = 0.0, z = 0.0}
gravityEnabled = true
function MouseBFPS(state, btn)
	if (state == "Down") and (btn == "Right") then
		theos:ToggleMouseLock()
	end
end

function MoveCamera(action, key)
	if (action == "Down") then
        if (key == 87) then
            cameraVelocity.z = cameraVelocity.z - 10.0
        elseif (key == string.byte("S")) then
            cameraVelocity.z = cameraVelocity.z + 10.0
        elseif (key == 65) then
            cameraVelocity.x = cameraVelocity.x - 10.0
        elseif (key == string.byte("D")) then
            cameraVelocity.x = cameraVelocity.x + 10.0
        elseif (key == 328) then
            cameraVelocity.rx = cameraVelocity.rx + 5.0
        elseif (key == 322) then
            cameraVelocity.rx = cameraVelocity.rx - 5.0
        elseif (key == 324) then
            cameraVelocity.ry = cameraVelocity.ry + 5.0
        elseif (key == 326) then
            cameraVelocity.ry = cameraVelocity.ry - 5.0
        elseif (key == 327) then
            cameraVelocity.rz = cameraVelocity.rz + 5.0
        elseif (key == 329) then
            cameraVelocity.rz = cameraVelocity.rz - 5.0
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
            cameraVelocity.z = cameraVelocity.z + 10.0
        elseif (key == string.byte("S")) then
            cameraVelocity.z = cameraVelocity.z - 10.0
        elseif (key == 65) then
            cameraVelocity.x = cameraVelocity.x + 10.0
        elseif (key == string.byte("D")) then
            cameraVelocity.x = cameraVelocity.x - 10.0
        elseif (key == 328) then
            cameraVelocity.rx = cameraVelocity.rx - 5.0
        elseif (key == 322) then
            cameraVelocity.rx = cameraVelocity.rx + 5.0
        elseif (key == 324) then
            cameraVelocity.ry = cameraVelocity.ry - 5.0
        elseif (key == 326) then
            cameraVelocity.ry = cameraVelocity.ry + 5.0
        elseif (key == 327) then
            cameraVelocity.rz = cameraVelocity.rz - 5.0
        elseif (key == 329) then
            cameraVelocity.rz = cameraVelocity.rz + 5.0
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
	cam = camera:get_rotation()
	cameraAn = {x = cameraVelocity.x, y = cameraVelocity.y, z = cameraVelocity.z,
		rx = -cameraR.y, ry = -cameraR.x, rz = 0}
	cameraR.x = 0
	cameraR.y = 0
	phys:set_velocity(10, cameraAn)
end