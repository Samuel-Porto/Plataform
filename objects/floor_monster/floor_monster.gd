extends StaticBody2D

@export var end_point: Vector2 = Vector2.ZERO

@onready var sprite: AnimatedSprite2D = $sprites
var tween
var initial_position: Vector2

func _ready():
	
	while true:
		sprite.play("running")
		sprite.flip_h = false
		tween = create_tween()
		tween.tween_property(self, "position", position+end_point, 1).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
		await tween.finished
		sprite.play("flip")
		await sprite.animation_finished
		sprite.play("running")
		sprite.flip_h = true
		tween = create_tween()
		tween.tween_property(self, "position", position-end_point, 1).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
		await tween.finished
		sprite.play("flip")
		await sprite.animation_finished


func body_entered(body):
	if body is CharacterBody2D:
		body.dead()
