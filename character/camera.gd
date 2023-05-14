extends Camera2D


@onready var camera_lists: Array = get_parent().get_parent().camera_sizes
@onready var player: CharacterBody2D = get_parent()

func _ready():
	set_limits(camera_lists[0])

func _physics_process(_delta):
	check_if_in_limit()

func set_limits(list: Array):
	limit_left = list[0]
	limit_top = list[1]
	limit_right = list[0] + list[2]
	limit_bottom = list[1] + list[3]

func check_if_in_limit():
	if player.position.x > limit_right or player.position.x < limit_left or player.position.y > limit_bottom or player.position.y < limit_top:
		for sizes in camera_lists:
			if player.position.x > sizes[0] and player.position.x < sizes[0] + sizes[2] and player.position.y > sizes[1] and player.position.y < sizes[1] + sizes[3]:
				set_limits(sizes)
