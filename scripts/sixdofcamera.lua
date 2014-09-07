camera = Transform.Get(10)
bob = Transform.Get(1001)

LuaSys.Get():Subscribe(5000, "MoveCamera")

phys = Physics.Get()

cameraLinear = {x = 0.0, y = 0.0, z = 0.0}
cameraAngular = {x = 0.0, y = 0.0, z = 0.0}

gravityEnabled = true;

function MoveCamera(action, key)
    if (action == "Down") then
        if (key == string.byte("W")) then
            cameraLinear.z = cameraLinear.z - 10.0
        elseif (key == string.byte("S")) then
            cameraLinear.z = cameraLinear.z + 10.0
        elseif (key == string.byte("A")) then
            cameraLinear.x = cameraLinear.x - 10.0
        elseif (key == string.byte("D")) then
            cameraLinear.x = cameraLinear.x + 10.0
        elseif (key == 328) then
            cameraAngular.x = cameraAngular.x + 5.0
        elseif (key == 322) then
            cameraAngular.x = cameraAngular.x - 5.0
        elseif (key == 324) then
            cameraAngular.y = cameraAngular.y + 5.0
        elseif (key == 326) then
            cameraAngular.y = cameraAngular.y - 5.0
        elseif (key == 327) then
            cameraAngular.z = cameraAngular.z + 5.0
        elseif (key == 329) then
            cameraAngular.z = cameraAngular.z - 5.0
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
            cameraLinear.z = cameraLinear.z + 10.0
        elseif (key == string.byte("S")) then
            cameraLinear.z = cameraLinear.z - 10.0
        elseif (key == string.byte("A")) then
            cameraLinear.x = cameraLinear.x + 10.0
        elseif (key == string.byte("D")) then
            cameraLinear.x = cameraLinear.x - 10.0
        elseif (key == 328) then
            cameraAngular.x = cameraAngular.x - 5.0
        elseif (key == 322) then
            cameraAngular.x = cameraAngular.x + 5.0
        elseif (key == 324) then
            cameraAngular.y = cameraAngular.y - 5.0
        elseif (key == 326) then
            cameraAngular.y = cameraAngular.y + 5.0
        elseif (key == 327) then
            cameraAngular.z = cameraAngular.z - 5.0
        elseif (key == 329) then
            cameraAngular.z = cameraAngular.z + 5.0
        elseif (key == 320) then
        end
    end
    linear = camera:compute_velocity_vector(cameraLinear)
    angular = camera:compute_velocity_vector(cameraAngular)
    phys:set_force(10, linear)
    phys:set_torque(10, angular)
end
