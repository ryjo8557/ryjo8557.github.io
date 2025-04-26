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

-- level state
level = 1
walls = {}
flags = {}

-- camera variables
camera_deadzone = 32
camera_smoothness = 0.1
camera_x = 0
camera_y = 0

-- level definitions
function load_level_1()
    walls = {}
    flags = {}

    for i = 0, 8 do
        add(walls, {x = i * 8, y = 100, sprite = 17})
    end
    
    -- wall
    add(walls, {x = 72, y = 92, sprite = 18})
    add(walls, {x = 72, y = 84, sprite = 18})
    
    -- layered
    add(walls, {x = 96, y = 92, sprite = 19}) -- blue
    add(walls, {x = 96, y = 84, sprite = 17}) -- red
    add(walls, {x = 96, y = 76, sprite = 18}) -- green
    add(walls, {x = 96, y = 68, sprite = 19}) -- blue
    
    -- vertical wall climb
    add(walls, {x = 120, y = 92, sprite = 17})
    add(walls, {x = 120, y = 84, sprite = 18})
    add(walls, {x = 120, y = 76, sprite = 19})
    add(walls, {x = 120, y = 68, sprite = 17})
    add(walls, {x = 120, y = 60, sprite = 18})
    add(walls, {x = 120, y = 52, sprite = 19})
    
    -- trap platform over gap
    add(walls, {x = 96, y = 40, sprite = 19}) -- blue (fall if blue)
    
    -- tiny landing platform
    add(walls, {x = 96, y = 24, sprite = 18}) -- green
    
    -- final jump steps
-- final jump steps extended leftward
add(walls, {x = 80, y = 16, sprite = 17}) -- red
add(walls, {x = 64, y = 16, sprite = 18}) -- green
add(walls, {x = 48, y = 16, sprite = 19}) -- blue
add(walls, {x = 32, y = 16, sprite = 19}) -- blue
add(walls, {x = 16, y = 16, sprite = 18}) -- green
add(walls, {x = 0, y = 16, sprite = 17})  -- red (final one)

add(flags, {x = 0, y = 8, sprite = 4}) -- flag on final red block
    player.x = 30
    player.y = 50

    add(walls, {x = 32, y = 8, sprite = 17})
end

function load_level_2()
    walls = {}
    flags = {}

    -- floor
    for i = 0, 30 do
        local s = (i % 3) + 17
        add(walls, {x = i * 8, y = 100, sprite = s})
    end

    -- stair climb
    add(walls, {x = 24, y = 88, sprite = 18})
    add(walls, {x = 32, y = 80, sprite = 19})
    add(walls, {x = 40, y = 72, sprite = 17})
    add(walls, {x = 48, y = 64, sprite = 18})
    add(walls, {x = 56, y = 56, sprite = 19})

    -- tricky swaps through walls
    add(walls, {x = 72, y = 56, sprite = 17})
    add(walls, {x = 72, y = 64, sprite = 18})
    add(walls, {x = 72, y = 72, sprite = 19})

    -- platform tower
    add(walls, {x = 96, y = 80, sprite = 18})
    add(walls, {x = 104, y = 72, sprite = 19})
    add(walls, {x = 112, y = 64, sprite = 17})
    add(walls, {x = 120, y = 56, sprite = 18})
    add(walls, {x = 128, y = 48, sprite = 19})

    -- final jump
    add(walls, {x = 144, y = 40, sprite = 17})
    add(flags, {x = 144, y = 32}) -- harder flag to reach
end
function load_level_3()
    walls = {}
    flags = {}

    -- start room
    for i = 0, 4 do
        add(walls, {x = i * 8, y = 100, sprite = 17})
    end
    add(walls, {x = 0, y = 92, sprite = 17}) -- left wall
    add(walls, {x = 32, y = 92, sprite = 17}) -- right wall
    add(walls, {x = 16, y = 84, sprite = 18}) -- jump pad

    -- rising tunnel w/ swaps
    add(walls, {x = 16, y = 76, sprite = 19})
    add(walls, {x = 8, y = 68, sprite = 17})
    add(walls, {x = 24, y = 60, sprite = 18})
    add(walls, {x = 16, y = 52, sprite = 19})

    -- escape ledge
    add(walls, {x = 32, y = 44, sprite = 17})
    add(walls, {x = 40, y = 44, sprite = 18})
    add(walls, {x = 48, y = 44, sprite = 19})

    -- final jump
    add(walls, {x = 56, y = 36, sprite = 17})
    add(walls, {x = 64, y = 28, sprite = 18})
    add(walls, {x = 72, y = 20, sprite = 19})

    add(flags, {x = 72, y = 12}) -- flag at top
