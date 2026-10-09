draw_set_color(c_black);
if global.pause{
	x = camera_get_view_x(view_camera[0]) + 1920/2
	y = camera_get_view_y(view_camera[0]) + 1080/4*2.5
} else{
	x = -300
	}