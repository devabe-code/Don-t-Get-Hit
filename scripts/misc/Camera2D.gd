extends Camera2D

@export var player : CharacterBody2D

var player_to_screen : int

func _process(delta):
	player_to_screen = player.get_global_transform_with_canvas().get_origin().x
	check_speed()

func check_speed():
	print(player_to_screen)
	if (player_to_screen > get_viewport().size.x/2):
		print("great")
		position.x += .5
