// Variables for movement
moveSpd = 4;
jumpSpd = 10;
grav = 0.5;
maxFallSpd = 24;

xspd = 0;
yspd = 0;

isGrounded = false;

// Stamina
staminaMax = 100;
stamina = staminaMax;
staminaDrainPerJump = 10;   // koster ved hvert hop/klatre-træk
staminaRegenSpd = 0.5;      // pr. frame når man regenererer
staminaRegenDelay = 120;     // frames man skal vente efter sidste brug, før regen starter
staminaRegenTimer = 0;

staminaDisplay = stamina;   // bruges til smooth bar-animation
staminaBarShakeAmount = 0;  // lille shake-effekt når man er ved at løbe tør

cameraState = "intro";

var _viewH = camera_get_view_height(view_camera[0]);
introStartY = 0;
introEndY = clamp(y - _viewH * 0.7, 0, room_height - _viewH);
introSpd = 0.02;
introProgress = 0;

camera_set_view_pos(view_camera[0], 0, introStartY);


    //tilecollision = layer_tilemap_get_id("Tiles_walls")