end

function load_level_4()
    walls = {}
    flags = {}

    -- narrow shaft intro
    for y = 100, 60, -8 do
        add(walls, {x = 0, y = y, sprite = 18})
        add(walls, {x = 24, y = y, sprite = 18})
    end
    add(walls, {x = 8, y = 92, sprite = 17})
    add(walls, {x = 16, y = 76, sprite = 19})

    -- escape to the left
    add(walls, {x = -8, y = 60, sprite = 17})
    add(walls, {x = -16, y = 52, sprite = 18})
    add(walls, {x = -24, y = 44, sprite = 19})

    -- horizontal tunnel
    for x = -24, 32, 8 do
        add(walls, {x = x, y = 36, sprite = (x/8)%3 + 17})
    end

    -- final platform and flag
    add(walls, {x = 40, y = 28, sprite = 18})
    add(walls, {x = 48, y = 20, sprite = 19})
    add(flags, {x = 48, y = 12})
end

-- load first level
load_level_1()

-- update loop
-- Define a fall threshold
fall_threshold = 120  -- Adjust this value to where the player is considered to have fallen

function _update()
    local move_x = 0
    local was_on_ground = player.on_ground
    local was_on_wall = player.on_wall
    player.on_ground = false
    player.on_wall = false

    -- Check if player falls below the fall threshold (off the screen)
    if player.y > fall_threshold then
        player.x = 30  -- Starting X position
        player.y = 50  -- Starting Y position
    end

    -- Movement logic
    if btn(0) then move_x = -player.speed player.dir = -1 end
    if btn(1) then move_x = player.speed player.dir = 1 end

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

    player.vy += gravity
    try_move_x(move_x)
    try_move_y(player.vy)

    if jump_buffer_timer > 0 and coyote_timer > 0 then
        player.vy = jump_strength
        jump_buffer_timer = 0
        coyote_timer = 0
        if player.on_wall and not player.on_ground then
            player.vx = -player.dir * wall_jump_speed
        end
    end

    player.x += player.vx
    player.vx *= 0.8

    if btnp(5) then
        player.sprite = (player.sprite % 3) + 1
    end

    -- check flag
    for flag in all(flags) do
        if collide(player, flag) then
            level += 1
            if level == 2 then
                player.x = 20
                player.y = 90
                load_level_2()
            elseif level == 3 then
                player.x = 20
                player.y = 90
                load_level_3()
            elseif level == 4 then
                player.x = 20
                player.y = 90
                load_level_4()  -- Added level 4 loading logic here
            elseif level == 5 then
                player.x = 20
                player.y = 90
                load_level_5()  -- Added level 5 loading logic here
            end
        end
    end

    update_camera()
end


function try_move_x(dx)
    player.x += dx
    for wall in all(walls) do
        if collide(player, wall) and is_same_color(wall) then
            if dx > 0 then
                player.x = wall.x - 8
            elseif dx < 0 then
                player.x = wall.x + 8
            end
            player.on_wall = true
        end
    end
end

function try_move_y(dy)
    player.y += dy
    local priority_ground = false
    for wall in all(walls) do
        if collide(player, wall) then
            if not is_same_color(wall) then goto continue end
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
end

function collide(p, w)
    return p.x + 7 >= w.x and p.x <= w.x + 7 and
           p.y + 7 >= w.y and p.y <= w.y + 7
end

function is_same_color(wall)
    return (wall.sprite - 16) == player.sprite
end

function update_camera()
    local target_x = player.x - 64
    local target_y = player.y - 64
    camera_x = target_x * camera_smoothness + (1 - camera_smoothness) * camera_x
    camera_y = target_y * camera_smoothness + (1 - camera_smoothness) * camera_y
    camera(camera_x, camera_y)
end

function _draw()
    cls()
    for wall in all(walls) do
        spr(wall.sprite, wall.x, wall.y)
    end
    for flag in all(flags) do
        spr(4, flag.x, flag.y)
    end
    spr(player.sprite, player.x, player.y)
    print("z: jump, x: swap", camera_x + 1, camera_y + 1, 7)
end
