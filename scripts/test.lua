transform = Transform.Get(1000)

scale = transform:get_scale()

scale_direction = 1

function Update(delta)
    if (scale.x > 10) then
        scale_direction = -1
    elseif (scale.x < 0000) then
        scale_direction = 1
    end
    scale.x = scale.x + 0.1 * scale_direction
    scale.y = scale.y + 0.1 * scale_direction
    scale.z = scale.z + 0.1 * scale_direction
    transform:set_scale(scale.x, scale.y, scale.z)
end
