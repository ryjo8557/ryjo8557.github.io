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

    -- blue starting platform
    for i = 0, 7 do
        add(walls, {x = i * 8, y = 100, sprite = 17})
    end
    
    add(walls, {x = 72, y = 92, sprite = 18})
    add(walls, {x = 72, y = 84, sprite = 18})
    
    -- first wall of blocks
    add(walls, {x = 96, y = 92, sprite = 19})
    add(walls, {x = 96, y = 84, sprite = 17})
    add(walls, {x = 96, y = 76, sprite = 18})
    add(walls, {x = 96, y = 68, sprite = 19})
    
    -- second wall of blocks
    add(walls, {x = 120, y = 92, sprite = 17})
    add(walls, {x = 120, y = 84, sprite = 18})
    add(walls, {x = 120, y = 76, sprite = 19})
    add(walls, {x = 120, y = 68, sprite = 17})
    add(walls, {x = 120, y = 60, sprite = 18})
    add(walls, {x = 120, y = 52, sprite = 19})
    
    add(walls, {x = 96, y = 40, sprite = 19})
    add(walls, {x = 96, y = 24, sprite = 18})
    
    add(walls, {x = 80, y = 16, sprite = 17})
    add(walls, {x = 64, y = 16, sprite = 18})
    add(walls, {x = 48, y = 16, sprite = 19})
    add(walls, {x = 32, y = 16, sprite = 17})
    add(walls, {x = 0, y = 16, sprite = 17}) --under flag

    add(flags, {x = 0, y = 8, sprite = 4})
        player.x = 30
        player.y = 50
end

function load_level_2()
    walls = {}
    flags = {}

    -- starting platform
    for i = 0, 4 do
        add(walls, {x = i * 8, y = 100, sprite = 17}) -- red
    end

    add(walls, {x = 56, y = 84, sprite = 19})
    add(walls, {x = 72, y = 84, sprite = 17})

    -- red wall
    add(walls, {x = 88, y = 76, sprite = 18})
    add(walls, {x = 88, y = 68, sprite = 18})
    add(walls, {x = 88, y = 60, sprite = 18})
    add(walls, {x = 88, y = 52, sprite = 18})

    -- other side of wall
    add(walls, {x = 104, y = 76, sprite = 18})
    add(walls, {x = 104, y = 60, sprite = 19})

    -- going up
    add(walls, {x = 112, y = 44, sprite = 17})

    add(walls, {x = 128, y = 36, sprite = 17})
    add(walls, {x = 128, y = 28, sprite = 17})
    add(walls, {x = 128, y = 20, sprite = 17})
    add(walls, {x = 128, y = 12, sprite = 17})

    add(walls, {x = 144, y = 28, sprite = 19})

    -- on top of wall more platforms
    add(walls, {x = 128, y = -4, sprite = 18})
    add(walls, {x = 128, y = -20, sprite = 17})
    add(walls, {x = 128, y = -36, sprite = 19})

    add(flags, {x = 128, y = -44, sprite = 4})

    -- spawn player
    player.x = 20
    player.y = 90
end

function load_level_3()
    walls = {}
    flags = {}

    -- ascending blue staircase
    for i = 0, 4 do
        add(walls, {x = 16 + i * 8, y = 100 - i * 8, sprite = 17})
    end

    add(walls, {x = 64, y = 52, sprite = 18})
    add(walls, {x = 72, y = 52, sprite = 18})

    -- green wall
    for i = 0, 4 do
        add(walls, {x = 88, y = 52 - i * 8, sprite = 19})
    end

    -- stairs up
    add(walls, {x = 104, y = 12, sprite = 18})
    add(walls, {x = 112, y = 4, sprite = 19})
    add(walls, {x = 120, y = -4, sprite = 17})

    -- wall jump section: red wall left, blue wall right
    for i = 0, 3 do
        add(walls, {x = 136, y = -20 - i * 8, sprite = 18}) -- red
        add(walls, {x = 144, y = -20 - i * 8, sprite = 17}) -- green
    end

    -- another red left blue right
    for i = 0, 3 do
        add(walls, {x = 168, y = -68 - i * 8, sprite = 18})
        add(walls, {x = 176, y = -68 - i * 8, sprite = 19})
    end
    add(walls, {x = 184, y = -100, sprite = 17})

    -- final ascent with staggered color blocks
    add(walls, {x = 200, y = -108, sprite = 18})
    add(walls, {x = 216, y = -116, sprite = 19})
    add(walls, {x = 232, y = -124, sprite = 17})

    -- flag at the top
    add(flags, {x = 232, y = -132, sprite = 4})

    -- spawn player
    player.x = 20
    player.y = 90
end

function load_level_4()
    walls = {}
    flags = {}

    for i = 0, 7 do
        add(walls, {x = i * 8, y = 100, sprite = 17})
    end
    
    add(flags, {x = 60, y = 92, sprite = 4})
        player.x = 30
        player.y = 50
end

-- load first level
load_level_1()
fall_threshold = 120

function _update()
    local move_x = 0
    local was_on_ground = player.on_ground
    local was_on_wall = player.on_wall
    player.on_ground = false
    player.on_wall = false

    -- check if player falls below the fall threshold (off the screen)
    if player.y > fall_threshold then
        player.x = 30  
        player.y = 50
        player.sprite = 1
    end

    -- movement logic
    if btn(0) then move_x = -player.speed player.dir = -1 end
    if btn(1) then move_x = player.speed player.dir = 1 end

    -- handle jumping from button press
    if (btnp(4) or btnp(2)) then
        jump_buffer_timer = jump_buffer_time
    else
        jump_buffer_timer -= 1
    end

    if was_on_ground or was_on_wall then
        coyote_timer = coyote_time
    else
        coyote_timer -= 1
    end

    player.vy += gravity
    try_move_x(move_x)
    try_move_y(player.vy)

    -- jump if within jump buffer and coyote time
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
                load_level_4()
            elseif level == 5 then
                level = 1
                load_level_1()
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

    if level == 1 then
        print("press x to swap color", -8, 72, 7)
    end
    if level == 2 then
        print("keep it up!", -8, 72, 7)
    end
    if level == 3 then
        print("how will you ascend?!", -11, 32, 7)
    end
    if level == 4 then
        print("You finished! Good job!", -8, 72, 7)
    end

    for flag in all(flags) do
        spr(4, flag.x, flag.y)
    end
    spr(player.sprite, player.x, player.y)
end