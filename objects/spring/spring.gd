extends StaticBody2D


func _ready():
	$sprites.play("idle")
	$area.monitoring = true

func pull(body):
	if body is CharacterBody2D:
		var tween = create_tween()
		await tween.tween_property(body, "position", Vector2(position.x, body.position.y), .05).finished
		body.velocity.y = -225
		$sprites.play("pulling")
		await $sprites.animation_finished
		$sprites.play("idle")
