extends Node2D

@export var camera : CharacterBody2D
@export var player : CharacterBody2D

var curr_trap : Trap
var trap : Trap
var trap_x
var trap_y
var arrow_dir : String

# Obstacles
var saw_trap := preload("res://scenes/traps/saw_trap.tscn")
var magic_trap := preload("res://scenes/traps/magic_trap.tscn")
var punch_trap := preload("res://scenes/traps/punch_trap.tscn")
var ceiling_trap := preload("res://scenes/traps/ceiling_trap.tscn")
var trap_types := [saw_trap, magic_trap, punch_trap, ceiling_trap]
var traps : Array[Trap]
var available_traps := []

var inputs := preload("res://scenes/input_manager.tscn")

func _ready():
	pass

func _process(delta):
	for trap in traps:
		if trap.position.x + get_viewport_rect().size.x < camera.position.x:
			traps.erase(trap)
			remove_child(trap)
	for trap in traps:
		if trap == player.anim_trap.get_parent():
			if !trap.animator.is_playing():
				trap.animator.play(trap.animation_name)

func trap_on_frame():
	if curr_trap:
		return (curr_trap.position.x > camera.position.x - get_viewport_rect().size.x/2)

func place_trap():
	trap.position = Vector2i(trap_x, trap_y)
	var new_input = inputs.instantiate()
	set_arrow_dir(trap.name)
	new_input.get_node("Arrow").play(arrow_dir)
	new_input.position.x = trap.position.x - 40
	new_input.position.y = trap.position.y 
	add_child(new_input)
	add_child(trap)
	traps.append(trap)

func set_arrow_dir(trap_name : String):
	if trap_name == "Saw_Trap":
		arrow_dir = "arrow_down"
	elif trap_name == "Magic_Trap":
		arrow_dir = "arrow_up"
	elif trap_name == "Ceiling_Trap":
		arrow_dir = "arrow_right"
	elif trap_name == "Punch_Trap":
		arrow_dir = "arrow_down"

func set_traps():
	available_traps = trap_types.duplicate()
	
	if curr_trap:
		for trap_type in trap_types:
			if trap_type.resource_path == curr_trap.scene_file_path:
				available_traps.erase(trap_type)
				break
	
	if player.curr_state == "Running" or player.curr_state == "Rolling":
		available_traps.erase(saw_trap)
	var trap_type = available_traps[randi() % available_traps.size()]
	trap = trap_type.instantiate()
	var trap_height = trap.get_node("Sprite2D").texture.get_height()
	var trap_scale = trap.get_node("Sprite2D").scale
	
	trap_x = camera.position.x + get_viewport_rect().size.x
	trap_y = get_viewport_rect().size.y - (trap_height * trap_scale.y/2)
	curr_trap = trap
	place_trap()
	
