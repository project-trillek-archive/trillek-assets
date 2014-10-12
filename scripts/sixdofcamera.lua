camera = Transform.Get(10)
bob = Transform.Get(1001)

LuaSys.Get():Subscribe(5000, "MoveCamera")

phys = Physics.Get()

cameraVelocity = {x = 0.0, y = 0.0, z = 0.0, rx = 0.0, ry = 0.0, rz = 0.0}

gravityEnabled = true;

function MoveCamera(action, key)
    if (action == "Down") then
        if (key == string.byte("W")) then
            cameraVelocity.z = cameraVelocity.z - 10.0
        elseif (key == string.byte("S")) then
            cameraVelocity.z = cameraVelocity.z + 10.0
        elseif (key == string.byte("A")) then
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
            if (gravityEnabled) then
                gravityEnabled = false
                phys:set_gravity(10, { x = 0.0, y = 0.0, z = 0.0 })
            else
                gravityEnabled = true
                phys:set_gravity(10, nil)
            end
        end
    elseif (action == "Up") then
        if (key == string.byte("W")) then
            cameraVelocity.z = cameraVelocity.z + 10.0
        elseif (key == string.byte("S")) then
            cameraVelocity.z = cameraVelocity.z - 10.0
        elseif (key == string.byte("A")) then
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
