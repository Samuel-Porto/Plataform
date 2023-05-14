extends StaticBody2D

@onready var timer: Timer = $Timer
@onready var collision: CollisionShape2D = $collision
@onready var sprite: AnimatedSprite2D = $sprite

func body_entered(body):
	if body is CharacterBody2D and sprite.frame == 0:
		sprite.play("animation")
		await sprite.animation_finished
		collision.set_deferred("disabled", true)
		timer.start(2)
		


func _on_timer_timeout():
	sprite.frame = 0
	collision.set_deferred("disabled", false)
