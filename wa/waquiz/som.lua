-- player variables
player = {
    x = 30,
    y = 50,
    speed = 1.5,
    vx = 0,
    vy = 0,
    dir = 1,
    sprite = 1,
    on_ground = false,
    on_wall = false
}

gravity = 0.2
jump_strength = -3
wall_jump_speed = 1.2
coyote_time = 6
jump_buffer_time = 6
coyote_timer = 0
jump_buffer_timer = 0

-- floor tiles
walls = {}

-- fill floor w walls
for i = 0, 15 do
    local s = (i % 3) + 17 -- cycle sprites 17,18,19
    add(walls, {x = i * 8, y = 100, sprite = s})
end

for w in all(walls) do
    if w.x == 32 and w.y == 100 then
        del(walls, w)
        break
    end
end
add(walls, {x = 32, y = 100, sprite = 17}) -- red

-- floating platforms (color-based puzzles!)
add(walls, {x = 24, y = 88, sprite = 18}) -- green
add(walls, {x = 56, y = 80, sprite = 19}) -- blue
add(walls, {x = 80, y = 72, sprite = 17}) -- red
add(walls, {x = 104, y = 64, sprite = 18}) -- green
add(walls, {x = 128, y = 56, sprite = 19}) -- blue
add(walls, {x = 96, y = 88, sprite = 17}) -- red

-- side pillars for jumping
add(walls, {x = 0, y = 92, sprite = 17})
add(walls, {x = 0, y = 84, sprite = 18})
add(walls, {x = 0, y = 76, sprite = 19})

add(walls, {x = 136, y = 92, sprite = 18})
add(walls, {x = 136, y = 84, sprite = 19})
add(walls, {x = 136, y = 76, sprite = 17})

-- camera variables
camera_deadzone = 32
camera_smoothness = 0.1
camera_x = 0
camera_y = 0

-- main update loop
function _update()
    local move_x = 0
    local was_on_ground = player.on_ground
    local was_on_wall = player.on_wall
    player.on_ground = false
    player.on_wall = false

    -- input
    if btn(0) then move_x = -player.speed player.dir = -1 end
    if btn(1) then move_x = player.speed player.dir = 1 end

    -- timers
    if was_on_ground or was_on_wall then
        coyote_timer = coyote_time
    else
        coyote_timer -= 1
    end

    if btnp(4) then
        jump_buffer_timer = jump_buffer_time
    else
        jump_buffer_timer -= 1
    end

    -- gravity
    player.vy += gravity

    -- movement + collision
    try_move_x(move_x)
    try_move_y(player.vy)

    -- jump (if buffered and coyote time allows)
    if jump_buffer_timer > 0 and coyote_timer > 0 then
        player.vy = jump_strength
        jump_buffer_timer = 0
        coyote_timer = 0

        -- wall jump push
        if player.on_wall and not player.on_ground then
            player.vx = -player.dir * wall_jump_speed
        end
    end

    -- wall jump push
    player.x += player.vx
    player.vx *= 0.8

    -- switch color
    if btnp(5) then
        player.sprite = (player.sprite % 3) + 1
    end

    -- update camera
    update_camera()
end

-- x-axis movement with horizontal wall collision
function try_move_x(dx)
    player.x += dx
    for wall in all(walls) do
        if collide(player, wall) and not is_same_color(wall) then
            if dx > 0 then
                player.x = wall.x - 8
            elseif dx < 0 then
                player.x = wall.x + 8
            end
            player.on_wall = true
        end
    end
end

-- y-axis movement with vertical collision
function try_move_y(dy)
    player.y += dy
    local priority_ground = false
    for wall in all(walls) do
        if collide(player, wall) then
            if is_same_color(wall) then
                priority_ground = true
                goto continue
            end
            if dy > 0 then
                player.y = wall.y - 8
                player.vy = 0
                player.on_ground = true
            elseif dy < 0 then
                player.y = wall.y + 8
                player.vy = 0
                player.on_wall = true
            end
        end
        ::continue::
    end
    if priority_ground then
        player.on_ground = true
    end
end

-- check for collision
function collide(p, w)
    return p.x + 7 >= w.x and p.x <= w.x + 7 and
           p.y + 7 >= w.y and p.y <= w.y + 7
end

-- check color match
function is_same_color(wall)
    return (wall.sprite - 16) == player.sprite
end

-- camera follow the player
function update_camera()
    local target_x = player.x - 64
    local target_y = player.y - 64

    camera_x = target_x * camera_smoothness + (1 - camera_smoothness) * camera_x
    camera_y = target_y * camera_smoothness + (1 - camera_smoothness) * camera_y

    camera(camera_x, camera_y)
end

-- drawing
function _draw()
    cls()

    -- draw walls
    for wall in all(walls) do
        spr(wall.sprite, wall.x, wall.y)
    end

    -- draw player
    spr(player.sprite, player.x, player.y)

    -- info
    print("z: jump, x: switch color", camera_x + 1, camera_y + 1, 7)
end
