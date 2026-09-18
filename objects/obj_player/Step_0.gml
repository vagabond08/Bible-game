rightKey = keyboard_check(ord("D")) or keyboard_check(vk_right);
leftKey = keyboard_check(ord("A")) or keyboard_check(vk_left);
jumpKey = keyboard_check(ord("W")) or keyboard_check(ord(" ")) or keyboard_check(vk_up);

collision = [obj_ground, obj_ground2]

// Horizontal movement
var _horizKey = rightKey - leftKey;
xspd = _horizKey * moveSpd;

// Gravity
yspd += grav;
yspd = min(yspd, maxFallSpd);

// Jump / climb kræver stamina
if (jumpKey && isGrounded && stamina >= staminaDrainPerJump) {
    yspd = -jumpSpd;
    isGrounded = false;
    stamina -= staminaDrainPerJump;
    staminaRegenTimer = staminaRegenDelay;
}

// Regen kun når man IKKE lige har brugt stamina, og man rører jorden
if (staminaRegenTimer > 0) {
    staminaRegenTimer -= 1;
} else if (isGrounded) {
    stamina += staminaRegenSpd;
}

stamina = clamp(stamina, 0, staminaMax);

// Smooth visning af baren (lerp mod faktisk værdi)
staminaDisplay += (stamina - staminaDisplay) * 0.15;

// Lille shake-warning når stamina er lav
if (stamina <= staminaMax * 0.2) {
    staminaBarShakeAmount = 2;
} else {
    staminaBarShakeAmount = 0;
}

// Move + collision (eksempel med et "Ground" objekt)
if (place_meeting(x + xspd, y, collision)) {
    while (!place_meeting(x + sign(xspd), y, collision)) {
        x += sign(xspd);
    }
    xspd = 0;
}
x += xspd;

if (place_meeting(x, y + yspd, collision)) {
    while (!place_meeting(x, y + sign(yspd), collision)) {
        y += sign(yspd);
    }
    yspd = 0;
    isGrounded = true;
} else {
    isGrounded = false;
}
y += yspd;