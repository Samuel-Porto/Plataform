extends Label


func _input(_event):
	if Input.is_action_just_pressed("debug"):
		if self.is_visible_in_tree():
			hide()
		else:
			show()
	

func _physics_process(_delta):
	text = "vel: (%.0f, %.0f)
	respawn: %s
	inertia: %s
	looking: %s" % [Global.player_velocity.x, Global.player_velocity.y, Global.respawn, Global.inertia, Global.looking]
	
