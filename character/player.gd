extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $sprites
@onready var particles: Node2D = $particles
@onready var wall_collision: RayCast2D = $wall_collision

var speed: float = 80	
var gravity = 10
var max_gravity = 400
var jump_hight = -170
var fall_particle: bool = false
var looking: int = 1
var wall_distance: Vector2 = Vector2(7, 0)
var inertia: int = 0
var is_dead: bool = false

func _input(_event):
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_hight + inertia

func _physics_process(_delta):
	Global.looking = looking
	Global.player_velocity = velocity
	Global.inertia = inertia
	
	if velocity.y < max_gravity:
		velocity.y += gravity

	if sprite.flip_h:
		looking = -1
	else:
		looking = 1
	
	if not is_on_wall():
		if Input.is_action_pressed("ui_left"):
			sprite.flip_h = true
		if Input.is_action_pressed("ui_right"):
			sprite.flip_h = false
		wall_collision.target_position = wall_distance * looking
	
	if is_on_floor() and not is_dead:
		movementOnFloor()
	elif wall_collision.is_colliding() and not is_dead:
		movementOnWall()
	else:
		movementOnAir()
	
	move_and_slide()

func movementOnFloor():
	if velocity.x >= -speed and velocity.x <= speed:
		velocity.x = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")) * speed
	else:
		velocity.x = lerp(velocity.x, Vector2.ZERO.x, .02)
	
	if fall_particle:
		particles.startParticle("landing")
		fall_particle = false
	if not is_dead:
		if velocity.x != 0:
			sprite.play("running")
			particles.startParticle("running")
		if velocity.x == 0:
			sprite.play("idle")
			particles.stopParticle("running")

func movementOnAir():
	var movement = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")) * speed
	velocity.x = lerp(velocity.x, movement, 0.1)
	
	particles.stopParticle("running")
	if not is_dead:
		if velocity.y < 0 and sprite.animation != "jump_up":
			sprite.play("jump_up")
		if velocity.y > 0 and sprite.animation != "jump_down":
			sprite.play("jump_down")
	fall_particle = true

func movementOnWall():
	if (Input.is_action_pressed("ui_left") and looking < 0) or (Input.is_action_pressed("ui_right") and looking > 0):
		sprite.play("on_wall")
		if velocity.y >= 20:
			velocity.y = 20
	elif sprite.animation != "jump_down":
		sprite.play("jump_down")
	if Input.is_action_just_pressed("jump"):
		velocity = Vector2(jump_hight*looking, jump_hight*.8)
		sprite.flip_h = !sprite.flip_h


func dead():
	is_dead = true
	$collision.set_deferred("disabled", true)
	var tween = create_tween()
	sprite.play("dead")
	if velocity == Vector2.ZERO:
		velocity = Vector2(1, 1)
	tween.tween_property(self, "position", position+velocity.normalized()*-25, .5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	await tween.finished
	position = Global.respawn
	$collision.set_deferred("disabled", false)
	is_dead = false
