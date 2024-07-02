extends CharacterBody2D

@export var player : CharacterBody2D

var screen_scale : int

func _process(_delta):
	screen_scale = get_window().size.x / get_viewport_rect().size.x
	velocity.x = player.MOVE_SPEED
	move_and_slide()
	check_speed()

func check_speed():
	if (player.player_to_screen * screen_scale > get_viewport().size.x/2):
		position.x += .25
	elif (player.player_to_screen * screen_scale < get_viewport().size.x/10):
		position.x -= .25
