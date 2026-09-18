rightKey = keyboard_check(ord("D")) or keyboard_check(vk_right);
leftKey = keyboard_check(ord("A")) or keyboard_check(vk_left);
jumpKey = keyboard_check(ord("W")) or keyboard_check_pressed(ord(" ")) or keyboard_check_pressed(vk_up);

// Horizontal movement
var _horizKey = rightKey - leftKey;
xspd = _horizKey * moveSpd;

// Gravity
yspd += grav;
yspd = min(yspd, maxFallSpd);

// Jump / climb (kun hvis spilleren rører noget at stå på)
if (jumpKey && isGrounded) {
    yspd = -jumpSpd;
    isGrounded = false;
}

// Move + collision (eksempel med et "Ground" objekt)
if (place_meeting(x + xspd, y, obj_ground)) {
    while (!place_meeting(x + sign(xspd), y, obj_ground)) {
        x += sign(xspd);
    }
    xspd = 0;
}
x += xspd;

if (place_meeting(x, y + yspd, obj_ground)) {
    while (!place_meeting(x, y + sign(yspd), obj_ground)) {
        y += sign(yspd);
    }
    yspd = 0;
    isGrounded = true;
} else {
    isGrounded = false;
}
y += yspd;