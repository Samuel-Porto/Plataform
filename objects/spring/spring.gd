extends StaticBody2D


func _ready():
	$sprites.play("idle")
	$area.monitoring = true

func pull(body):
	if body is CharacterBody2D:
		
		body.velocity.y = -225
		$sprites.play("pulling")
