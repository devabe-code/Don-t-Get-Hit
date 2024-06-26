extends Node2D

@export var player : CharacterBody2D

var screen_size : Vector2i
var ground_1 : TileMap
var ground_2 : TileMap
var curr_ground : TileMap

func _ready():
	screen_size = get_window().size
	ground_1 = get_tree().get_first_node_in_group("Ground")
	ground_2 = get_tree().get_first_node_in_group("Ground2")
	curr_ground = ground_1

func _process(_delta):
	if (player and curr_ground):
		if player.position.x - curr_ground.position.x > screen_size.x/4:
			curr_ground.position.x += screen_size.x/2
			switch_ground()
		if player.position.x - curr_ground.position.x < -screen_size.x/2:
			curr_ground.position.x -= screen_size.x/2
			switch_ground()

func switch_ground():
	if (curr_ground == ground_1):
		curr_ground = ground_2
	else:
		curr_ground = ground_1
