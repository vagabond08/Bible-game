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


    //tilecollision = layer_tilemap_get_id("Tiles_walls")