pausebuttom = keyboard_check_pressed(vk_escape)

if (pausebuttom){
if (global.pause == true){
global.pause = false
}
else{
global.pause = true
}
}

if (global.pause == false){

var _dt = delta_time / 1000000;

rightKey = keyboard_check(ord("D")) or keyboard_check(vk_right);
leftKey = keyboard_check(ord("A")) or keyboard_check(vk_left);
jumpKey = keyboard_check_pressed(ord("W")) or keyboard_check_pressed(ord(" ")) or keyboard_check_pressed(vk_up);
upKeyHeld = keyboard_check(ord("W")) or keyboard_check(vk_up) or keyboard_check(ord(" "));
downKey = keyboard_check(ord("S")) or keyboard_check(vk_down);
secretKey = keyboard_check(ord("O"));

collision = [obj_ground, obj_ground2]

// Vines - ligesom i Minecraft: hold op/ned for at klatre, lav gravity, billig stamina
var _touchingVine = place_meeting(x, y, obj_vines);
isClimbing = _touchingVine && (upKeyHeld || downKey);

isClimbing = _touchingVine;

if (isClimbing) 
{
    var _vertKey = downKey - upKeyHeld;

    if (_vertKey != 0){
        yspd = _vertKey * climbSpd;
		staminaRegenTimer = _staminaRegenDelay;

        if (stamina > 0) {
            stamina -= climbStaminaDrain * _dt;
        }
    } 
	else {
        yspd = vineSlideSpd;
    }

} 
else {
    yspd += grav;
    yspd = min(yspd, maxFallSpd);
}

if (cameraState == "intro") {
    xspd = 0;
    yspd = 0;
} else {
    // Horizontal movement
    var _horizKey = rightKey - leftKey;
    xspd = _horizKey * moveSpd;

    // Jump code
    if (jumpKey && isGrounded && stamina >= staminaDrainPerJump) {
        yspd = -jumpSpd;
        isGrounded = false;
        isClimbing = false;
        stamina -= staminaDrainPerJump;
        staminaRegenTimer = _staminaRegenDelay;
    }
}
// dev tool husk at fjern
if (secretKey) {
    yspd = -jumpSpd * 0.5
}

// Regen kun når man IKKE lige har brugt stamina, og man rører jorden
if (staminaRegenTimer > 0) {
    staminaRegenTimer -= _dt;
} else if (isGrounded) {
    stamina += _staminaRegenSpd * _dt;
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
    if yspd > 0{
		isGrounded = true;
	}
	
	yspd = 0;
    CoyoteTimer = CoyoteMAX;
} else {
    if (CoyoteTimer > 0) {
        CoyoteTimer -= _dt
    } else {
        isGrounded = false;
    }
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
}