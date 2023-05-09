extends Line2D


func previewThrow(dir: Vector2, spd: float, grav: float):
	var max_points = 20
	clear_points()
	
	var pos = Vector2.ZERO
	var vel = dir * spd
	
	for point in max_points:
		add_point(pos)
		vel.y += grav
		pos += vel
		$object.position = pos
		
		var collision:KinematicCollision2D = $object.move_and_collide(vel, true)
		if collision:
			add_point(collision.get_position() - global_position)
			return
		
