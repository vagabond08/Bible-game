rightKey = keyboard_check(ord("D")) or keyboard_check(vk_right);
leftKey = keyboard_check(ord("A")) or keyboard_check(vk_left);
jumpKey = keyboard_check(ord("W")) or keyboard_check(ord(" ")) or keyboard_check(vk_up);

collision = [obj_ground, obj_ground2]

// Gravity
yspd += grav;
yspd = min(yspd, maxFallSpd);

if (cameraState == "intro") {
    xspd = 0;
    yspd = 0;
} else {
    // Horizontal movement
var _horizKey = rightKey - leftKey;
xspd = _horizKey * moveSpd;

// Jump / climb kræver stamina
if (jumpKey && isGrounded && stamina >= staminaDrainPerJump) {
    yspd = -jumpSpd;
    isGrounded = false;
    stamina -= staminaDrainPerJump;
    staminaRegenTimer = staminaRegenDelay;
}
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

// Camera follow - kun vertikalt
#region Camera
    var _viewW = camera_get_view_width(view_camera[0]);
    var _viewH = camera_get_view_height(view_camera[0]);
    var _camX = 0;

    if (cameraState == "intro") {
        introProgress += introSpd;
        introProgress = clamp(introProgress, 0, 1);
        var _t = introProgress;
        var _eased = _t * _t * (3 - 2 * _t);
        var _camY = lerp(introStartY, introEndY, _eased);
        camera_set_view_pos(view_camera[0], _camX, _camY);
        if (introProgress >= 1) cameraState = "follow";
    }
    else if (cameraState == "follow") {
        var _targetY = clamp(y - _viewH * 0.7, 0, room_height - _viewH);
        var _camY = camera_get_view_y(view_camera[0]);
        _camY += (_targetY - _camY) * 0.1;
        camera_set_view_pos(view_camera[0], _camX, _camY);
    }
#endregion