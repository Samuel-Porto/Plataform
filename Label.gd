extends Label


func _physics_process(_delta):
	text = "vel: (%.0f, %.0f)\n" % [Global.player_velocity.x, Global.player_velocity.y]
