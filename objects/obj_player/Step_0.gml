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

// Camera follow - kun vertikalt
#region Camera
    var _viewW = camera_get_view_width(view_camera[0]);
    var _viewH = camera_get_view_height(view_camera[0]);

    // X er altid centreret/fast - vis hele bjergets bredde
    var _camX = 0; // eller room_width/2 - _viewW/2 hvis du vil centrere

    // Y følger spilleren, med et offset så de ikke sidder helt i bunden
    var _targetY = obj_player.y - _viewH * 0.7;

    // Clamp så kameraet ikke scroller udenfor rummet foroven/forneden
    _targetY = clamp(_targetY, 0, room_height - _viewH);

    // Smooth follow (lerp) i stedet for hård snap
    var _camY = camera_get_view_y(view_camera[0]);
    _camY += (_targetY - _camY) * 0.1;

    camera_set_view_pos(view_camera[0], _camX, _camY);
#endregion