extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $sprites
@onready var aimPreview: Line2D = $aimPreview
@onready var particles: Node2D = $particles

var speed: float = 80	
var gravity = 10
var max_gravity = 400
var jump_hight = -170
var fall_particle: bool = false

func _input(_event):
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_hight
		sprite.play("jump_up")
	
	if Input.is_action_pressed("aim"):
		aimPreview.previewThrow(get_local_mouse_position().normalized(), 10, 1)
	elif Input.is_action_just_released("aim"):
		aimPreview.clear_points()

func _physics_process(_delta):
	if velocity.y < max_gravity:
		velocity.y += gravity
	
	if Input.is_action_pressed("ui_left"):
		sprite.flip_h = true
	if Input.is_action_pressed("ui_right"):
		sprite.flip_h = false
	
	if is_on_floor():
		movementOnFloor()
	else:
		movementOnAir()
	
	Global.player_velocity = velocity
	move_and_slide()

func movementOnAir():
	var movement = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")) * speed
	velocity.x = lerp(velocity.x, movement, 0.1)
	
	if velocity.y < 0 and sprite.animation != "jump_up":
		sprite.play("jump_up")
	if velocity.y > 0 and sprite.animation != "jump_down":
		sprite.play("jump_down")
	fall_particle = true

func movementOnFloor():
	if velocity.x >= -speed and velocity.x <= speed:
		velocity.x = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")) * speed
	else:
		velocity.x = lerp(velocity.x, Vector2.ZERO.x, .02)
	
	if fall_particle:
		particles.startParticle("landing")
		fall_particle = false
	if velocity.x != 0:
		sprite.play("running")
		particles.startParticle("running")
	if velocity.x == 0:
		sprite.play("idle")
		particles.stopParticle("running")

