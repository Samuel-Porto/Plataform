extends Node

var player_velocity
var respawn: Vector2 = Vector2(39, 136)
var inertia
var looking

func _input(_event):
	if Input.is_action_just_pressed("full_screen"):
		if DisplayServer.window_get_mode() != 3:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
