var _barX = 30;
var _barY = 60;
var _barW = 24;
var _barH = 160;

var _shakeX = random_range(-staminaBarShakeAmount, staminaBarShakeAmount);

// Baggrund / kasse (matcher den grå ramme fra skitsen)
draw_set_color(c_black);
draw_rectangle(_barX - 3 + _shakeX, _barY - 3, _barX + _barW + 3, _barY + _barH + 3, false);

draw_set_color(c_dkgray);
draw_rectangle(_barX + _shakeX, _barY, _barX + _barW, _barY + _barH, false);

// Fyld nedefra og op
var _fillRatio = staminaDisplay / staminaMax;
var _fillH = _barH * _fillRatio;

// Farve skifter fra grøn -> gul -> rød alt efter niveau
var _fillColor;
if (_fillRatio > 0.5) {
    _fillColor = merge_color(c_yellow, c_lime, (_fillRatio - 0.5) * 2);
} else {
    _fillColor = merge_color(c_red, c_yellow, _fillRatio * 2);
}

draw_set_color(_fillColor);
draw_rectangle(
    _barX + _shakeX, 
    _barY + (_barH - _fillH), 
    _barX + _barW + _shakeX, 
    _barY + _barH, 
    false
);

draw_set_color(c_white);