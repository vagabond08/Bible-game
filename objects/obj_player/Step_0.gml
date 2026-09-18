rightKey = keyboard_check(ord("D")) or keyboard_check(vk_right);
leftKey = keyboard_check(ord("A")) or keyboard_check(vk_left);
upKey = keyboard_check(ord("W")) or keyboard_check(vk_up);
downKey = keyboard_check(ord("S")) or keyboard_check(vk_down);

// Player movement
#region 
    // Get the direction
    var _horizKey = rightKey - leftKey;
    var _vertKey = downKey - upKey;
    moveDir = point_direction(0, 0, _horizKey, _vertKey);

    // Get the x and speeds
    var _spd = 0;
    var _inputLevel = point_distance(0, 0, _horizKey, _vertKey);
    _inputLevel = clamp(_inputLevel, 0, 1);
    _spd = moveSpd * _inputLevel;

    xspd = lengthdir_x(_spd, moveDir);
    yspd = lengthdir_y(_spd, moveDir);

// Move the player
    x += xspd;
    y += yspd;
