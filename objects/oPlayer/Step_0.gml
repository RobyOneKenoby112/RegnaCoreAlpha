

// 1. Calculate intended movement
var move = keyboard_check(vk_right) - keyboard_check(vk_left);
hsp = move * walk_speed;

// 2. Apply Gravity
y_speed += 0.5;

// 3. Grounded Check & Jump
var on_ground = place_meeting(x, y + 1, oSolid);
if (on_ground) {
    if (keyboard_check_pressed(vk_up)) {
        y_speed = -10;
    } else {
        y_speed = 0;
    }
}

// 4. THE FIX: Collision & Movement
// Using 'temp' variables ensures we don't get stuck mid-frame
move_and_collide(hsp, y_speed, oSolid);

// 4. SPECIAL BLOCK INTERACTION (Fake Blocks)
// Check if we are touching ANY fake block
if (place_meeting(x, y + 1, Fake)) {
    // Tell EVERY instance of "Fake" in the room to start fading
    with (Fake) {
        is_fading = true;
    }
}

// 5. THE FIX: Animation (Only flip if we are actually moving)
if (move != 0) {
    image_xscale = move; // Using 'move' (1 or -1) is safer than 'hsp'
    sprite_index = sPlayerRun;
} else {
    sprite_index = sPlayerIdle;
}

// 7. ROOM TRANSITION
if (place_meeting(x, y, oDoor)) {
    room_goto_next();
}
